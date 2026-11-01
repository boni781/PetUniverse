"""Interactive PetUniverse Windows release builder.

Follows the supplied release workflow: version selection, metadata sync,
validation, Windows build, runtime ZIP, installer/checksum/manifest generation,
then optional Git commit/push and GitHub Release publication. No Inno Setup.
"""

from __future__ import annotations

import hashlib
import json
import os
import re
import shutil
import subprocess
import zipfile
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parent
CONFIG_FILE = ROOT / "release_config.json"
RELEASE_OUTPUT = ROOT / "release-output"
INSTALLER_TEMPLATE = ROOT / "installer" / "install_windows.ps1"
UPDATE_HELPER = ROOT / "updater" / "apply_update.ps1"


def split_repository(value: str) -> tuple[str, str]:
    parts = value.strip().split("/")
    if len(parts) != 2 or not all(parts):
        raise ValueError(f"Repository tidak valid: {value!r}; gunakan owner/repo.")
    return parts[0], parts[1]


def load_config() -> dict[str, Any]:
    if not CONFIG_FILE.is_file():
        raise FileNotFoundError(f"Konfigurasi tidak ditemukan: {CONFIG_FILE}")
    config = json.loads(CONFIG_FILE.read_text(encoding="utf-8-sig"))
    required = (
        "source_repository", "release_repository", "git_remote",
        "git_branch", "app_directory", "windows_arch", "executable_name",
    )
    missing = [key for key in required if not str(config.get(key, "")).strip()]
    if missing:
        raise ValueError("release_config.json belum lengkap: " + ", ".join(missing))
    config["_app_dir"] = (ROOT / str(config["app_directory"])).resolve()
    config["_source_owner"], config["_source_repo"] = split_repository(
        str(config["source_repository"])
    )
    config["_release_owner"], config["_release_repo"] = split_repository(
        str(config["release_repository"])
    )
    return config


def run_command(
    command: list[str],
    cwd: Path,
    *,
    capture: bool = False,
    check: bool = True,
) -> subprocess.CompletedProcess[str]:
    print("\n>", subprocess.list2cmdline([str(item) for item in command]))
    result = subprocess.run(
        [str(item) for item in command],
        cwd=str(cwd),
        text=True,
        capture_output=capture,
        errors="replace",
        check=False,
    )
    if capture and result.stdout:
        print(result.stdout.rstrip())
    if check and result.returncode != 0:
        details = ((result.stdout or "") + (result.stderr or "")).strip() if capture else ""
        raise RuntimeError(
            f"Perintah gagal (exit code {result.returncode}): "
            + subprocess.list2cmdline([str(item) for item in command])
            + (f"\n{details}" if details else "")
        )
    return result


def ask(label: str, default: str = "") -> str:
    suffix = f" [{default}]" if default else ""
    return input(f"{label}{suffix}: ").strip() or default


def parse_version(version: str) -> tuple[int, int, int]:
    value = version.strip().lstrip("vV")
    match = re.fullmatch(r"(\d+)\.(\d+)\.(\d+)", value)
    if not match:
        raise ValueError(f"Versi tidak valid: {version!r}. Gunakan MAJOR.MINOR.PATCH.")
    return tuple(int(part) for part in match.groups())


def next_version(current: str, mode: str) -> str:
    major, minor, patch = parse_version(current)
    if mode == "1":
        patch += 1
    elif mode == "2":
        minor += 1
        patch = 0
    elif mode == "3":
        major += 1
        minor = patch = 0
    else:
        raise ValueError("Pilihan versi tidak valid.")
    return f"{major}.{minor}.{patch}"


def read_current_version(app_dir: Path) -> tuple[str, int]:
    pubspec = app_dir / "pubspec.yaml"
    text = pubspec.read_text(encoding="utf-8-sig")
    match = re.search(
        r"(?m)^version:\s*['\"]?(\d+\.\d+\.\d+)\+(\d+)['\"]?\s*$",
        text,
    )
    if not match:
        raise ValueError("Versi pubspec.yaml harus memakai format seperti 0.1.0+1.")
    return match.group(1), int(match.group(2))


