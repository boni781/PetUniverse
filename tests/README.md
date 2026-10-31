# Tests

Tests will cover domain logic, persistence, synchronization, permissions, content updates, and platform behavior.

Important scenarios include:
- Individual and group animal records.
- Custom species without code changes.
- Habitat assignment history.
- Recurring care schedules and actual care logs.
- Explicit units and unknown values.
- Offline persistence across app restart.
- Duplicate-safe synchronization retries.
- Conflict handling without loss of health/care history.
- Interrupted attachment upload recovery.
- Server-side workspace authorization.
- Content package compatibility, checksum validation, activation, and rollback.
