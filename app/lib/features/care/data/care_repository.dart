import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';

class CareRepository {
  CareRepository(this._database);

  final AppDatabase _database;
  static const Uuid _uuid = Uuid();

  static const Set<String> careTypes = {
    'feeding',
    'cleaning',
    'grooming',
    'medication',
    'exercise',
    'health_check',
    'measurement',
    'enrichment',
    'other',
  };

  static const Set<String> recurrenceTypes = {
    'once',
    'daily',
    'weekly',
    'interval',
  };

  Stream<List<CareScheduleEntry>> watchSchedules(String workspaceId) {
    final query = _database.select(_database.careSchedules).join([
      innerJoin(
        _database.animalProfiles,
        _database.animalProfiles.id.equalsExp(
          _database.careSchedules.animalProfileId,
        ),
      ),
    ]);

    query
      ..where(
        _database.careSchedules.workspaceId.equals(workspaceId) &
            _database.careSchedules.archivedAt.isNull() &
            _database.animalProfiles.deletedAt.isNull(),
      )
      ..orderBy([
        OrderingTerm.asc(_database.careSchedules.isActive),
        OrderingTerm.asc(_database.careSchedules.nextDueAt),
      ]);

    return query.watch().map(
          (rows) => rows
              .map(
                (row) => CareScheduleEntry(
                  schedule: row.readTable(_database.careSchedules),
                  profile: row.readTable(_database.animalProfiles),
                ),
              )
              .toList(growable: false),
        );
  }

  Stream<List<CareRecordEntry>> watchRecords(String workspaceId) {
    final query = _database.select(_database.careRecords).join([
      innerJoin(
        _database.animalProfiles,
        _database.animalProfiles.id.equalsExp(
          _database.careRecords.animalProfileId,
        ),
      ),
    ]);

    query
      ..where(
        _database.careRecords.workspaceId.equals(workspaceId) &
            _database.animalProfiles.deletedAt.isNull(),
      )
      ..orderBy([
        OrderingTerm.desc(_database.careRecords.performedAt),
      ])
      ..limit(100);

    return query.watch().map(
          (rows) => rows
              .map(
                (row) => CareRecordEntry(
                  record: row.readTable(_database.careRecords),
                  profile: row.readTable(_database.animalProfiles),
                ),
              )
              .toList(growable: false),
        );
  }

