# PetUniverse — Unified Builder & Release System

**Status:** Design concept; implementation not started.

## Goal

A single orchestrator, proposed as `scripts/release.py`, coordinates versioning, platform builds, content packaging, validation, release review, and GitHub publishing.

## Separate version dimensions

- Application version.
- Content package version.
- Database/schema version.

These versions must not be conflated.

## Proposed stages

1. Preflight: toolchains, Git, repository, GitHub CLI/authentication, signing configuration.
2. Version manager: patch/minor/major/manual.
3. Metadata synchronizer.
4. Android build: APK and AAB as configured.
5. iOS build: signed IPA via macOS/Xcode or GitHub Actions macOS runner.
6. Content package builder: curated content only.
7. Manifest and checksum generation.
8. Release validator: compatibility, versions, package integrity, required files, and secret scanning.
9. Package manager: collect outputs under one versioned release-output directory.
10. Release review: show assets, sizes, platform targets, versions, and changelog.
11. Publisher: optionally commit/push metadata, create tag, create GitHub Draft Release, and upload assets.
12. Explicit publish step after review.

## Possible release assets

- PetUniverse Android APK (where distribution is permitted).
- Android AAB for Google Play.
- Apple-signed iOS IPA for Apple-compliant distribution.
- Versioned content ZIP.
- manifest.json.
- checksums.txt.
- CHANGELOG.md.
- release-summary.json.

## Safety requirements

- Never put signing private keys or credentials into the repository or release ZIP.
- Content ZIP must not contain the entire source repository.
- Do not include user databases, attachments, or private configuration in content packages.
- Validate checksums and compatibility before activation.
- Preserve previous active content for rollback.
- Do not overwrite user data during update.
- Keep GitHub Release as metadata/artifact hosting, not a replacement for Play Store/App Store distribution.

## Reference script

The previously supplied `release(1).py` belongs to DropShift. Its orchestration, versioning, preflight, review, and publishing ideas may inform this design. Its Windows/Inno Setup/EXE workflow must not be copied directly into PetUniverse.
