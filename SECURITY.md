# Security Policy

PetUniverse is at an early development stage.

## Reporting a vulnerability

Do not publish credentials, private animal-owner data, access tokens, signing keys, or exploitable details in public issues.

Report suspected vulnerabilities privately to the repository owner through GitHub's available private vulnerability reporting mechanism.

## Security principles

- Never commit secrets or signing private keys.
- Keep user databases and attachments out of content update packages.
- Verify downloaded content packages using trusted manifests and cryptographic integrity checks.
- Enforce workspace authorization on the backend.
- Preserve audit history for security-sensitive operations.
- Avoid exposing personal data in logs or crash reports.
