# PetUniverse — Decision Log

This file records agreed project direction. Add dated entries when decisions are made or changed.

## Current baseline

| Topic | Current direction | Status |
|---|---|---|
| Product | Multi-species animal care and management | Agreed |
| Platforms | Android and iOS | Agreed |
| Client framework | Flutter | Proposed; validate |
| Workspaces | Personal and Professional | Agreed |
| Data strategy | Offline-first with cloud sync | Agreed |
| Marketplace | Out of scope | Agreed |
| Species catalog | Extensible and custom-species capable | Agreed |
| Core logical data model | Proposed in `docs/architecture/DATA_MODEL.md`; review required | Draft |
| Animal representation | Individual and first-class group records | Agreed |
| Updates | GitHub Releases plus separate content ZIP packages | Direction agreed |
| Core app distribution | Platform-compliant Android/iOS channels | Required |
| Release tooling | One Unified Builder & Release Manager orchestrator | Direction agreed |
| Installer technology | No Inno Setup dependency | Agreed |

## Pending decisions

- UI/UX navigation and visual system (draft screen flows in `docs/product/SCREEN_FLOWS.md`; review required).
- Final Flutter architecture and package selection.
- Local database technology.
- Backend and cloud database technology.
- Review and approve the proposed logical data model in `docs/architecture/DATA_MODEL.md`.
- Review and approve the animal profile and group creation flows in `docs/product/SCREEN_FLOWS.md`.
- Dynamic attribute schema format and version compatibility.
- Conflict-resolution policy by record type.
- Authentication providers.
- Attachment storage and retention.
- Content package signature format and key management.
- License and public/private repository strategy.