def write_version_manifest(path: Path, version: str, build_number: int) -> None:
    data = {
        "name": "PetUniverse",
        "version": version,
        "build": build_number,
        "channel": "stable",
        "platform": "windows-x64",
    }
    path.write_text(json.dumps(data, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")


def sync_metadata(
    app_dir: Path,
    version: str,
    build_number: int,
    title: str,
    notes: str,
) -> list[Path]:
    changed: list[Path] = []

    pubspec = app_dir / "pubspec.yaml"
    updated, count = re.subn(
        r"(?m)^(version:\s*)['\"]?\d+\.\d+\.\d+\+\d+['\"]?\s*$",
        f"version: {version}+{build_number}",
        pubspec.read_text(encoding="utf-8-sig"),
        count=1,
    )
    if count != 1:
        raise ValueError("Baris version di app/pubspec.yaml tidak ditemukan.")
    pubspec.write_text(updated, encoding="utf-8")
    changed.append(pubspec)

    version_file = app_dir / "lib" / "core" / "app_version.dart"
    text = version_file.read_text(encoding="utf-8-sig")
    text, version_count = re.subn(
        r"(?m)^(\s*static const String version = )['\"][^'\"]+['\"];",
        lambda match: f"{match.group(1)}'{version}';",
        text,
        count=1,
    )
    text, build_count = re.subn(
        r"(?m)^(\s*static const int buildNumber = )\d+;",
        lambda match: f"{match.group(1)}{build_number};",
        text,
        count=1,
    )
    if version_count != 1 or build_count != 1:
        raise ValueError("Konstanta versi/buildNumber tidak ditemukan di app_version.dart.")
    version_file.write_text(text, encoding="utf-8")
    changed.append(version_file)

    manifest = ROOT / "version.json"
    write_version_manifest(manifest, version, build_number)
    changed.append(manifest)

    changelog = ROOT / "CHANGELOG.md"
    old = changelog.read_text(encoding="utf-8-sig") if changelog.exists() else "# Changelog\n"
    tag = f"v{version}"
    if not re.search(rf"(?m)^##\s+{re.escape(tag)}(?:\s|$)", old):
        entry = f"## {tag} — {title}\n\n{notes.strip() or 'Pembaruan fitur dan perbaikan bug.'}\n\n"
        changelog.write_text(entry + old.lstrip(), encoding="utf-8")
        changed.append(changelog)

    print(f"[OK] APP_VERSION = {version}+{build_number}")
    print(f"[OK] version.json = {version}+{build_number}")
    return changed


def snapshot_files(paths: list[Path]) -> dict[Path, bytes | None]:
    return {path: path.read_bytes() if path.is_file() else None for path in paths}


def restore_files(snapshots: dict[Path, bytes | None]) -> None:
    for path, content in snapshots.items():
        if content is None:
            path.unlink(missing_ok=True)
        else:
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_bytes(content)


def preflight(project: Path, config: dict[str, Any]) -> None:
    if os.name != "nt":
        raise RuntimeError("Release Windows harus dijalankan dari Windows.")
    if not (project / ".git").exists():
        raise RuntimeError(f"Folder bukan working tree Git: {project}")
    for command in ("git", "gh", "flutter", "dart"):
        if not shutil.which(command):
            raise RuntimeError(f"{command} belum terpasang atau tidak ada di PATH.")
    if not (config["_app_dir"] / "windows" / "CMakeLists.txt").is_file():
        raise RuntimeError(
            "Target Windows Flutter belum tersedia di app/windows. Jalankan "
            "flutter create --platforms=windows . dari folder app. Perintah ini "
            "menambahkan scaffold Windows; periksa perubahan lokal sebelum commit."
        )
    run_command(["git", "rev-parse", "--is-inside-work-tree"], project, capture=True)
    auth = subprocess.run(
        ["gh", "auth", "status"], cwd=project, text=True, capture_output=True,
        errors="replace", check=False,
    )
    if auth.returncode != 0:
        raise RuntimeError("GitHub CLI belum login. Jalankan gh auth login.\n" + (auth.stderr or auth.stdout))
    print(f"[OK] Source repository : {config['source_repository']}")
    print(f"[OK] Release repository: {config['release_repository']}")
    print("[OK] Git, GitHub CLI, Flutter, dan Dart siap.")


def git_status(project: Path) -> None:
    result = subprocess.run(
        ["git", "status", "--short"], cwd=project, capture_output=True,
        text=True, errors="replace", check=False,
    )
    print("\nGit status sebelum release:")
    print(result.stdout.rstrip() or "(working tree bersih)")


def ensure_release_tag_unused(config: dict[str, Any], tag: str) -> None:
    result = subprocess.run(
        ["gh", "release", "view", tag, "--repo", str(config["release_repository"])],
        cwd=ROOT, text=True, capture_output=True, errors="replace", check=False,
    )
    if result.returncode == 0:
        raise RuntimeError(f"GitHub Release {tag} sudah ada.")


def release_visibility(config: dict[str, Any]) -> str:
    result = run_command(
        [
            "gh", "repo", "view", str(config["release_repository"]),
            "--json", "visibility", "--jq", ".visibility",
        ],
        ROOT,
        capture=True,
    )
    return (result.stdout or "").strip().upper()


def build_and_test(
    app_dir: Path,
    version: str,
    build_number: int,
    config: dict[str, Any],
) -> Path:
    print("\nSTEP 1/5 - Instal dependensi")
    run_command(["flutter", "pub", "get"], app_dir)

    print("\nSTEP 2/5 - Generate kode Drift")
    run_command(["dart", "run", "build_runner", "build"], app_dir)

    print("\nSTEP 3/5 - Analyzer")
    run_command(["flutter", "analyze", "--fatal-infos"], app_dir)

    print("\nSTEP 4/5 - Seluruh pengujian")
    run_command(["flutter", "test"], app_dir)

    print("\nSTEP 5/5 - Build Windows Release")
    owner, repository = split_repository(str(config["release_repository"]))
    run_command(
        [
            "flutter", "build", "windows", "--release",
            "--build-name", version,
            "--build-number", str(build_number),
            f"--dart-define=PETUNIVERSE_UPDATE_OWNER={owner}",
            f"--dart-define=PETUNIVERSE_UPDATE_REPOSITORY={repository}",
        ],
        app_dir,
    )

    build_dir = (
        app_dir / "build" / "windows" / str(config["windows_arch"])
        / "runner" / "Release"
    )
    if not build_dir.is_dir():
        raise FileNotFoundError(f"Folder hasil build tidak ditemukan: {build_dir}")

    executable = str(config["executable_name"])
    if not (build_dir / executable).is_file():
        candidates = [
            item.name for item in build_dir.glob("*.exe")
            if item.name.lower() != "flutter_tester.exe"
        ]
        if len(candidates) != 1:
            raise FileNotFoundError(
                f"{executable} tidak ditemukan; kandidat executable: {candidates}"
            )
        config["executable_name"] = candidates[0]
    return build_dir


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def create_assets(
    build_dir: Path,
    version: str,
    build_number: int,
    title: str,
    config: dict[str, Any],
) -> dict[str, Path]:
    for required in (INSTALLER_TEMPLATE, UPDATE_HELPER):
        if not required.is_file():
            raise FileNotFoundError(f"File pendukung tidak ditemukan: {required}")

    RELEASE_OUTPUT.mkdir(parents=True, exist_ok=True)
    stage = RELEASE_OUTPUT / "package"
    if stage.exists():
        shutil.rmtree(stage)
    shutil.copytree(build_dir, stage)

    helper = stage / "updater" / "apply_update.ps1"
    helper.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(UPDATE_HELPER, helper)

    executable = str(config["executable_name"])
    if not (stage / executable).is_file():
        raise FileNotFoundError(f"Executable {executable} tidak ditemukan.")
    if not (stage / "data").is_dir():
        raise FileNotFoundError("Folder data tidak ditemukan; build Flutter tidak lengkap.")

    (stage / "PETUNJUK.txt").write_text(
        "PetUniverse untuk Windows\n"
        f"Versi: {version} (build {build_number})\n\n"
        "Pertahankan semua file DLL dan folder data di samping executable.\n"
        "Data pengguna disimpan terpisah dari folder program.\n",
        encoding="utf-8",
    )

    tag = f"v{version}"
    asset_name = f"PetUniverse-Windows-x64-{tag}.zip"
    zip_path = RELEASE_OUTPUT / asset_name
    zip_path.unlink(missing_ok=True)
    with zipfile.ZipFile(
        zip_path, "w", zipfile.ZIP_DEFLATED, compresslevel=8
    ) as archive:
        for path in sorted(stage.rglob("*")):
            if path.is_file():
                archive.write(path, path.relative_to(stage))

    if not zipfile.is_zipfile(zip_path):
        raise RuntimeError("ZIP runtime gagal divalidasi.")
    with zipfile.ZipFile(zip_path, "r") as archive:
        names = archive.namelist()
        if executable not in names or not any(name.startswith("data/") for name in names):
            raise RuntimeError("ZIP tidak berisi executable dan folder data.")

    package_hash = sha256_file(zip_path)
    checksum_path = RELEASE_OUTPUT / "SHA256SUMS.txt"
    checksum_path.write_text(f"{package_hash}  {asset_name}\n", encoding="utf-8")

    package_url = (
        f"https://github.com/{config['release_repository']}/releases/download/"
        f"{tag}/{asset_name}"
    )
    installer_text = INSTALLER_TEMPLATE.read_text(encoding="utf-8-sig")
    replacements = {
        "__APP_VERSION__": version,
        "__EXECUTABLE_NAME__": executable,
        "__PACKAGE_URL__": package_url,
        "__PACKAGE_SHA256__": package_hash,
    }
    for placeholder, value in replacements.items():
        installer_text = installer_text.replace(placeholder, value)
    if re.search(r"__[A-Z0-9_]+__", installer_text):
        raise RuntimeError("Masih terdapat placeholder pada installer.")
    installer_path = RELEASE_OUTPUT / f"PetUniverse-Setup-{tag}.ps1"
    installer_path.write_text(installer_text, encoding="utf-8")

    manifest_path = RELEASE_OUTPUT / f"PetUniverse-version-{tag}.json"
    manifest = {
        "name": "PetUniverse",
        "version": version,
        "build": build_number,
        "tag": tag,
        "platform": "windows-x64",
        "asset": asset_name,
        "sha256": package_hash,
        "release_repository": config["release_repository"],
        "title": title,
    }
    manifest_path.write_text(
        json.dumps(manifest, indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
    )

    return {
        "zip": zip_path,
        "installer": installer_path,
        "checksums": checksum_path,
        "manifest": manifest_path,
    }


def commit_and_push(
    changed_files: list[Path],
    config: dict[str, Any],
    version: str,
) -> None:
    print("\nCommit dan push metadata versi...")
    relative = [str(path.relative_to(ROOT)) for path in changed_files if path.is_file()]
    run_command(["git", "add", "--", *relative], ROOT)
    staged = subprocess.run(["git", "diff", "--cached", "--quiet"], cwd=ROOT, check=False)
    if staged.returncode == 0:
        print("[INFO] Tidak ada metadata baru untuk di-commit.")
        return
    run_command(["git", "commit", "-m", f"Release PetUniverse v{version}"], ROOT)
    run_command(
        ["git", "push", str(config["git_remote"]), f"HEAD:{config['git_branch']}"],
        ROOT,
    )


def publish_release(
    assets: dict[str, Path],
    config: dict[str, Any],
    version: str,
    title: str,
    notes: str,
) -> None:
    command = [
        "gh", "release", "create", f"v{version}",
        str(assets["zip"]),
        str(assets["installer"]),
        str(assets["checksums"]),
        str(assets["manifest"]),
        "--repo", str(config["release_repository"]),
        "--title", title,
        "--notes", notes,
    ]
    if str(config["source_repository"]).lower() == str(config["release_repository"]).lower():
        command.extend(["--target", str(config["git_branch"])])
    run_command(command, ROOT)


def main() -> int:
    print("\n========================================")
    print("      PETUNIVERSE RELEASE BUILDER")
    print("========================================\n")

    config = load_config()
    app_dir = Path(config["_app_dir"])
    current_version, current_build = read_current_version(app_dir)

    print(f"Project          : {ROOT}")
    print(f"Source repository: {config['source_repository']}")
    print(f"Release repository: {config['release_repository']}")
    print(f"Versi saat ini   : {current_version}+{current_build}")

    print("\nPilih jenis versi:")
    print("1. Patch")
    print("2. Minor")
    print("3. Major")
    print("4. Manual")
    print("0. Batal")
    choice = input("\nPilihan: ").strip()

    if choice == "0":
        print("Release dibatalkan.")
        return 0
    if choice in {"1", "2", "3"}:
        version = next_version(current_version, choice)
    elif choice == "4":
        version = ask("Masukkan versi baru", current_version).lstrip("vV")
        parse_version(version)
    else:
        print("Pilihan tidak valid.")
        return 2

    if parse_version(version) <= parse_version(current_version):
        print("Versi baru harus lebih tinggi daripada versi saat ini.")
        return 2

    build_number = current_build + 1
    title = ask("Judul release", f"PetUniverse v{version}")
    notes = ask("Catatan release", "Pembaruan fitur dan perbaikan bug.")
    tag = f"v{version}"

    print("\n========================================")
    print(" KONFIRMASI RELEASE")
    print("========================================")
    print(f"Versi lama : {current_version}+{current_build}")
    print(f"Versi baru : {version}+{build_number}")
    print(f"Tag        : {tag}")
    print(f"Judul      : {title}")
    print(f"Release    : {config['release_repository']}")
    print("Platform   : Windows x64")
    print("Installer  : PowerShell, tanpa Inno Setup")
    if ask("Mulai build? Ketik YA", "TIDAK").upper() != "YA":
        print("Dibatalkan. Metadata belum diubah.")
        return 0

    preflight(ROOT, config)
    ensure_release_tag_unused(config, tag)
    git_status(ROOT)

    managed = [
        app_dir / "pubspec.yaml",
        app_dir / "lib" / "core" / "app_version.dart",
        ROOT / "version.json",
        ROOT / "CHANGELOG.md",
    ]
    snapshots = snapshot_files(managed)
    changed_files: list[Path] = []
    build_completed = False

    try:
        print("\nSinkronisasi metadata versi...")
        changed_files = sync_metadata(app_dir, version, build_number, title, notes)

        build_dir = build_and_test(app_dir, version, build_number, config)

        print("\nMembuat paket runtime ZIP, checksum, manifest, dan installer...")
        assets = create_assets(build_dir, version, build_number, title, config)
        build_completed = True

        print("\n========================================")
        print(" ASSET RELEASE")
        print("========================================")
        for label, path in assets.items():
            print(f"{label:10}: {path} ({path.stat().st_size:,} bytes)")

        visibility = release_visibility(config)
        if visibility != "PUBLIC":
            raise RuntimeError(
                f"Repository release berstatus {visibility or 'UNKNOWN'}. "
                "Updater tidak menyimpan token GitHub di dalam aplikasi; "
                "release asset harus dapat diunduh secara publik. Gunakan "
                "repository khusus release yang public atau ubah visibility "
                "repository release, lalu atur release_repository di "
                "release_config.json. Build lokal sudah selesai dan asset "
                f"tersedia di {RELEASE_OUTPUT}; metadata versi dipertahankan."
            )

        if ask("Commit, push, dan publish release? Ketik YA", "TIDAK").upper() != "YA":
            print(f"Build lokal selesai. Aset tersedia di {RELEASE_OUTPUT}")
            return 0

        commit_and_push(changed_files, config, version)
        publish_release(assets, config, version, title, notes)

        print("\n========================================")
        print(" RELEASE BERHASIL")
        print("========================================")
        print(f"Versi : {version}+{build_number}")
        print(f"Tag   : {tag}")
        print(f"URL   : https://github.com/{config['release_repository']}/releases/tag/{tag}")
        return 0

    except Exception as exc:
        print("\n========================================")
        print(" RELEASE BELUM DIPUBLIKASIKAN")
        print("========================================")
        print(f"{type(exc).__name__}: {exc}")
        if not build_completed:
            print("Build belum selesai; metadata versi dipulihkan.")
            restore_files(snapshots)
        else:
            print("Build lokal sudah selesai; metadata dipertahankan agar sesuai dengan aset.")
            print(f"Folder aset: {RELEASE_OUTPUT}")
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
