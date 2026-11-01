# PetUniverse — Core Data Model

**Status:** Proposed logical model  
**Version:** 0.1  
**Scope:** P0 domain foundation  
**Implementation status:** Specification only; no database migrations or persistence code are implied by this document.

This document turns the product requirements into a reviewable logical model. It is deliberately database-neutral because the local database, cloud backend, dynamic-attribute storage strategy, and conflict-resolution rules are still open decisions.

## 1. Modeling principles

1. **Workspace-scoped ownership.** Every user-created domain record belongs to exactly one workspace. Personal and Professional workspaces use the same domain model; differences come from workspace capabilities and membership roles.
2. **Offline-created identifiers.** Generate stable record IDs on the client before saving or synchronizing. UUIDs are the current proposal; the exact UUID version and library are implementation decisions.
3. **Preserve history.** Changes that describe events or history are append-only records where practical. Correcting a historical entry should retain an audit trail.
4. **Unknown is not zero.** Missing, unobserved, not applicable, and unknown are distinct states. Never replace a missing measurement or count with zero.
5. **Units are explicit.** Every quantitative measurement has a unit code. Store the numeric value and unit separately; do not rely on a unit embedded in free text.
6. **Species-driven forms.** Species, life stage, and context determine which optional attributes and care fields are presented. Generic profile screens must not hard-code one animal class.
7. **Groups are first-class.** A group has its own profile and history. It is not merely a count or a set of duplicated individual records.
8. **Safe synchronization.** Create, update, and delete operations must be retry-safe. Deletion is represented by a tombstone until synchronization and retention rules permit final cleanup.
9. **Source-aware reference data.** Catalog facts, care guidance, and reference ranges retain provenance and a validation status.
10. **Tenant isolation.** A record from one workspace must never be accessible through another workspace merely because a client supplies an identifier.

## 2. Domain boundaries

The model is divided into these domains:

| Domain | Responsibility |
|---|---|
| Identity and workspace | Users, Personal/Professional workspaces, memberships, roles |
| Species catalog | Taxonomic references, custom species, attribute definitions, catalog sources |
| Animal records | Individual and group profiles, dynamic attributes, group membership |
| Habitat | Habitat hierarchy, environmental attributes, assignment history |
| Care operations | Templates, schedules, recurring rules, completed-care logs |
| Health and observations | Health notes, feeding records, animal and habitat measurements |
| Media | Attachment metadata and links to domain records |
| Governance | Audit events, deletion tombstones, synchronization outbox |

The model does not include marketplace listings, transactions, or public animal trading.

## 3. Identity and workspaces

### 3.1 User

Represents an authenticated person, not an animal owner record.

Suggested fields:

- `id` — stable user ID.
- `display_name` — optional display name.
- `email` — optional; identity-provider ownership and verification remain with the authentication system.
- `created_at`, `updated_at`.

Authentication credentials and provider tokens must not be stored in ordinary profile rows.

### 3.2 Workspace

Represents a Personal or Professional data boundary.

Suggested fields:

- `id`.
- `workspace_type` — `personal` or `professional`.
- `name`.
- `created_by_user_id`.
- `created_at`, `updated_at`, `deleted_at`.

A user may participate in more than one workspace. A workspace is the owner of animal, species-customization, habitat, care, and observation data.

### 3.3 Workspace membership

Suggested fields:

- `id`, `workspace_id`, `user_id`.
- `role` — `owner`, `administrator`, `manager`, `care_staff`, or `reader`.
- `membership_status` — invited, active, suspended, or removed.
- `joined_at`, `created_at`, `updated_at`.

A user should have at most one membership row per workspace. Role permissions must be defined in a separate permission matrix and enforced by the backend. Hiding a button in Flutter is not authorization.

## 4. Species catalog and dynamic attributes

### 4.1 Species

A species record may originate from a bundled/global catalog or be custom to a workspace.

Suggested fields:

- `id`.
- `origin` — `catalog` or `custom`.
- `workspace_id` — null for shared catalog records; required for custom workspace records.
- `taxonomic_rank` — species, subspecies, genus, or another explicitly supported rank.
- `scientific_name`.
- `common_names` — localized names; model as related rows or structured values, not one comma-separated string.
- `parent_taxon_id` — optional taxonomic parent.
- `catalog_status` — draft, reviewed, published, or deprecated.
- `created_at`, `updated_at`, `deleted_at`.

A custom species must not alter a shared catalog record. If a user has not identified an animal's species, the profile can remain unclassified; the app must not invent a species.

### 4.2 Species sources

Reference data needs attribution.

Suggested fields:

