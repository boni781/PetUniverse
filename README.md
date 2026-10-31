# PetUniverse

**Cross-platform animal care and management application.**

PetUniverse is planned as an offline-first application for managing animals, habitats, care routines, health records, and husbandry operations. It is intended for both personal animal owners and professional animal keepers.

> **Project status:** Product planning and repository foundation. Application implementation has not started.

## Product direction

- **Platforms:** Android and iOS.
- **Mobile framework:** Flutter (proposed; technical validation remains).
- **Operating model:** Personal and Professional workspaces over a shared data foundation.
- **Data strategy:** Offline-first local storage with cloud synchronization.
- **Scope:** Multi-species animal management. No marketplace functionality is planned.

## Planned capabilities

- Individual animal and group profiles.
- Expandable species catalog and custom species support.
- Habitat and animal-habitat assignment history.
- Care schedules, recurring tasks, and completed-care logs.
- Reminders and local notifications.
- Health records, measurements, feeding logs, and attachments.
- Search, filters, reports, and data export.
- Sourced species encyclopedia and validated care guidance.
- Workspace membership, role-based access, and audit history.
- Offline operation, synchronization, backup, and conflict handling.

## Repository map

```text
docs/                 Product, architecture, and development documentation
app/                  Flutter application (to be initialized)
assets/               Application assets
species_data/         Versioned species catalog content
care_engine/          Universal and species-specific care rules
updater/              Content update and verification logic
migrations/           Database schema migrations
tests/                Automated tests
scripts/              Build, validation, and release tooling
config/               Non-secret project configuration
release-output/       Local release artifacts (not committed)
```

## Engineering principles

1. Unknown values remain unknown; do not silently convert them to zero.
2. Measurements must define units. Reference ranges and care guidance must retain their sources.
3. Care guidance is informational and must not be presented as an unsupported diagnosis or medication prescription.
4. Group records are first-class entities, not a forced collection of individual profiles.
5. Offline changes must be durable and synchronization must be retry-safe and conflict-aware.
6. Never overwrite user databases, personal attachments, credentials, or private configuration during content updates.
7. Enforce workspace permissions on the server, not only in the user interface.

## Development status

The product requirements are being refined before implementation. Do not treat planned modules as implemented features. The first implementation milestone is to finalize UI flows, data model, local/cloud architecture, species attribute model, and synchronization behavior.

## Documentation

- [Product requirements](docs/product/PRD.md)
- [Architecture principles](docs/architecture/ARCHITECTURE.md)
- [Development roadmap](docs/development/ROADMAP.md)
- [Contributing guide](CONTRIBUTING.md)
- [Security policy](SECURITY.md)

## License

No open-source license has been selected yet. All rights are reserved by default until a license is added.
