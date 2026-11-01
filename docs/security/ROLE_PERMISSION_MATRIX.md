# PetUniverse — Workspace Role and Permission Matrix

**Status:** Proposed baseline  
**Version:** 0.1  
**Scope:** Professional workspace authorization and Personal workspace ownership  
**Implementation status:** Specification only. These rules are not yet enforced by the Flutter client or a backend.

## 1. Authorization principles

1. Authorization is evaluated for every operation against the active workspace. A record ID supplied by a client is never proof of access.
2. The backend is the security authority. Hiding or disabling Flutter controls is only a user-experience aid.
3. Apply least privilege. A role receives only the actions required for its work.
4. Workspace membership is explicit, revocable, and status-aware. Invited, suspended, and removed members cannot act as active members.
5. Health records and attachments can contain sensitive information. Access must follow the linked record and any explicit health-data grant.
6. Read, create, update, archive, export, and permanent purge are separate capabilities; do not collapse them into one generic "manage" permission.
7. Every operation must verify tenant ownership for all linked records. Cross-workspace references are rejected.
8. Important actions, especially membership changes, permission changes, archival, deletion, and export, must produce an audit event.
9. The same domain rules apply to Personal and Professional workspaces. Personal workspaces normally have one Owner; team roles are used in Professional workspaces.
10. Offline authorization is a local user-experience decision, not the final security check. The server re-evaluates membership and permission when an operation synchronizes.

## 2. Role definitions

| Role | Responsibility |
|---|---|
| Owner | Owns the workspace, controls ownership transfer and irreversible workspace-level actions |
| Administrator | Manages workspace settings and members, and supervises all domain data |
| Manager | Runs daily animal-care operations and manages domain records |
| Care Staff | Records day-to-day care and observations within the workspace, with limited editing authority |
| Reader | Reads the data explicitly permitted to them; cannot change domain records |

A workspace has one active Owner at a time in the proposed v1 model. Ownership transfer is a dedicated action, not an ordinary role edit. The implementation must prevent the workspace from being left without an Owner.

## 3. Baseline permission matrix

Legend:
- **Full** — may perform the ordinary read/create/update/archive operations for that resource.
- **Read** — may view the resource only.
- **Limited** — only the specified subset, scope, or records.
- **—** — denied by default.
- **Owner only** — reserved for the Owner.

| Resource / capability | Owner | Administrator | Manager | Care Staff | Reader |
|---|---|---|---|---|---|
| View workspace | Full | Full | Read | Read | Read |
| Edit workspace profile/settings | Full | Full | — | — | — |
| Transfer workspace ownership | Owner only | — | — | — | — |
| Permanently close/delete workspace | Owner only | — | — | — | — |
| View member list and roles | Full | Full | Limited | — | — |
| Invite members | Full | Full | — | — | — |
| Change member roles/status | Full | Full, cannot assign Owner | — | — | — |
| Shared species catalog | Read | Read | Read | Read | Read |
| Create/edit workspace custom species | Full | Full | Full | — | — |
| View animal profiles | Full | Full | Full | Full | Read |
| Create individual/group profiles | Full | Full | Full | Limited | — |
| Edit animal identity/species/status | Full | Full | Full | Limited | — |
| Archive/restore animal profiles | Full | Full | Full | — | — |
| Link/manage group members | Full | Full | Full | Limited | — |
| View habitats and assignment history | Full | Full | Full | Read | Read |
| Create/edit/archive habitats | Full | Full | Full | — | — |
| Assign/reassign animals to habitat | Full | Full | Full | Limited | — |
| Create/edit care templates | Full | Full | Full | — | — |
| Create/edit/cancel care schedules | Full | Full | Full | — | — |
| View care schedules | Full | Full | Full | Full | Read |
| Complete/skip assigned care task | Full | Full | Full | Limited | — |
| Create care execution log | Full | Full | Full | Limited | — |
| Correct an existing care log | Full | Full | Full | Limited | — |
| View full health records | Full | Full | Full | Limited | — |
| Create health observation | Full | Full | Full | Limited | — |
| Edit health records | Full | Full | Full | Limited | — |
| View/add feeding records | Full | Full | Full | Limited | Read |
| View/add animal/habitat measurements | Full | Full | Full | Limited | Read |
| Upload attachments | Full | Full | Full | Limited | — |
| View/download attachments | Full | Full | Full | Limited | Limited |
| Remove attachment links | Full | Full | Full | — | — |
| Export workspace data | Full | Full | Limited | — | — |
| View audit trail | Full | Full | Limited | Limited | — |
| View own device sync status | Full | Full | Full | Full | Full |
| View workspace-wide sync status | Full | Full | Limited | — | — |
| Manage app-level personal preferences | Full | Full | Full | Full | Full |

This matrix is a proposed baseline. "Limited" is defined in section 4 and must be represented by explicit server-side capabilities and row ownership checks, not interpreted ad hoc by individual screens.

## 4. Limited capabilities by role

### 4.1 Care Staff

Care Staff are expected to perform operational work without having administrative control.

- May view animal profiles and habitat context needed for assigned care work.
- May create a basic animal profile when the workflow permits, but cannot change workspace-wide settings, roles, or catalog governance.
- May edit only allowed basic fields on profiles they created or are explicitly assigned to maintain. Species reassignment, archival, and ownership changes remain restricted.
- May view care schedules and record completion, partial completion, or skipped status.
- May create feeding records, measurements, and non-diagnostic observations.
- May view health summary/context only when the workspace grants that capability. Full health-record access is not implied by Care Staff role.
- May correct their own care/observation record through an auditable correction path. A correction must preserve the previous value or record version.
- May upload an attachment to a record they can access. They cannot remove an attachment shared by other records.
- Cannot export the complete workspace, invite members, change roles, or create/delete habitats.

