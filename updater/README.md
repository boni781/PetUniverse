# Content Updater

This directory will contain the client-side content package update mechanism.

Planned flow:
1. Check release metadata in the background.
2. Read and validate the manifest.
3. Check application and schema compatibility.
4. Download to staging.
5. Verify checksum and, when implemented, package signature.
6. Activate safely.
7. Retain previous content for rollback.

The updater must never overwrite user databases, attachments, credentials, or private configuration. Core application updates are distributed through platform-compliant channels.