- `id`, `species_id`.
- `source_name`, `source_url` (optional), `publisher` (optional).
- `accessed_at`, `license_or_usage_note` (optional).
- `validation_status` — unreviewed, reviewed, disputed, or retired.
- `reviewed_by`, `reviewed_at` (optional).

A care recommendation or reference range should point to its own source record or a clearly traceable source set.

### 4.3 Species attribute definitions

Attribute definitions describe what the app may ask or display for a species. They are not animal observations themselves.

Suggested fields:

- `id`, `species_id`.
- `key` — stable machine-readable key, unique within a species definition version.
- `label`, `description`, `category`.
- `value_type` — text, integer, decimal, boolean, date, single choice, multiple choice, or measurement.
- `applies_to` — individual, group, or both.
- `unit_code` — required for a measurement definition; otherwise null.
- `options` — structured list for choice attributes.
- `validation_rules` — structured constraints, with supported rules explicitly versioned.
- `is_required`, `is_repeatable`, `display_order`.
- `definition_version`, `status`.

Definitions must not contain executable code. The client validates a value against the definition version it has loaded. Unsupported definition versions must not be silently interpreted.

### 4.4 Dynamic attribute values

Suggested fields:

- `id`, `workspace_id`, `animal_profile_id`, `attribute_definition_id`.
- `value_json` — value encoded according to the declared type.
- `unit_code` — required when the value represents a measurement and must match the definition or an allowed conversion.
- `observed_at` — optional date/time when the value was observed.
- `value_source` — user, import, or validated catalog default.
- `created_at`, `updated_at`, `deleted_at`.

Dynamic values are for descriptive/species-specific profile attributes. Repeated time-series facts such as weight, body length, water temperature, or pH belong in measurement records, not by repeatedly overwriting a profile attribute.

Example value payloads (illustrative only):

```json
{ "value": "long-haired" }
```

```json
{ "value": 4.2, "unit": "kg" }
```

```json
{ "value": ["freshwater", "community"] }
```

The definition remains the authority for data type and valid units; the example payload alone is not a schema.

## 5. Animal profiles

### 5.1 Shared animal profile

Use one shared profile identity for both record kinds, with subtype details kept separate.

Suggested fields:

- `id`, `workspace_id`.
- `record_kind` — `individual` or `group`.
- `display_name` — required user-facing name.
- `species_id` — optional. For a group it may be set only when the group is intentionally classified as one species; it does not replace each member's species.
- `profile_status` — active, archived, or deceased/closed where applicable.
- `notes` — optional free text.
- `created_at`, `updated_at`, `deleted_at`.

Workspace-scoped identification codes should be unique when supplied. Do not require every animal to have a tag, microchip, or other physical identifier.

### 5.2 Individual details

One-to-one subtype of an animal profile where `record_kind = individual`.

Suggested fields:

- `animal_profile_id`.
- `sex_code` — optional species/catalog-defined code.
- `birth_date` — nullable.
- `birth_date_precision` — exact, estimated, or unknown.
- `acquired_at` — optional date.
- `life_stage_code` — optional species-defined stage.
- `life_stage_source` — observed, user-selected, or derived.
- `identification_type` and `identification_value` — optional.

Sex and life-stage vocabularies must be species-aware. Do not force a universal list that cannot represent the supported species. A derived life stage must retain the rule/catalog version used to derive it.

### 5.3 Group details

One-to-one subtype of an animal profile where `record_kind = group`.

Suggested fields:

- `animal_profile_id`.
- `group_purpose` — optional user-defined category.
- `member_tracking_mode` — tracked, estimated, or not tracked.
- `reported_count` — nullable; used only for an estimate or untracked group.
- `count_observed_at` — nullable.
- `count_note` — optional.

When membership is fully tracked, the UI may calculate a current member count from active membership rows. An estimated count must be labeled as an estimate and must not be mistaken for a verified count. Group membership count is not the same as a health or population measurement.

### 5.4 Group membership history

Suggested fields:

- `id`, `workspace_id`.
- `group_profile_id` — must reference a group profile.
- `individual_profile_id` — must reference an individual profile.
- `valid_from`, `valid_to` — effective membership interval.
- `membership_note` — optional.
- `created_at`, `updated_at`.

Version 1 should support groups containing individual profiles. Nested groups are deferred until an explicit use case and counting behavior are defined. Membership changes close the prior interval and create a new interval; do not erase prior membership history.

A group may include only individuals from the same workspace. Each member retains its own identity, species, health, and care history.

## 6. Habitat and assignment history

### 6.1 Habitat

Suggested fields:

- `id`, `workspace_id`.
- `parent_habitat_id` — optional, for a hierarchy such as facility → room → enclosure.
- `name`, `habitat_type` — aquarium, pond, cage, aviary, terrarium, enclosure, livestock housing, or custom.
- `status` — active, inactive, or archived.
- `description` — optional.
- `capacity_value`, `capacity_unit` — optional and explicitly defined.
- `created_at`, `updated_at`, `deleted_at`.