### 4.2 Manager

- May manage daily animal, group, species customization, habitat, schedule, care, health, feeding, and measurement records.
- May assign operational responsibilities only after a separate task-assignment model is approved.
- May view operational audit information needed to manage the workspace.
- May export records within the workspace and data domains they are authorized to manage.
- Cannot transfer ownership, close/delete the workspace, or grant Owner/Administrator access.

### 4.3 Reader

- May view ordinary animal, species, habitat, schedule, care-log, feeding, and measurement information.
- Health records and health-related attachments are denied by default. An explicit grant may permit access to a defined health summary or full health record scope.
- Cannot edit, create, archive, export, invite members, or manage settings.
- A Reader's access to an attachment follows the permission on its linked record; a public or guessable file URL must not bypass this rule.

## 5. Explicit capability flags

Role names are convenient defaults. Backend authorization should resolve them into explicit capabilities, for example:

- `workspace.read`, `workspace.settings.update`, `workspace.owner.transfer`, `workspace.close`.
- `members.read`, `members.invite`, `members.role.update`, `members.remove`.
- `animals.read`, `animals.create`, `animals.identity.update`, `animals.archive`.
- `groups.membership.manage`.
- `species.custom.manage`.
- `habitats.read`, `habitats.manage`, `habitats.assign`.
- `care.schedule.read`, `care.schedule.manage`, `care.log.create`, `care.log.correct`.
- `health.summary.read`, `health.records.read`, `health.observation.create`, `health.records.manage`.
- `measurements.read`, `measurements.create`, `feeding.read`, `feeding.create`.
- `attachments.upload`, `attachments.read`, `attachments.unlink`.
- `reports.export`, `audit.read`, `sync.workspace.read`.

The capability list is an implementation contract proposal, not a claim that all flags already exist. Capabilities may later be granted or restricted per membership, but an override must be explicit, auditable, and must never elevate a member to Owner.

## 6. Resource and row-level scope

Every workspace-owned record must be checked against the same workspace membership:

- The acting user has an active membership in the record's workspace.
- The role/capability allows the requested operation.
- Every foreign key or polymorphic reference points to an allowed record in that same workspace.
- For Care Staff limited edits, the target record is within the member's permitted assignment or creator scope.
- Attachments inherit access from the linked record and must use private storage access.
- A workspace ID supplied in a request is not trusted without membership validation.

A profile's workspace must not be changed through an ordinary profile update. Workspace transfer, if ever supported, requires a separate audited administrative workflow.

## 7. Personal workspace behavior

- Personal workspace creation assigns the creator the Owner role.
- No other user receives access unless the owner explicitly shares the workspace through an approved membership flow.
- There is no special Personal-only database schema.
- The app may work locally before account linking, but local records must retain stable IDs and workspace ownership so they can later be linked to an authenticated account without duplicating records.
- Switching between Personal and Professional changes the active data scope; it does not copy or merge records.

## 8. Health and attachment privacy

Health data may include information that workspace owners do not want every collaborator to see.

Proposed defaults:
- Owner, Administrator, and Manager: full health access.
- Care Staff: health summary only when enabled by an explicit workspace capability; may add non-diagnostic observations. No access to restricted health attachments by default.
- Reader: no health access by default.
- An explicit grant must state whether it grants summary, full record, creation, or attachment access; avoid one broad `health_access=true` switch.

The final product must separately decide whether health records are treated as sensitive personal data, who can export them, and how long they are retained.

## 9. Server enforcement and test requirements

### Server rules

- Enforce workspace membership and role/capability in the backend, not only in Flutter.
- Enable Row Level Security on every exposed workspace-owned table when using Supabase/Postgres.
- Grant only required SQL privileges, then write explicit RLS policies for each operation.
- Keep privileged server/service keys out of the Flutter app, browser builds, repository, and content packages.
- Use private storage buckets with policy checks based on workspace membership and linked-record access.
- Validate object IDs and workspace IDs on create/update, including polymorphic links.
- Do not trust user-editable metadata as authorization data.

### Required allow/deny tests

For each protected table/resource, test:
1. Owner can perform allowed operations.
2. Administrator can perform allowed operations but cannot transfer ownership or close the workspace.
3. Manager can perform daily operations but cannot administer membership or workspace ownership.
4. Care Staff can perform limited operational writes but cannot change settings, roles, archive profiles, or export the workspace.
5. Reader can read permitted information and cannot write.
6. An authenticated non-member cannot read or mutate any workspace row.
7. An unauthenticated client cannot access private workspace records.
8. A member cannot point a record or attachment link at a different workspace.
9. A removed or suspended member loses server access.
10. Health access is denied unless the appropriate capability is granted.

If Supabase is selected, add pgTAP tests for RLS policies and include them in database CI. A policy that merely hides a row from SELECT is not the same as a database exception; test both the affected row and the actual resulting data.

## 10. Open decisions

- Whether Care Staff may create animal profiles by default or only when a Manager grants it.
- Whether Care Staff can see health summaries for every animal or only assigned animals.
- Whether Manager may export all health records or only non-restricted domains.
- Whether a membership-level capability override is needed in version 1 or role defaults are sufficient.
- Which actions require re-authentication or multi-factor authentication.
- Audit retention and privacy policy.

These items should be approved before production authorization and RLS policies are implemented.