  Future<String> createSchedule({
    required String workspaceId,
    required String animalProfileId,
    required String title,
    required String careType,
    required String recurrenceType,
    required DateTime scheduledAt,
    int? intervalDays,
    String? instructions,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now().toUtc();
    final normalizedTitle = _validateTitle(title);
    final normalizedType = _validateCareType(careType);
    _validateRecurrence(recurrenceType, intervalDays);
    final normalizedInstructions = _normalizeOptionalText(instructions);
    final effectiveStart = scheduledAt.toUtc();

    await _database.transaction(() async {
      await _requireProfile(
        workspaceId: workspaceId,
        profileId: animalProfileId,
      );

      await _database.into(_database.careSchedules).insert(
            CareSchedulesCompanion.insert(
              id: id,
              workspaceId: workspaceId,
              animalProfileId: animalProfileId,
              title: normalizedTitle,
              careType: normalizedType,
              instructions: Value(normalizedInstructions),
              recurrenceType: Value(recurrenceType),
              intervalDays: Value(intervalDays),
              scheduledAt: effectiveStart,
              nextDueAt: effectiveStart,
              isActive: const Value(true),
              createdAt: now,
              updatedAt: now,
            ),
          );

      await _insertOutbox(
        operationId: _uuid.v4(),
        workspaceId: workspaceId,
        entityKind: 'care_schedule',
        entityId: id,
        operationKind: 'create',
        payload: {
          'id': id,
          'workspaceId': workspaceId,
          'animalProfileId': animalProfileId,
          'title': normalizedTitle,
          'careType': normalizedType,
          'instructions': normalizedInstructions,
          'recurrenceType': recurrenceType,
          'intervalDays': intervalDays,
          'scheduledAt': effectiveStart.toIso8601String(),
          'nextDueAt': effectiveStart.toIso8601String(),
          'isActive': true,
          'createdAt': now.toIso8601String(),
        },
        createdAt: now,
      );
    });

    return id;
  }

  Future<void> archiveSchedule({
    required String workspaceId,
    required String scheduleId,
  }) async {
    final now = DateTime.now().toUtc();

    await _database.transaction(() async {
      final schedule = await _requireSchedule(
        workspaceId: workspaceId,
        scheduleId: scheduleId,
      );
      if (schedule.archivedAt != null) return;

      await (_database.update(_database.careSchedules)
            ..where(
              (table) =>
                  table.id.equals(scheduleId) &
                  table.workspaceId.equals(workspaceId) &
                  table.archivedAt.isNull(),
            ))
          .write(
        CareSchedulesCompanion(
          isActive: const Value(false),
          archivedAt: Value(now),
          updatedAt: Value(now),
        ),
      );

      await _insertOutbox(
        operationId: _uuid.v4(),
        workspaceId: workspaceId,
        entityKind: 'care_schedule',
        entityId: scheduleId,
        operationKind: 'update',
        payload: {
          'id': scheduleId,
          'workspaceId': workspaceId,
          'animalProfileId': schedule.animalProfileId,
          'isActive': false,
          'archivedAt': now.toIso8601String(),
          'updatedAt': now.toIso8601String(),
        },
        createdAt: now,
      );
    });
  }

  Future<String> completeSchedule({
    required String workspaceId,
    required String scheduleId,
    DateTime? performedAt,
    double? quantityValue,
    String? quantityUnit,
    String? notes,
  }) async {
    final recordId = _uuid.v4();
    final now = DateTime.now().toUtc();
    final effectivePerformedAt = (performedAt ?? now).toUtc();
    final normalizedUnit = _normalizeOptionalText(quantityUnit);
    final normalizedNotes = _normalizeOptionalText(notes);
    _validateQuantity(quantityValue, normalizedUnit);

    await _database.transaction(() async {
      final schedule = await _requireSchedule(
        workspaceId: workspaceId,
        scheduleId: scheduleId,
      );
      if (!schedule.isActive || schedule.archivedAt != null) {
        throw StateError('Jadwal ini tidak aktif dan tidak dapat diselesaikan.');
      }

      final scheduledFor = schedule.nextDueAt.toUtc();
      await _database.into(_database.careRecords).insert(
            CareRecordsCompanion.insert(
              id: recordId,
              workspaceId: workspaceId,
              animalProfileId: schedule.animalProfileId,
              scheduleId: Value(scheduleId),
              careType: schedule.careType,
              title: schedule.title,
              performedAt: effectivePerformedAt,
              scheduledFor: Value(scheduledFor),
              quantityValue: Value(quantityValue),
              quantityUnit: Value(normalizedUnit),
              notes: Value(normalizedNotes),
              createdAt: now,
            ),
          );

      final isOneTime = schedule.recurrenceType == 'once';
      final nextDueAt = isOneTime
          ? schedule.nextDueAt.toUtc()
          : _nextOccurrence(
              currentDue: schedule.nextDueAt.toUtc(),
              performedAt: effectivePerformedAt,
              recurrenceType: schedule.recurrenceType,
              intervalDays: schedule.intervalDays,
            );

      await (_database.update(_database.careSchedules)
            ..where(
              (table) =>
                  table.id.equals(scheduleId) &
                  table.workspaceId.equals(workspaceId) &
                  table.isActive.equals(true) &
                  table.archivedAt.isNull(),
            ))
          .write(
        CareSchedulesCompanion(
          isActive: Value(!isOneTime),
          lastCompletedAt: Value(effectivePerformedAt),
          nextDueAt: Value(nextDueAt),
          updatedAt: Value(now),
        ),
      );

      await _insertOutbox(
        operationId: _uuid.v4(),
        workspaceId: workspaceId,
        entityKind: 'care_record',
        entityId: recordId,
        operationKind: 'create',
        payload: {
          'id': recordId,
          'workspaceId': workspaceId,
          'animalProfileId': schedule.animalProfileId,
          'scheduleId': scheduleId,
          'careType': schedule.careType,
          'title': schedule.title,
          'performedAt': effectivePerformedAt.toIso8601String(),
          'scheduledFor': scheduledFor.toIso8601String(),
          'quantityValue': quantityValue,
          'quantityUnit': normalizedUnit,
          'notes': normalizedNotes,
          'createdAt': now.toIso8601String(),
        },
        createdAt: now,
      );

      await _insertOutbox(
        operationId: _uuid.v4(),
        workspaceId: workspaceId,
        entityKind: 'care_schedule',
        entityId: scheduleId,
        operationKind: 'update',
        payload: {
          'id': scheduleId,
          'workspaceId': workspaceId,
          'animalProfileId': schedule.animalProfileId,
          'isActive': !isOneTime,
          'lastCompletedAt': effectivePerformedAt.toIso8601String(),
          'nextDueAt': nextDueAt.toIso8601String(),
          'updatedAt': now.toIso8601String(),
        },
        createdAt: now,
      );
    });

    return recordId;
  }

  Future<String> recordCare({
    required String workspaceId,
    required String animalProfileId,
    required String title,
    required String careType,
    DateTime? performedAt,
    double? quantityValue,
    String? quantityUnit,
    String? notes,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now().toUtc();
    final effectivePerformedAt = (performedAt ?? now).toUtc();
    final normalizedTitle = _validateTitle(title);
    final normalizedType = _validateCareType(careType);
    final normalizedUnit = _normalizeOptionalText(quantityUnit);
    final normalizedNotes = _normalizeOptionalText(notes);
    _validateQuantity(quantityValue, normalizedUnit);

    await _database.transaction(() async {
      await _requireProfile(
        workspaceId: workspaceId,
        profileId: animalProfileId,
      );

      await _database.into(_database.careRecords).insert(
            CareRecordsCompanion.insert(
              id: id,
              workspaceId: workspaceId,
              animalProfileId: animalProfileId,
              scheduleId: const Value(null),
              careType: normalizedType,
              title: normalizedTitle,
              performedAt: effectivePerformedAt,
              scheduledFor: const Value(null),
              quantityValue: Value(quantityValue),
              quantityUnit: Value(normalizedUnit),
              notes: Value(normalizedNotes),
              createdAt: now,
            ),
          );

      await _insertOutbox(
        operationId: _uuid.v4(),
        workspaceId: workspaceId,
        entityKind: 'care_record',
        entityId: id,
        operationKind: 'create',
        payload: {
          'id': id,
          'workspaceId': workspaceId,
          'animalProfileId': animalProfileId,
          'scheduleId': null,
          'careType': normalizedType,
          'title': normalizedTitle,
          'performedAt': effectivePerformedAt.toIso8601String(),
          'scheduledFor': null,
          'quantityValue': quantityValue,
          'quantityUnit': normalizedUnit,
          'notes': normalizedNotes,
          'createdAt': now.toIso8601String(),
        },
        createdAt: now,
      );
    });

    return id;
  }

  Future<CareSchedule> _requireSchedule({
    required String workspaceId,
    required String scheduleId,
  }) async {
    final schedule = await (_database.select(_database.careSchedules)
          ..where(
            (table) =>
                table.id.equals(scheduleId) &
                table.workspaceId.equals(workspaceId),
          ))
        .getSingleOrNull();

    if (schedule == null) {
      throw StateError('Jadwal tidak ditemukan pada workspace ini.');
    }
    return schedule;
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

  DateTime _nextOccurrence({
    required DateTime currentDue,
    required DateTime performedAt,
    required String recurrenceType,
    required int? intervalDays,
  }) {
    final days = switch (recurrenceType) {
      'daily' => 1,
      'weekly' => 7,
      'interval' => intervalDays!,
      _ => throw StateError('Jenis pengulangan jadwal tidak valid.'),
    };

    var next = currentDue.add(Duration(days: days));
    while (!next.isAfter(performedAt)) {
      next = next.add(Duration(days: days));
    }
    return next;
  }

  String _validateTitle(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) {
      throw ArgumentError('Nama kegiatan wajib diisi.');
    }
    if (normalized.length > 160) {
      throw ArgumentError('Nama kegiatan maksimal 160 karakter.');
    }
    return normalized;
  }

  String _validateCareType(String value) {
    if (!careTypes.contains(value)) {
      throw ArgumentError.value(value, 'careType', 'Jenis perawatan tidak valid.');
    }
    return value;
  }

  void _validateRecurrence(String recurrenceType, int? intervalDays) {
    if (!recurrenceTypes.contains(recurrenceType)) {
      throw ArgumentError.value(
        recurrenceType,
        'recurrenceType',
        'Pola pengulangan jadwal tidak valid.',
      );
    }
    if (recurrenceType == 'interval') {
      if (intervalDays == null || intervalDays < 1 || intervalDays > 365) {
        throw ArgumentError(
          'Interval harus diisi antara 1 sampai 365 hari.',
        );
      }
    } else if (intervalDays != null) {
      throw ArgumentError(
        'Interval hari hanya digunakan untuk pola setiap beberapa hari.',
      );
    }
  }

  void _validateQuantity(double? value, String? unit) {
    if (value == null && unit == null) return;
    if (value == null ||
        unit == null ||
        !value.isFinite ||
        value <= 0 ||
        unit.length > 32) {
      throw ArgumentError(
        'Takaran harus berupa angka positif dengan satuan yang jelas.',
      );
    }
  }

  String? _normalizeOptionalText(String? value) {
    final normalized = value?.trim();
    return normalized == null || normalized.isEmpty ? null : normalized;
  }
}

class CareScheduleEntry {
  const CareScheduleEntry({
    required this.schedule,
    required this.profile,
  });

  final CareSchedule schedule;
  final AnimalProfile profile;
}

class CareRecordEntry {
  const CareRecordEntry({
    required this.record,
    required this.profile,
  });

  final CareRecord record;
  final AnimalProfile profile;
}