Habitat-specific properties such as dimensions, substrate, filtration, humidity, and lighting should be data-driven. Environmental values that change over time belong in environmental measurement records.

### 6.2 Animal-habitat assignment

Suggested fields:

- `id`, `workspace_id`.
- `animal_profile_id` — may point to an individual or group profile.
- `habitat_id`.
- `assignment_role` — primary or secondary.
- `valid_from`, `valid_to`.
- `recorded_by_user_id`, `note` (optional).

Assignments are historical. Moving a profile closes the former assignment and creates a new one. The application may default to one active primary habitat per profile; multi-habitat behavior and any database-specific uniqueness constraint must be confirmed before migration design.

Assigning a group to a habitat does not silently create separate assignment rows for all members. The UI may show the group's habitat as inherited context, while explicit individual assignments remain possible and visible.

## 7. Care operations

### 7.1 Care template

A reusable definition for a care activity.

Suggested fields:

- `id`, `workspace_id` (nullable only for reviewed shared templates).
- `name`, `care_category`, `instructions`.
- `applies_to` — individual, group, habitat, or a supported combination.
- `species_id` — optional.
- `definition_version`, `source_id` (optional).
- `created_at`, `updated_at`, `deleted_at`.

### 7.2 Care schedule

A planned activity for an animal profile or habitat.

Suggested fields:

- `id`, `workspace_id`.
- `subject_kind` — animal profile or habitat.
- `subject_id`.
- `care_template_id` — optional.
- `title`, `care_category`.
- `start_at`, `due_time` or schedule anchor.
- `time_zone`.
- `recurrence_rule` — structured, versioned recurrence representation.
- `schedule_status` — active, paused, completed, or cancelled.
- `created_by_user_id`, `created_at`, `updated_at`, `deleted_at`.

The recurrence format, daylight-saving behavior, missed-task policy, and notification scheduling are open technical decisions. Do not encode recurrence as arbitrary natural-language text.

### 7.3 Care log

An actual event, not a planned task.

Suggested fields:

- `id`, `workspace_id`.
- `schedule_id` — optional; one-time care can exist without a schedule.
- `subject_kind`, `subject_id`.
- `performed_at`, `performed_by_user_id`.
- `care_category`, `status` — completed, partially completed, skipped, or recorded in error.
- `notes`, `quantity_value`, `quantity_unit` — optional.
- `created_at`, `updated_at`, `deleted_at`.

A care log records what the user says happened. It must not be fabricated from a schedule simply because a due time passed.

## 8. Health, feeding, and measurements

### 8.1 Health record

Suggested fields:

- `id`, `workspace_id`, `animal_profile_id`.
- `record_type` — observation, examination, vaccination record, medication administration record, procedure, or general note.
- `recorded_at`, `recorded_by_user_id`.
- `summary`, `details`, `provider_name` (optional).
- `source_or_document_reference` (optional).
- `created_at`, `updated_at`, `deleted_at`.

The application is a record-keeping tool. A stored user observation is not automatically a diagnosis. Medication history must record what was actually administered and by whom; the app must not invent dosages or prescribe treatment.

### 8.2 Feeding record

Suggested fields:

- `id`, `workspace_id`, `animal_profile_id`.
- `fed_at`, `food_name`, `food_category` (optional).
- `quantity_value`, `quantity_unit` — nullable when not measured; never default to zero.
- `feeding_method`, `notes` (optional).
- `recorded_by_user_id`, timestamps, tombstone.

For group feeding, link the record to the group profile and state whether the quantity is group-level, per-member, or estimated. Do not imply an individual intake when only a group amount was recorded.

### 8.3 Measurement record

Use one measurement record shape for animal and habitat observations, with a typed subject reference.

Suggested fields:

- `id`, `workspace_id`.
- `subject_kind` — animal profile or habitat.
- `subject_id`.
- `metric_key` — e.g. body_weight, body_length, water_temperature, humidity, or pH.
- `value` — numeric when a quantitative measurement exists; otherwise no measurement row should be created.
- `unit_code` — required.
- `measured_at`, `method`, `recorded_by_user_id`.
- `source_id` — optional.
- `created_at`, `updated_at`, `deleted_at`.

Store observations as separate events. Never overwrite an older measurement when a new measurement is taken. Reference ranges are species-, life-stage-, and context-dependent and must retain source and validation metadata.

## 9. Attachments

### 9.1 Attachment metadata

Suggested fields:

