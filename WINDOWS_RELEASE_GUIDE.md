# PetUniverse Windows installer, updater, and release

This project uses a Windows runtime ZIP plus PowerShell scripts. It does not use
Inno Setup.

## Release architecture

The release builder is the root file `release.py`, configured by
`release_config.json`.

For each release it:

1. Offers Patch, Minor, Major, or Manual semantic version selection.
2. Increments the Flutter build number.
3. Synchronizes `app/pubspec.yaml`, `app/lib/core/app_version.dart`,
   `version.json`, and `CHANGELOG.md`.
4. Runs `flutter pub get`, Drift code generation, analyzer, and tests.
5. Builds Windows x64 in Release mode.
6. Packages the complete Flutter runner output, DLLs, `data/`, and the updater
   helper into `PetUniverse-Windows-x64-vX.Y.Z.zip`.
7. Generates a versioned PowerShell installer, a SHA-256 manifest, and a
   release metadata JSON file.
8. Shows the assets for review before committing/pushing version metadata and
   publishing a GitHub Release.

The ZIP is a **built application package**, not a source-code archive. Flutter's
Windows deployment output needs the executable, DLLs, and the `data` directory
together. See the
[Flutter Windows build and deployment guide](https://docs.flutter.dev/platform-integration/windows/building).

## Required Windows platform scaffold

The GitHub branch must contain `app/windows/`. If it is missing locally, run
this from the Flutter application directory:

```powershell
cd app
flutter create --platforms=windows .
```

Review the generated files, then commit the Windows platform scaffold to the
source repository. Do not overwrite existing custom Windows runner files.

The release builder checks for `app/windows/CMakeLists.txt` and stops before
changing version metadata if the Windows target is unavailable.

## GitHub release repository must be public

The updater intentionally does not embed a Personal Access Token or any other
GitHub secret inside the Windows application. It reads GitHub's latest-release
API and downloads the ZIP and checksum asset without asking the user to sign in.

Therefore, the repository configured as `release_repository` must expose
public release assets. A private source repository can remain private while
release assets are published to a separate public repository containing only
the compiled binaries and release metadata.

For example, create a separate public repository in GitHub named
`PetUniverse-Releases`, then edit `release_config.json`:

```json
{
  "source_repository": "boni781/PetUniverse",
  "release_repository": "boni781/PetUniverse-Releases",
  "git_remote": "origin",
  "git_branch": "feature/app-shell-dashboard",
  "app_directory": "app",
  "windows_arch": "x64",
  "executable_name": "pet_universe.exe"
}
```

The release builder refuses to publish if the configured release repository
is private. This prevents publishing a release that the in-app updater cannot
download. A public repository is not required to contain application source
code; only the versioned release assets are uploaded there.

GitHub documents that unauthenticated access is available for public release
resources, while private release reads require repository access:
[GitHub REST API — Releases](https://docs.github.com/en/rest/releases/releases).

## Prepare the workstation

Run these commands once, if the required tools are not already installed:

- Flutter SDK with the Windows desktop toolchain.
- Git for Windows.
- GitHub CLI (`gh`).

Authenticate the GitHub CLI:

```powershell
gh auth login
gh auth status
```

Make sure the Git working tree is in a known state. The release builder only
stages the version metadata files it owns; it does not stage all files or
automatically delete untracked local scaffolding.

## Build and publish

From the repository root on Windows:

```powershell
python release.py
```

Choose a version increment and review the title and release notes. The tool
runs code generation, analyzer, and all tests before building the Windows app.
It then creates these assets in `release-output/`:

| Asset | Purpose |
|---|---|
| `PetUniverse-Windows-x64-vX.Y.Z.zip` | Built application files used by installer and updater |
| `PetUniverse-Setup-vX.Y.Z.ps1` | User-level Windows installer |\n| `PetUniverse-Setup-vX.Y.Z.cmd` | Double-click launcher for the PowerShell installer |
| `SHA256SUMS.txt` | ZIP integrity check |
| `PetUniverse-version-vX.Y.Z.json` | Machine-readable release manifest |

After reviewing the assets, confirm publication. The builder pushes only the
managed version metadata to the configured source branch and uploads the
release assets to `release_repository`.

If the release repository is private, local build artifacts are retained but
publication is blocked until the repository visibility/configuration is fixed.

## Install PetUniverse

Download the versioned Setup PowerShell file from the GitHub Release, then run
PowerShell:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\PetUniverse-Setup-vX.Y.Z.ps1
```

The `.cmd` launcher and `.ps1` file must be placed in the same folder. Double-click the `.cmd` file or run the PowerShell command below. The installer downloads the matching runtime ZIP, verifies SHA-256, and installs
to:

`%LOCALAPPDATA%\Programs\PetUniverse`

It creates Start Menu and Desktop shortcuts. It also checks for the Microsoft
Visual C++ x64 runtime and, if required, downloads the signed installer from
Microsoft's official distribution endpoint.

The installer does not need Inno Setup and does not install into Program Files.

## Check and apply updates in the app

Open **Lainnya → Pembaruan aplikasi**, then choose **Periksa pembaruan**.

The updater:

1. Reads the latest published GitHub Release.
2. Compares its semantic version with `AppVersion.version`.
3. Finds the version-matched Windows x64 ZIP and `SHA256SUMS.txt`.
4. Downloads the ZIP to the user's Local AppData update cache.
5. Starts `updater/apply_update.ps1` outside the application process.
6. Waits for PetUniverse to exit, verifies the archive hash, extracts to a
   temporary folder, and replaces the program directory.
7. Retains a backup of the previous program directory and launches the updated
   executable.

The updater only replaces files under the application installation directory.
It does not intentionally modify the local database, attachments, or workspace
data. The first update must be performed from an installation made by the
versioned installer so the updater helper is present.

## Current constraints

- The current update screen is manually triggered; it does not perform silent
  background updates.
- The first release must be published to a public release repository for the
  unauthenticated updater to work.
- The release builder currently targets Windows x64.
- The release builder expects the Windows Flutter scaffold to be committed in
  `app/windows/`.
- The PowerShell installer and updater must be tested on a Windows machine
  before distributing a production release.
