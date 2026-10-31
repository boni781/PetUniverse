import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';

class AnimalRepository {
  AnimalRepository(this._database);

  final AppDatabase _database;
  static const Uuid _uuid = Uuid();

  Stream<List<AnimalProfile>> watchProfiles(String workspaceId) {
    return (_database.select(_database.animalProfiles)
          ..where(
            (table) =>
                table.workspaceId.equals(workspaceId) &
                table.deletedAt.isNull(),
          )
          ..orderBy([(table) => OrderingTerm.desc(table.createdAt)]))
        .watch();
  }

  Stream<int> watchProfileCount(String workspaceId) {
    return watchProfiles(workspaceId).map((profiles) => profiles.length);
  }

  Future<AnimalProfile?> getProfileById(String id) {
    return (_database.select(_database.animalProfiles)
          ..where((table) => table.id.equals(id)))
        .getSingleOrNull();
  }

  Future<String> createIndividual({
    required String workspaceId,
    required String displayName,
    String? speciesId,
    String? notes,
  }) async {
    final id = _uuid.v4();
    final operationId = _uuid.v4();
    final now = DateTime.now().toUtc();
    final name = displayName.trim();

    if (name.isEmpty) {
      throw ArgumentError.value(displayName, 'displayName', 'Nama wajib diisi.');
    }

    await _database.transaction(() async {
      await _database.into(_database.animalProfiles).insert(
            AnimalProfilesCompanion.insert(
              id: id,
              workspaceId: workspaceId,
              recordKind: 'individual',
              displayName: name,
              speciesId: Value(speciesId),
              profileStatus: const Value('active'),
              notes: Value(_normalizeOptionalText(notes)),
              createdAt: now,
              updatedAt: now,
            ),
          );

      await _database.into(_database.individualDetails).insert(
            IndividualDetailsCompanion.insert(animalProfileId: id),
          );

      await _insertOutbox(
        operationId: operationId,
        workspaceId: workspaceId,
        entityId: id,
        payload: {
          'id': id,
          'workspaceId': workspaceId,
          'recordKind': 'individual',
          'displayName': name,
          'speciesId': speciesId,
          'notes': _normalizeOptionalText(notes),
          'createdAt': now.toIso8601String(),
        },
        createdAt: now,
      );
    });

    return id;
  }

  Future<String> createGroup({
    required String workspaceId,
    required String displayName,
    String? speciesId,
    String? notes,
    String memberTrackingMode = 'not_tracked',
    int? reportedCount,
    DateTime? countObservedAt,
  }) async {
    final id = _uuid.v4();
    final operationId = _uuid.v4();
    final now = DateTime.now().toUtc();
    final name = displayName.trim();

    if (name.isEmpty) {
      throw ArgumentError.value(displayName, 'displayName', 'Nama wajib diisi.');
    }
    if (!const {'tracked', 'estimated', 'not_tracked'}
        .contains(memberTrackingMode)) {
      throw ArgumentError.value(
        memberTrackingMode,
        'memberTrackingMode',
        'Mode pelacakan kelompok tidak valid.',
      );
    }
    if (memberTrackingMode == 'tracked' && reportedCount != null) {
      throw ArgumentError(
        'Kelompok tracked menggunakan jumlah anggota dari data keanggotaan.',
      );
    }
    if (reportedCount != null && reportedCount < 0) {
      throw ArgumentError.value(reportedCount, 'reportedCount');
    }
    if (reportedCount != null && countObservedAt == null) {
      throw ArgumentError(
        'Tanggal pengamatan diperlukan saat jumlah perkiraan diisi.',
      );
    }

    await _database.transaction(() async {
      await _database.into(_database.animalProfiles).insert(
            AnimalProfilesCompanion.insert(
              id: id,
              workspaceId: workspaceId,
              recordKind: 'group',
              displayName: name,
              speciesId: Value(speciesId),
              profileStatus: const Value('active'),
              notes: Value(_normalizeOptionalText(notes)),
              createdAt: now,
              updatedAt: now,
            ),
          );

      await _database.into(_database.groupDetails).insert(
            GroupDetailsCompanion.insert(
              animalProfileId: id,
              memberTrackingMode: memberTrackingMode,
              reportedCount: Value(reportedCount),
              countObservedAt: Value(countObservedAt?.toUtc()),
            ),
          );

      await _insertOutbox(
        operationId: operationId,
        workspaceId: workspaceId,
        entityId: id,
        payload: {
          'id': id,
          'workspaceId': workspaceId,
          'recordKind': 'group',
          'displayName': name,
          'speciesId': speciesId,
          'notes': _normalizeOptionalText(notes),
          'memberTrackingMode': memberTrackingMode,
          'reportedCount': reportedCount,
          'countObservedAt': countObservedAt?.toUtc().toIso8601String(),
          'createdAt': now.toIso8601String(),
        },
        createdAt: now,
      );
    });

    return id;
  }

  Future<void> _insertOutbox({
    required String operationId,
    required String workspaceId,
    required String entityId,
    required Map<String, Object?> payload,
    required DateTime createdAt,
  }) async {
    await _database.into(_database.syncOutbox).insert(
          SyncOutboxCompanion.insert(
            operationId: operationId,
            workspaceId: workspaceId,
            entityKind: 'animal_profile',
            entityId: entityId,
            operationKind: 'create',
            payloadVersion: const Value(1),
            payloadJson: jsonEncode(payload),
            createdAt: createdAt,
          ),
        );
  }

  String? _normalizeOptionalText(String? value) {
    final normalized = value?.trim();
    return normalized == null || normalized.isEmpty ? null : normalized;
  }
}