- `id`, `workspace_id`.
- `storage_key` — opaque storage reference, not a public URL.
- `file_name`, `media_type`, `size_bytes`, `checksum`.
- `upload_status` — local_only, queued, uploading, uploaded, failed, or deleted.
- `created_by_user_id`, timestamps, tombstone.

### 9.2 Attachment link

An attachment may be linked to an animal profile, health record, care log, habitat, or other approved record. Use an explicit link table with `target_kind` and `target_id`; validate the target exists in the same workspace. Local file paths and remote storage keys are separate fields and must not be confused.

Interrupted uploads must be resumable or safely retryable. Deleting a link must not automatically delete an attachment that is still referenced elsewhere.

## 10. Sync, audit, and deletion

### 10.1 Sync outbox

Suggested fields:

- `id` — unique operation/idempotency ID generated before sending.
- `workspace_id`, `entity_kind`, `entity_id`.
- `operation_kind` — create, update, or delete.
- `base_version` or server revision, when known.
- `payload` or a stable reference to the pending local change.
- `created_at`, `attempt_count`, `last_attempt_at`, `sync_status`, `last_error_code`.

A retry uses the same operation ID. The server must recognize duplicate submissions. A client must not mark an operation synchronized until the server confirms it.

### 10.2 Audit event

Suggested fields:

- `id`, `workspace_id`.
- `actor_user_id`, `action`, `entity_kind`, `entity_id`.
- `occurred_at`, `summary`, and a privacy-reviewed change reference.

Audit events should cover permission changes and other high-impact professional operations. Avoid copying sensitive full record contents into audit messages.

### 10.3 Tombstones

A deleted record receives `deleted_at` and a deletion operation in the outbox. Historical care, health, group membership, habitat assignment, and audit records must not be cascade-deleted merely because a profile is archived or removed from active lists. Final purge behavior depends on retention and privacy decisions.

## 11. Relationship overview

- One workspace has many memberships and many workspace-owned records.
- One user may belong to many workspaces through memberships.
- One species has many attribute definitions and source records.
- One animal profile has either individual details or group details, never both.
- One group has many time-bounded membership rows; each membership links one group to one individual profile in the same workspace.
- One animal profile may have many dynamic attribute values, habitat assignments, care schedules, care logs, health records, feeding records, measurements, and attachment links.
- One habitat may have child habitats, assignments, environmental measurements, and attachment links.
- One care schedule may have many care logs; a care log may also be independent of a schedule.
- One attachment may have multiple approved record links.
- Workspace-scoped changes may create outbox operations and audit events.

## 12. Invariants to enforce

These are domain invariants, regardless of database technology:

1. No workspace-scoped record can reference a user, species customization, profile, habitat, or attachment owned by another workspace.
2. Every `animal_profile` has exactly one valid subtype matching `record_kind`.
3. A group membership connects a group to an individual, never a group to itself or a nested group in version 1.
4. Effective date ranges must be valid: `valid_to` is null or later than `valid_from`.
5. Closing a membership or habitat assignment preserves the former row.
6. A measured value has an explicit valid unit.
7. Unknown or unmeasured is not represented by numeric zero.
8. A schedule is not proof that care was performed; only a care log records execution.
9. Dynamic attribute values must validate against the referenced definition version.
10. Deletes are synchronization-safe and cannot silently erase historical evidence.
11. Client-generated IDs and sync operation IDs remain stable across retries.
12. Server authorization is evaluated for every protected operation.

## 13. Suggested implementation order after model review

1. Approve workspace, species, animal profile, group, and habitat concepts.
2. Agree on local persistence and backend technologies.
3. Convert the logical model into versioned physical schemas and migration scripts.
4. Define dynamic-attribute JSON format and catalog version compatibility.
5. Define conflict policy by record type and deletion/retention policy.
6. Implement local repositories and validators.
7. Build animal and custom-species forms against the repository interfaces.
8. Add synchronization only after local persistence and deterministic tests are stable.

## 14. Decisions intentionally left open

- Local database engine and migration tooling.
- Cloud backend, authentication provider, and remote database.
- Whether dynamic values use JSON columns, typed value tables, or a hybrid.
- Taxonomy authority, licensing, localization, and update cadence.
- Attribute inheritance between taxonomic ranks.
- Exact life-stage model and derived-stage rules.
- Group counting and multi-group membership constraints.
- Habitat hierarchy depth and multi-habitat assignment behavior.
- Recurrence syntax, time-zone rules, and missed-task behavior.
- Permission matrix and audit retention.
- Attachment storage provider, encryption, size limits, and retention.
- Conflict handling per record type, including concurrent edits and tombstones.
- Privacy, export, account deletion, and backup policy.

**No physical database or code model should be generated from this proposal until these points are reviewed and the storage/backend direction is selected.**
