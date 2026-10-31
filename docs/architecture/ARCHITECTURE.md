# PetUniverse — Architecture Principles

**Status:** Proposed direction; not an implementation specification.

## 1. Client platform

Flutter is the proposed cross-platform client for Android and iOS. Validate required plugins, local database behavior, background tasks, notifications, and platform distribution before locking the stack.

## 2. Offline-first structure

- Local database is the immediate source for the active device's UI.
- Mutations are persisted locally before remote synchronization.
- An outbox/change queue tracks pending operations.
- Each record uses a stable identifier.
- Retry behavior must be idempotent.
- Synchronization state is visible to the user.
- Conflicts must preserve important historical records.

## 3. Conceptual domains

- Identity and workspaces.
- Animals and groups.
- Species and dynamic attributes.
- Habitats and assignment history.
- Care templates, schedules, and logs.
- Health records and measurements.
- Feeding and environmental observations.
- Attachments.
- Notifications.
- Synchronization metadata.
- Audit events.

## 4. Candidate conceptual entities

Users, Workspaces, Memberships, Animals, AnimalGroups, Species, SpeciesAttributeDefinitions, Habitats, AnimalHabitatHistory, CareTemplates, CareTasks, CareLogs, HealthRecords, Measurements, FeedingRecords, Attachments, Notifications, SyncMetadata, and AuditEvents.

This list is conceptual. Relationship cardinality, ownership, deletion behavior, and normalization remain to be designed.

## 5. Detailed logical data model

See [DATA_MODEL.md](DATA_MODEL.md) for the proposed workspace, species, animal/group, habitat, care, health, measurement, attachment, and synchronization entities, along with their invariants. It is a logical proposal, not a physical database or migration specification.

## 6. Species extensibility

Prefer data-driven species definitions and attribute schemas. Species-specific forms should be driven by definitions rather than hard-coded assumptions in generic profile screens.

Store measurement value, unit, context, timestamp, and source. Unknown values must not be coerced to zero.

## 7. Backend and authorization

A cloud backend is required for account identity, workspace collaboration, synchronization, and backup. The backend technology is not yet selected.

Workspace membership and role checks must be enforced by server-side authorization. Client-side hiding is not a security boundary.

## 8. Content updates

Separate application-core releases from content packages. Content packages may include species catalog data, care rules, templates, and assets. A manifest should carry product, package type, version, minimum app version, schema version, asset name, checksum, and release notes.

Download into staging, validate compatibility and integrity, activate safely, and support rollback. Never overwrite user databases, attachments, credentials, or private configuration.

## 9. Platform distribution

Android core updates must follow Google Play or permitted APK distribution. iOS builds must be signed and distributed using Apple-compliant mechanisms such as App Store or TestFlight. GitHub Releases can host metadata and permitted artifacts, but does not replace these distribution mechanisms.
