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
          ..where(
            (table) => table.id.equals(id) & table.deletedAt.isNull(),
          ))
        .getSingleOrNull();
  }

  Future<String> createIndividual({
    required String workspaceId,
    required String displayName,
    String? speciesId,
    String? notes,
    String? sexCode,
    DateTime? birthDate,
    String? birthDatePrecision,
    DateTime? acquiredAt,
    String? lifeStageCode,
    Map<String, Object?> attributeValues = const {},
  }) async {
    final id = _uuid.v4();
    final operationId = _uuid.v4();
    final now = DateTime.now().toUtc();
    final name = _validateName(displayName);
    final normalizedSex = _normalizeOptionalText(sexCode);
    final normalizedLifeStage = _normalizeOptionalText(lifeStageCode);
    final precision = _validateBirthDate(
      birthDate: birthDate,
      precision: birthDatePrecision,
    );

    await _database.transaction(() async {
      final normalizedAttributes = await _validateAttributeValues(
        workspaceId: workspaceId,
        speciesId: speciesId,
        recordKind: 'individual',
        values: attributeValues,
      );

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
            IndividualDetailsCompanion.insert(
              animalProfileId: id,
              sexCode: Value(normalizedSex),
              birthDate: Value(birthDate?.toUtc()),
              birthDatePrecision: Value(precision),
              acquiredAt: Value(acquiredAt?.toUtc()),
              lifeStageCode: Value(normalizedLifeStage),
              lifeStageSource: Value(
                normalizedLifeStage == null ? null : 'user_selected',
              ),
            ),
          );

      await _insertAttributeRows(
        workspaceId: workspaceId,
        animalProfileId: id,
        values: normalizedAttributes,
        now: now,
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
          'individualDetails': {
            'sexCode': normalizedSex,
            'birthDate': birthDate?.toUtc().toIso8601String(),
            'birthDatePrecision': precision,
            'acquiredAt': acquiredAt?.toUtc().toIso8601String(),
            'lifeStageCode': normalizedLifeStage,
            'lifeStageSource':
                normalizedLifeStage == null ? null : 'user_selected',
          },
          'attributes': normalizedAttributes
              .map((value) => {
                    'definitionId': value.definition.id,
                    'value': value.serializedValue,
                    'unitCode': value.definition.unitCode,
                  })
              .toList(),
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
    String? groupPurpose,
    String? countNote,
    Map<String, Object?> attributeValues = const {},
  }) async {
    final id = _uuid.v4();
    final operationId = _uuid.v4();
    final now = DateTime.now().toUtc();
    final name = _validateName(displayName);
    final normalizedPurpose = _normalizeOptionalText(groupPurpose);
    final normalizedCountNote = _normalizeOptionalText(countNote);

    _validateGroupCount(
      memberTrackingMode: memberTrackingMode,
      reportedCount: reportedCount,
      countObservedAt: countObservedAt,
    );

    await _database.transaction(() async {
      final normalizedAttributes = await _validateAttributeValues(
        workspaceId: workspaceId,
        speciesId: speciesId,
        recordKind: 'group',
        values: attributeValues,
      );

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
              groupPurpose: Value(normalizedPurpose),
              memberTrackingMode: memberTrackingMode,
              reportedCount: Value(reportedCount),
              countObservedAt: Value(countObservedAt?.toUtc()),
              countNote: Value(normalizedCountNote),
            ),
          );

      await _insertAttributeRows(
        workspaceId: workspaceId,
        animalProfileId: id,
        values: normalizedAttributes,
        now: now,
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
          'groupDetails': {
            'groupPurpose': normalizedPurpose,
            'memberTrackingMode': memberTrackingMode,
            'reportedCount': reportedCount,
            'countObservedAt': countObservedAt?.toUtc().toIso8601String(),
            'countNote': normalizedCountNote,
          },
          'attributes': normalizedAttributes
              .map((value) => {
                    'definitionId': value.definition.id,
                    'value': value.serializedValue,
                    'unitCode': value.definition.unitCode,
                  })
              .toList(),
          'createdAt': now.toIso8601String(),
        },
        createdAt: now,
      );
    });

    return id;
  }

  Future<List<_NormalizedAttributeValue>> _validateAttributeValues({
    required String workspaceId,
    required String? speciesId,
    required String recordKind,
    required Map<String, Object?> values,
  }) async {
    if (speciesId == null) {
      if (values.isNotEmpty) {
        throw ArgumentError(
          'Atribut khusus tidak dapat disimpan tanpa memilih spesies.',
        );
      }
      return const [];
    }

    final species = await (_database.select(_database.species)
          ..where(
            (table) =>
                table.id.equals(speciesId) & table.deletedAt.isNull(),
          ))
        .getSingleOrNull();
    if (species == null ||
        (species.origin != 'catalog' &&
            species.workspaceId != workspaceId)) {
      throw ArgumentError(
        'Spesies tidak tersedia pada workspace yang aktif.',
      );
    }

    final definitions =
        await (_database.select(_database.speciesAttributeDefinitions)
              ..where((table) => table.speciesId.equals(speciesId))
              ..orderBy([(table) => OrderingTerm.asc(table.displayOrder)]))
            .get();

    final applicableDefinitions = definitions
        .where(
          (definition) =>
              definition.appliesTo == 'both' ||
              definition.appliesTo == recordKind,
        )
        .toList(growable: false);
    final definitionsById = {
      for (final definition in applicableDefinitions)
        definition.id: definition,
    };

    final unknownIds = values.keys
        .where((id) => !definitionsById.containsKey(id))
        .toList(growable: false);
    if (unknownIds.isNotEmpty) {
      throw ArgumentError(
        'Ada atribut yang tidak terdaftar untuk jenis profil ini: '
        '${unknownIds.join(', ')}.',
      );
    }

    final result = <_NormalizedAttributeValue>[];
    for (final definition in applicableDefinitions) {
      final rawValue = values[definition.id];
      final hasValue = values.containsKey(definition.id) &&
          rawValue != null &&
          !(rawValue is String && rawValue.trim().isEmpty) &&
          !(rawValue is List && rawValue.isEmpty);

      if (!hasValue) {
        if (definition.isRequired) {
          throw ArgumentError('Atribut "${definition.label}" wajib diisi.');
        }
        continue;
      }

      final serializedValue = _serializeAttributeValue(
        definition: definition,
        value: rawValue,
      );
      result.add(
        _NormalizedAttributeValue(
          definition: definition,
          serializedValue: serializedValue,
        ),
      );
    }

    return result;
  }

  String _serializeAttributeValue({
    required SpeciesAttributeDefinition definition,
    required Object value,
  }) {
    Object normalized;

    switch (definition.valueType) {
      case 'text':
        if (value is! String || value.trim().isEmpty) {
          throw ArgumentError('"${definition.label}" harus berupa teks.');
        }
        normalized = value.trim();
      case 'integer':
        if (value is! int) {
          throw ArgumentError('"${definition.label}" harus berupa bilangan bulat.');
        }
        normalized = value;
      case 'decimal':
        if (value is! num || !value.isFinite) {
          throw ArgumentError('"${definition.label}" harus berupa angka.');
        }
        normalized = value;
      case 'measurement':
        if (value is! num || !value.isFinite || definition.unitCode == null) {
          throw ArgumentError(
            '"${definition.label}" harus berupa angka dengan satuan yang ditentukan.',
          );
        }
        normalized = value;
      case 'boolean':
        if (value is! bool) {
          throw ArgumentError('"${definition.label}" harus berupa ya/tidak.');
        }
        normalized = value;
      case 'date':
        if (value is! DateTime) {
          throw ArgumentError('"${definition.label}" harus berupa tanggal.');
        }
        normalized = value.toUtc().toIso8601String();
      case 'single_choice':
        final options = _readOptions(definition);
        if (value is! String || !options.contains(value)) {
          throw ArgumentError('Pilihan untuk "${definition.label}" tidak valid.');
        }
        normalized = value;
      case 'multiple_choice':
        final options = _readOptions(definition);
        if (value is! List ||
            value.any((item) => item is! String || !options.contains(item))) {
          throw ArgumentError('Pilihan untuk "${definition.label}" tidak valid.');
        }
        normalized = value.toSet().toList(growable: false);
      default:
        throw ArgumentError(
          'Tipe atribut "${definition.valueType}" belum didukung.',
        );
    }

    return jsonEncode({'value': normalized});
  }

  List<String> _readOptions(SpeciesAttributeDefinition definition) {
    final raw = definition.optionsJson;
    if (raw == null) return const [];

    final decoded = jsonDecode(raw);
    if (decoded is! List || decoded.any((item) => item is! String)) {
      throw FormatException(
        'Konfigurasi pilihan atribut "${definition.label}" tidak valid.',
      );
    }
    return decoded.cast<String>();
  }

  Future<void> _insertAttributeRows({
    required String workspaceId,
    required String animalProfileId,
    required List<_NormalizedAttributeValue> values,
    required DateTime now,
  }) async {
    for (final value in values) {
      await _database.into(_database.speciesAttributeValues).insert(
            SpeciesAttributeValuesCompanion.insert(
              id: _uuid.v4(),
              workspaceId: workspaceId,
              animalProfileId: animalProfileId,
              attributeDefinitionId: value.definition.id,
              valueJson: value.serializedValue,
              unitCode: Value(value.definition.unitCode),
              observedAt: const Value(null),
              valueSource: const Value('user'),
              createdAt: now,
              updatedAt: now,
            ),
          );
    }
  }

  void _validateGroupCount({
    required String memberTrackingMode,
    required int? reportedCount,
    required DateTime? countObservedAt,
  }) {
    if (!const {'tracked', 'estimated', 'not_tracked'}
        .contains(memberTrackingMode)) {
      throw ArgumentError.value(
        memberTrackingMode,
        'memberTrackingMode',
        'Mode pelacakan kelompok tidak valid.',
      );
    }
    if (reportedCount != null && reportedCount < 0) {
      throw ArgumentError.value(reportedCount, 'reportedCount');
    }
    if (memberTrackingMode == 'tracked' && reportedCount != null) {
      throw ArgumentError(
        'Kelompok tracked menggunakan jumlah anggota dari data keanggotaan.',
      );
    }
    if (memberTrackingMode == 'not_tracked' &&
        (reportedCount != null || countObservedAt != null)) {
      throw ArgumentError(
        'Jumlah dan tanggal pengamatan tidak boleh diisi pada mode tidak dicatat.',
      );
    }
    if (memberTrackingMode == 'estimated' &&
        reportedCount != null &&
        countObservedAt == null) {
      throw ArgumentError(
        'Tanggal pengamatan diperlukan untuk jumlah perkiraan.',
      );
    }
    if (reportedCount == null && countObservedAt != null) {
      throw ArgumentError(
        'Tanggal pengamatan tidak dapat diisi tanpa jumlah anggota.',
      );
    }
  }

  String? _validateBirthDate({
    required DateTime? birthDate,
    required String? precision,
  }) {
    if (birthDate == null) {
      if (precision == null || precision == 'unknown') return precision;
      throw ArgumentError(
        'Tanggal lahir diperlukan untuk presisi exact atau estimated.',
      );
    }
    if (!const {'exact', 'estimated'}.contains(precision)) {
      throw ArgumentError(
        'Pilih apakah tanggal lahir tepat atau perkiraan.',
      );
    }
    return precision;
  }

  String _validateName(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) {
      throw ArgumentError.value(value, 'displayName', 'Nama wajib diisi.');
    }
    if (normalized.length > 160) {
      throw ArgumentError.value(
        value,
        'displayName',
        'Nama maksimal 160 karakter.',
      );
    }
    return normalized;
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

class _NormalizedAttributeValue {
  const _NormalizedAttributeValue({
    required this.definition,
    required this.serializedValue,
  });

  final SpeciesAttributeDefinition definition;
  final String serializedValue;
}
