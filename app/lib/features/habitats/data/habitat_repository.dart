import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';

class HabitatRepository {
  HabitatRepository(this._database);

  final AppDatabase _database;
  static const Uuid _uuid = Uuid();

  Stream<List<Habitat>> watchHabitats(String workspaceId) {
    return (_database.select(_database.habitats)
          ..where(
            (table) =>
                table.workspaceId.equals(workspaceId) &
                table.deletedAt.isNull(),
          )
          ..orderBy([
            (table) => OrderingTerm.asc(table.name),
          ]))
        .watch();
  }

  Future<Habitat?> getHabitat({
    required String workspaceId,
    required String habitatId,
  }) {
    return (_database.select(_database.habitats)
          ..where(
            (table) =>
                table.id.equals(habitatId) &
                table.workspaceId.equals(workspaceId) &
                table.deletedAt.isNull(),
          ))
        .getSingleOrNull();
  }

  Future<String> createHabitat({
    required String workspaceId,
    required String name,
    required String habitatType,
    String? parentHabitatId,
    String? description,
    double? capacityValue,
    String? capacityUnit,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now().toUtc();
    final normalizedName = _validateName(name);
    final normalizedType = _validateType(habitatType);
    final normalizedDescription = _normalizeOptionalText(description);
    final normalizedUnit = _normalizeOptionalText(capacityUnit);
    _validateCapacity(capacityValue, normalizedUnit);

    await _database.transaction(() async {
      await _requireWorkspace(workspaceId);
      await _validateParent(
        workspaceId: workspaceId,
        parentHabitatId: parentHabitatId,
      );

      await _database.into(_database.habitats).insert(
            HabitatsCompanion.insert(
              id: id,
              workspaceId: workspaceId,
              parentHabitatId: Value(parentHabitatId),
              name: normalizedName,
              habitatType: normalizedType,
              status: const Value('active'),
              description: Value(normalizedDescription),
              capacityValue: Value(capacityValue),
              capacityUnit: Value(normalizedUnit),
              createdAt: now,
              updatedAt: now,
            ),
          );

      await _insertOutbox(
        operationId: _uuid.v4(),
        workspaceId: workspaceId,
        entityKind: 'habitat',
        entityId: id,
        operationKind: 'create',
        payload: {
          'id': id,
          'workspaceId': workspaceId,
          'parentHabitatId': parentHabitatId,
          'name': normalizedName,
          'habitatType': normalizedType,
          'status': 'active',
          'description': normalizedDescription,
          'capacityValue': capacityValue,
          'capacityUnit': normalizedUnit,
          'createdAt': now.toIso8601String(),
        },
        createdAt: now,
      );
    });

    return id;
  }

  Future<void> updateHabitat({
    required String workspaceId,
    required String habitatId,
    required String name,
    required String habitatType,
    String? parentHabitatId,
    String? description,
    double? capacityValue,
    String? capacityUnit,
  }) async {
    final now = DateTime.now().toUtc();
    final normalizedName = _validateName(name);
    final normalizedType = _validateType(habitatType);
    final normalizedDescription = _normalizeOptionalText(description);
    final normalizedUnit = _normalizeOptionalText(capacityUnit);
    _validateCapacity(capacityValue, normalizedUnit);

    await _database.transaction(() async {
      final current = await _requireHabitat(
        workspaceId: workspaceId,
        habitatId: habitatId,
      );
      await _validateParent(
        workspaceId: workspaceId,
        parentHabitatId: parentHabitatId,
        habitatId: habitatId,
      );

      await (_database.update(_database.habitats)
            ..where(
              (table) =>
                  table.id.equals(habitatId) &
                  table.workspaceId.equals(workspaceId) &
                  table.deletedAt.isNull(),
            ))
          .write(
        HabitatsCompanion(
          parentHabitatId: Value(parentHabitatId),
          name: Value(normalizedName),
          habitatType: Value(normalizedType),
          description: Value(normalizedDescription),
          capacityValue: Value(capacityValue),
          capacityUnit: Value(normalizedUnit),
          updatedAt: Value(now),
        ),
      );

      await _insertOutbox(
        operationId: _uuid.v4(),
        workspaceId: workspaceId,
        entityKind: 'habitat',
        entityId: habitatId,
        operationKind: 'update',
        payload: {
          'id': habitatId,
          'workspaceId': workspaceId,
          'parentHabitatId': parentHabitatId,
          'name': normalizedName,
          'habitatType': normalizedType,
          'status': current.status,
          'description': normalizedDescription,
          'capacityValue': capacityValue,
          'capacityUnit': normalizedUnit,
          'updatedAt': now.toIso8601String(),
        },
        createdAt: now,
      );
    });
  }

  Future<void> archiveHabitat({
    required String workspaceId,
    required String habitatId,
  }) async {
    final now = DateTime.now().toUtc();

    await _database.transaction(() async {
      final habitat = await _requireHabitat(
        workspaceId: workspaceId,
        habitatId: habitatId,
      );
      if (habitat.status == 'archived') return;

      final activeAssignments =
          await (_database.select(_database.animalHabitatAssignments)
                ..where(
                  (table) =>
                      table.workspaceId.equals(workspaceId) &
                      table.habitatId.equals(habitatId) &
                      table.validTo.isNull(),
                ))
              .get();

      if (activeAssignments.isNotEmpty) {
        throw StateError(
          'Habitat masih memiliki penempatan aktif. Pindahkan atau tutup '
          'penempatan terlebih dahulu sebelum mengarsipkan habitat.',
        );
      }

      await (_database.update(_database.habitats)
            ..where(
              (table) =>
                  table.id.equals(habitatId) &
                  table.workspaceId.equals(workspaceId) &
                  table.deletedAt.isNull(),
            ))
          .write(
        HabitatsCompanion(
          status: const Value('archived'),
          updatedAt: Value(now),
        ),
      );

      await _insertOutbox(
        operationId: _uuid.v4(),
        workspaceId: workspaceId,
        entityKind: 'habitat',
        entityId: habitatId,
        operationKind: 'update',
        payload: {
          'id': habitatId,
          'workspaceId': workspaceId,
          'status': 'archived',
          'updatedAt': now.toIso8601String(),
        },
        createdAt: now,
      );
    });
  }

  Future<String> assignProfile({
    required String workspaceId,
    required String profileId,
    required String habitatId,
    String assignmentRole = 'primary',
    required DateTime validFrom,
    String? note,
  }) async {
    if (assignmentRole != 'primary' && assignmentRole != 'secondary') {
      throw ArgumentError.value(
        assignmentRole,
        'assignmentRole',
        'Peran penempatan harus primary atau secondary.',
      );
    }

    final assignmentId = _uuid.v4();
    final effectiveFrom = validFrom.toUtc();
    final normalizedNote = _normalizeOptionalText(note);
    final now = DateTime.now().toUtc();

    await _database.transaction(() async {
      await _requireProfile(
        workspaceId: workspaceId,
        profileId: profileId,
      );
      final habitat = await _requireHabitat(
        workspaceId: workspaceId,
        habitatId: habitatId,
      );

      if (habitat.status != 'active') {
        throw StateError('Habitat tidak aktif dan tidak dapat menerima hewan.');
      }

      final duplicates = await (_database.select(
                _database.animalHabitatAssignments,
              )
              ..where(
                (table) =>
                    table.workspaceId.equals(workspaceId) &
                    table.animalProfileId.equals(profileId) &
                    table.habitatId.equals(habitatId) &
                    table.assignmentRole.equals(assignmentRole) &
                    table.validTo.isNull(),
              )
              ..orderBy([
                (table) => OrderingTerm.desc(table.validFrom),
              ]))
          .get();

      if (duplicates.isNotEmpty) {
        return;
      }

      if (assignmentRole == 'primary') {
        final activePrimaryAssignments =
            await (_database.select(_database.animalHabitatAssignments)
                  ..where(
                    (table) =>
                        table.workspaceId.equals(workspaceId) &
                        table.animalProfileId.equals(profileId) &
                        table.assignmentRole.equals('primary') &
                        table.validTo.isNull(),
                  ))
                .get();

        for (final previous in activePrimaryAssignments) {
          if (!effectiveFrom.isAfter(previous.validFrom.toUtc())) {
            throw ArgumentError(
              'Tanggal penempatan baru harus lebih akhir daripada awal '
              'penempatan utama yang sedang aktif.',
            );
          }

          await (_database.update(_database.animalHabitatAssignments)
                ..where((table) => table.id.equals(previous.id)))
              .write(
            AnimalHabitatAssignmentsCompanion(
              validTo: Value(effectiveFrom),
            ),
          );

          await _insertOutbox(
            operationId: _uuid.v4(),
            workspaceId: workspaceId,
            entityKind: 'animal_habitat_assignment',
            entityId: previous.id,
            operationKind: 'update',
            payload: {
              'id': previous.id,
              'workspaceId': workspaceId,
              'animalProfileId': profileId,
              'habitatId': previous.habitatId,
              'assignmentRole': previous.assignmentRole,
              'validFrom': previous.validFrom.toUtc().toIso8601String(),
              'validTo': effectiveFrom.toIso8601String(),
              'note': previous.note,
            },
            createdAt: now,
          );
        }
      }

      await _database.into(_database.animalHabitatAssignments).insert(
            AnimalHabitatAssignmentsCompanion.insert(
              id: assignmentId,
              workspaceId: workspaceId,
              animalProfileId: profileId,
              habitatId: habitatId,
              assignmentRole: Value(assignmentRole),
              validFrom: effectiveFrom,
              validTo: const Value(null),
              note: Value(normalizedNote),
              createdAt: now,
            ),
          );

      await _insertOutbox(
        operationId: _uuid.v4(),
        workspaceId: workspaceId,
        entityKind: 'animal_habitat_assignment',
        entityId: assignmentId,
        operationKind: 'create',
        payload: {
          'id': assignmentId,
          'workspaceId': workspaceId,
          'animalProfileId': profileId,
          'habitatId': habitatId,
          'assignmentRole': assignmentRole,
          'validFrom': effectiveFrom.toIso8601String(),
          'validTo': null,
          'note': normalizedNote,
          'createdAt': now.toIso8601String(),
        },
        createdAt: now,
      );
    });

    final current = await (_database.select(
              _database.animalHabitatAssignments,
            )
            ..where(
              (table) =>
                  table.workspaceId.equals(workspaceId) &
                  table.animalProfileId.equals(profileId) &
                  table.habitatId.equals(habitatId) &
                  table.assignmentRole.equals(assignmentRole) &
                  table.validTo.isNull(),
            )
            ..orderBy([
              (table) => OrderingTerm.desc(table.validFrom),
            ]))
        .get();

    return current.isEmpty ? assignmentId : current.first.id;
  }

  Future<void> closeAssignment({
    required String workspaceId,
    required String assignmentId,
    required DateTime validTo,
  }) async {
    final effectiveTo = validTo.toUtc();
    final now = DateTime.now().toUtc();

    await _database.transaction(() async {
      final assignment = await (_database.select(
                _database.animalHabitatAssignments,
              )
              ..where(
                (table) =>
                    table.id.equals(assignmentId) &
                    table.workspaceId.equals(workspaceId),
              ))
          .getSingleOrNull();

      if (assignment == null) {
        throw StateError('Riwayat penempatan tidak ditemukan.');
      }
      if (assignment.validTo != null) {
        throw StateError('Penempatan ini sudah ditutup sebelumnya.');
      }
      if (!effectiveTo.isAfter(assignment.validFrom.toUtc())) {
        throw ArgumentError(
          'Tanggal akhir harus lebih akhir daripada tanggal mulai penempatan.',
        );
      }

      await (_database.update(_database.animalHabitatAssignments)
            ..where(
              (table) =>
                  table.id.equals(assignmentId) &
                  table.workspaceId.equals(workspaceId) &
                  table.validTo.isNull(),
            ))
          .write(
        AnimalHabitatAssignmentsCompanion(
          validTo: Value(effectiveTo),
        ),
      );

      await _insertOutbox(
        operationId: _uuid.v4(),
        workspaceId: workspaceId,
        entityKind: 'animal_habitat_assignment',
        entityId: assignmentId,
        operationKind: 'update',
        payload: {
          'id': assignment.id,
          'workspaceId': workspaceId,
          'animalProfileId': assignment.animalProfileId,
          'habitatId': assignment.habitatId,
          'assignmentRole': assignment.assignmentRole,
          'validFrom': assignment.validFrom.toUtc().toIso8601String(),
          'validTo': effectiveTo.toIso8601String(),
          'note': assignment.note,
        },
        createdAt: now,
      );
    });
  }

  Future<List<HabitatAssignmentEntry>> getAssignmentsForHabitat({
    required String workspaceId,
    required String habitatId,
  }) async {
    final assignments = await (_database.select(
              _database.animalHabitatAssignments,
            )
            ..where(
              (table) =>
                  table.workspaceId.equals(workspaceId) &
                  table.habitatId.equals(habitatId),
            )
            ..orderBy([
              (table) => OrderingTerm.desc(table.validFrom),
            ]))
        .get();

    final entries = <HabitatAssignmentEntry>[];
    for (final assignment in assignments) {
      final profile = await (_database.select(_database.animalProfiles)
            ..where((table) => table.id.equals(assignment.animalProfileId)))
          .getSingleOrNull();
      entries.add(
        HabitatAssignmentEntry(
          assignment: assignment,
          profile: profile,
        ),
      );
    }
    return entries;
  }

  Future<List<HabitatAssignmentEntry>> getAssignmentsForProfile({
    required String workspaceId,
    required String profileId,
  }) async {
    final assignments = await (_database.select(
              _database.animalHabitatAssignments,
            )
            ..where(
              (table) =>
                  table.workspaceId.equals(workspaceId) &
                  table.animalProfileId.equals(profileId),
            )
            ..orderBy([
              (table) => OrderingTerm.desc(table.validFrom),
            ]))
        .get();

    final entries = <HabitatAssignmentEntry>[];
    for (final assignment in assignments) {
      final habitat = await (_database.select(_database.habitats)
            ..where((table) => table.id.equals(assignment.habitatId)))
          .getSingleOrNull();
      entries.add(
        HabitatAssignmentEntry(
          assignment: assignment,
          habitat: habitat,
        ),
      );
    }
    return entries;
  }

  Future<void> _requireWorkspace(String workspaceId) async {
    final workspace = await (_database.select(_database.workspaces)
          ..where(
            (table) =>
                table.id.equals(workspaceId) & table.deletedAt.isNull(),
          ))
        .getSingleOrNull();
    if (workspace == null) {
      throw StateError('Workspace tidak ditemukan atau sudah diarsipkan.');
    }
  }

  Future<Habitat> _requireHabitat({
    required String workspaceId,
    required String habitatId,
  }) async {
    final habitat = await getHabitat(
      workspaceId: workspaceId,
      habitatId: habitatId,
    );
    if (habitat == null) {
      throw StateError('Habitat tidak ditemukan pada workspace ini.');
    }
    return habitat;
  }

  Future<void> _requireProfile({
    required String workspaceId,
    required String profileId,
  }) async {
    final profile = await (_database.select(_database.animalProfiles)
          ..where(
            (table) =>
                table.id.equals(profileId) &
                table.workspaceId.equals(workspaceId) &
                table.deletedAt.isNull(),
          ))
        .getSingleOrNull();
    if (profile == null) {
      throw StateError('Profil hewan tidak ditemukan pada workspace ini.');
    }
  }

  Future<void> _validateParent({
    required String workspaceId,
    required String? parentHabitatId,
    String? habitatId,
  }) async {
    if (parentHabitatId == null) return;

    final visited = <String>{};
    String? currentId = parentHabitatId;

    while (currentId != null) {
      if (currentId == habitatId) {
        throw ArgumentError('Habitat tidak dapat menjadi induk dirinya sendiri.');
      }
      if (!visited.add(currentId)) {
        throw ArgumentError('Hierarki habitat memiliki siklus.');
      }

      final current = await _requireHabitat(
        workspaceId: workspaceId,
        habitatId: currentId,
      );
      currentId = current.parentHabitatId;
    }
  }

  Future<void> _insertOutbox({
    required String operationId,
    required String workspaceId,
    required String entityKind,
    required String entityId,
    required String operationKind,
    required Map<String, Object?> payload,
    required DateTime createdAt,
  }) async {
    await _database.into(_database.syncOutbox).insert(
          SyncOutboxCompanion.insert(
            operationId: operationId,
            workspaceId: workspaceId,
            entityKind: entityKind,
            entityId: entityId,
            operationKind: operationKind,
            payloadJson: jsonEncode(payload),
            createdAt: createdAt,
          ),
        );
  }

  String _validateName(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) {
      throw ArgumentError('Nama habitat wajib diisi.');
    }
    if (normalized.length > 160) {
      throw ArgumentError('Nama habitat maksimal 160 karakter.');
    }
    return normalized;
  }

  String _validateType(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) {
      throw ArgumentError('Jenis habitat wajib dipilih.');
    }
    if (normalized.length > 60) {
      throw ArgumentError('Jenis habitat maksimal 60 karakter.');
    }
    return normalized;
  }

  String? _normalizeOptionalText(String? value) {
    final normalized = value?.trim();
    return normalized == null || normalized.isEmpty ? null : normalized;
  }

  void _validateCapacity(double? value, String? unit) {
    if (value == null && unit != null) {
      throw ArgumentError(
        'Satuan kapasitas hanya dapat diisi bersama nilai kapasitas.',
      );
    }
    if (value != null && (unit == null || !value.isFinite || value <= 0)) {
      throw ArgumentError(
        'Kapasitas harus berupa angka positif dengan satuan yang jelas.',
      );
    }
  }
}

class HabitatAssignmentEntry {
  const HabitatAssignmentEntry({
    required this.assignment,
    this.profile,
    this.habitat,
  });

  final AnimalHabitatAssignment assignment;
  final AnimalProfile? profile;
  final Habitat? habitat;
}
