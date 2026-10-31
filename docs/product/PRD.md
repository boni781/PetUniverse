# PetUniverse — Product Requirements Baseline

**Status:** Draft baseline  
**Version:** 1.0  
**Implementation:** Not started

## 1. Product vision

PetUniverse is a cross-platform animal care and management application for personal owners and professional animal keepers. It brings animal identity, groups, habitats, care schedules, care logs, health information, and husbandry records into one system.

The product is not a marketplace.

## 2. Target users and workspaces

### Personal

For an individual or household managing their own animals.

### Professional

For teams and organizations managing animals at larger scale, including breeding, boarding, farms, shelters, and animal-care operations.

Both modes use the same foundational entities. Differences are expressed through workspace capabilities, roles, and operational scale.

## 3. Supported animal scope

The catalog is intended to cover mammals, birds, aquatic animals, reptiles, amphibians, invertebrates, poultry, and livestock. It must be expandable. Users must be able to create a custom or not-yet-cataloged species without requiring an application code change.

## 4. Planned modules

- Accounts and workspaces.
- Animal profiles for individuals and groups.
- Species catalog and custom species.
- Habitat/location management and assignment history.
- Care templates, one-time and recurring schedules.
- Execution logs for completed care.
- Local reminders and notifications.
- Health records and measurements.
- Feeding records and environmental measurements.
- Photos and document attachments.
- Search, filtering, reports, and export.
- Species encyclopedia with sources and validation status.
- Professional workspace membership, roles, and audit trail.

## 5. Data behavior

Universal data includes identity, habitat, schedules, logs, health, measurements, attachments, and timestamps. Species-specific attributes and forms depend on species, life stage, habitat, and care context.

Unknown values must remain null/unknown, not zero. Every measurement must have an explicit unit. Reference ranges and care guidance must retain their sources and validation status.

Care guidance is informational. The app must not claim to diagnose disease or provide unsupported medication dosages.

## 6. Groups and habitats

Groups are first-class records. They must not be represented only by creating one individual profile per animal.

Habitats may include aquariums, ponds, cages, aviaries, terrariums, enclosures, and livestock housing. Animal-to-habitat assignment history must be retained.

## 7. Offline and synchronization

The application must remain usable offline. Local changes are persisted first and placed in a synchronization queue. Synchronization must be retry-safe and avoid duplicate records.

Conflicts must be detected and handled without silently losing historical care or health records. Media uploads must recover from interrupted transfers. Deletions require a synchronization-safe strategy such as tombstones.

## 8. Access control

Professional workspaces are expected to support Owner, Administrator, Manager, Care Staff, and Reader roles. Sensitive authorization decisions must be enforced by the backend. Important changes should be auditable.

## 9. Priorities

### P0 — Foundation

Accounts/workspaces, species and animal profiles, individual/group support, habitats, schedules/logs, local reminders, health/measurements, offline-first data, synchronization, search/filter, basic export, and safe content updates.

### P1 — Expansion

Sourced encyclopedia, charts, expense reports, team/family collaboration, richer exports, and advanced reporting.

### P2 — Advanced capabilities

Image identification, pattern analytics, personalized recommendations, and sensor integration.

## 10. Acceptance themes

The product must demonstrate profile creation, custom species, group management, habitat history, recurring care, actual care logs, explicit units, offline persistence, duplicate-safe sync, conflict handling, reminders, backend role enforcement, export, and safe package update/rollback.

## 11. Open design decisions

Before implementation, finalize detailed screen flows, data schema, dynamic species attributes, local database, backend choice, conflict-resolution policy, attachment storage, privacy/retention rules, and test strategy.
