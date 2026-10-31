# Database Migrations

Versioned database schema migrations will live here.

Migration requirements:
- Explicit schema versioning.
- Tested upgrade paths.
- Backup/restore strategy before destructive changes.
- No silent deletion of user history.
- Compatibility strategy for offline devices that may reconnect later.

The concrete database technology and migration tooling are pending.
