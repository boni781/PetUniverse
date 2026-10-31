# PetUniverse — Development Roadmap

The roadmap is ordered by dependencies. Planned work is not complete until implementation and acceptance tests exist.

## Phase 0 — Product and technical definition

- [ ] Finalize PRD and scope.
- [ ] Review and approve Personal and Professional screen flows (`docs/product/SCREEN_FLOWS.md`).
- [ ] Review and approve the role permission matrix (`docs/security/ROLE_PERMISSION_MATRIX.md`).
- [ ] Review and approve the proposed logical data model (`docs/architecture/DATA_MODEL.md`).
- [ ] Finalize species and dynamic attribute model.
- [ ] Review and approve individual and group form behavior (`docs/product/SCREEN_FLOWS.md`).
- [ ] Finalize habitat model and assignment history.
- [ ] Review and approve the proposed Drift/SQLite + Supabase storage architecture (`docs/architecture/STORAGE_AND_SYNC.md`); validate with a non-production proof of concept.
- [ ] Finalize synchronization API, cursor semantics, and conflict policy by record type.
- [ ] Define privacy, retention, and backup requirements.
- [ ] Define acceptance tests.

## Phase 1 — Application foundation

- [ ] Initialize Flutter project for Android and iOS.
- [ ] Establish app architecture and navigation.
- [ ] Add design system and theme.
- [ ] Add environment/configuration handling.
- [ ] Add automated linting and test workflow.
- [ ] Add Drift/SQLite local persistence after architecture approval, including migration and repository tests.

## Phase 2 — Core animal management

- [ ] Accounts and workspaces.
- [ ] Species catalog and custom species.
- [ ] Individual animal profiles.
- [ ] First-class groups.
- [ ] Habitats and assignment history.
- [ ] Search and filters.

## Phase 3 — Care operations

- [ ] Care templates and schedules.
- [ ] Recurrence logic.
- [ ] Care execution logs.
- [ ] Reminders and local notifications.
- [ ] Feeding records.
- [ ] Health records and measurements.

## Phase 4 — Offline/cloud and collaboration

- [ ] Authentication and backend.
- [ ] Outbox-based synchronization.
- [ ] Idempotent retries.
- [ ] Conflict handling.
- [ ] Attachment upload recovery.
- [ ] Implement workspace roles and server authorization from the approved permission matrix.
- [ ] Audit events and backup.

## Phase 5 — Content updater and release engineering

- [ ] Content package format.
- [ ] Manifest and checksum validation.
- [ ] Package signature verification design.
- [ ] Staging, activation, and rollback.
- [ ] Unified Builder & Release Manager.
- [ ] Android APK/AAB build.
- [ ] iOS IPA build through macOS/Xcode.
- [ ] Content ZIP packaging.
- [ ] Release validation and GitHub Draft Release.

## Phase 6 — Expansion

- [ ] Sourced species encyclopedia.
- [ ] Charts and advanced reports.
- [ ] Expense tracking.
- [ ] Rich exports.
- [ ] Image identification and analytics (subject to feasibility and validation).
- [ ] Sensor integrations.
