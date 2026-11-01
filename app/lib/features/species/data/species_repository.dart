import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';

class SpeciesRepository {
  SpeciesRepository(this._database);

  final AppDatabase _database;
  static const Uuid _uuid = Uuid();

  static const supportedCategories = <String>{
    'mammal',
    'bird',
    'aquatic',
    'reptile',
    'amphibian',
    'invertebrate',
    'livestock',
    'other',
  };

  static const supportedAttributeTypes = <String>{
    'text',
    'integer',
    'decimal',
    'boolean',
    'date',
    'single_choice',
    'multiple_choice',
    'measurement',
  };

  Stream<List<SpeciesData>> watchAvailableSpecies(String workspaceId) {
    return (_database.select(_database.species)
          ..where(
            (table) =>
                table.deletedAt.isNull() &
                (table.origin.equals('catalog') |
                    table.workspaceId.equals(workspaceId)),
          )
          ..orderBy([(table) => OrderingTerm.asc(table.commonName)]))
        .watch();
  }

  Stream<List<SpeciesAttributeDefinition>> watchAttributeDefinitions(
    String speciesId,
  ) {
    return (_database.select(_database.speciesAttributeDefinitions)
          ..where((table) => table.speciesId.equals(speciesId))
          ..orderBy([
            (table) => OrderingTerm.asc(table.displayOrder),
            (table) => OrderingTerm.asc(table.label),
          ]))
        .watch();
  }

  Future<String> createCustomSpecies({
    required String workspaceId,
    required String commonName,
    String? scientificName,
    String categoryKey = 'other',
  }) async {
    final name = commonName.trim();
    final scientific = _normalize(scientificName);

    if (name.isEmpty) {
      throw ArgumentError.value(
        commonName,
        'commonName',
        'Nama spesies wajib diisi.',
      );
    }
    if (name.length > 160) {
      throw ArgumentError.value(commonName, 'commonName', 'Maksimal 160 karakter.');
    }
    if (!supportedCategories.contains(categoryKey)) {
      throw ArgumentError.value(
        categoryKey,
        'categoryKey',
        'Kategori spesies tidak didukung.',
      );
    }

    final existing = await (_database.select(_database.species)
          ..where(
            (table) =>
                table.origin.equals('custom') &
                table.workspaceId.equals(workspaceId) &
                table.deletedAt.isNull(),
          ))
        .get();
    if (existing.any(
      (item) => item.commonName.toLowerCase() == name.toLowerCase(),
    )) {
      throw ArgumentError('Spesies dengan nama tersebut sudah tersedia.');
    }

    final id = _uuid.v4();
    final now = DateTime.now().toUtc();

    await _database.into(_database.species).insert(
          SpeciesCompanion.insert(
            id: id,
            origin: 'custom',
            workspaceId: Value(workspaceId),
            taxonomicRank: 'species',
            scientificName: Value(scientific),
            commonName: name,
            categoryKey: categoryKey,
            catalogStatus: 'draft',
            createdAt: now,
            updatedAt: now,
          ),
        );

    return id;
  }

  Future<String> createAttributeDefinition({
    required String workspaceId,
    required String speciesId,
    required String label,
    required String valueType,
    String appliesTo = 'both',
    String category = 'general',
    String? unitCode,
    List<String> options = const [],
    bool isRequired = false,
  }) async {
    final normalizedLabel = label.trim();
    final normalizedUnit = _normalize(unitCode);
    final normalizedOptions = options
        .map((option) => option.trim())
        .where((option) => option.isNotEmpty)
        .toSet()
        .toList(growable: false);

    if (normalizedLabel.isEmpty || normalizedLabel.length > 120) {
      throw ArgumentError.value(
        label,
        'label',
        'Label atribut wajib diisi dan maksimal 120 karakter.',
      );
    }
    if (!supportedAttributeTypes.contains(valueType)) {
      throw ArgumentError.value(
        valueType,
        'valueType',
        'Tipe atribut tidak didukung.',
      );
    }
    if (!const {'individual', 'group', 'both'}.contains(appliesTo)) {
      throw ArgumentError.value(
        appliesTo,
        'appliesTo',
        'Penerapan atribut tidak valid.',
      );
    }
    if (valueType == 'measurement' && normalizedUnit == null) {
      throw ArgumentError('Satuan wajib diisi untuk atribut pengukuran.');
    }
    if ((valueType == 'single_choice' || valueType == 'multiple_choice') &&
        normalizedOptions.isEmpty) {
      throw ArgumentError('Pilihan wajib diisi untuk atribut bertipe pilihan.');
    }
    if (normalizedOptions.any((option) => option.length > 100)) {
      throw ArgumentError('Setiap pilihan maksimal 100 karakter.');
    }

    final species = await (_database.select(_database.species)
          ..where(
            (table) =>
                table.id.equals(speciesId) &
                table.origin.equals('custom') &
                table.workspaceId.equals(workspaceId) &
                table.deletedAt.isNull(),
          ))
        .getSingleOrNull();
    if (species == null) {
      throw ArgumentError(
        'Atribut khusus hanya dapat dibuat untuk spesies khusus milik workspace ini.',
      );
    }

    final key = _makeKey(normalizedLabel);
    if (key.isEmpty) {
      throw ArgumentError('Label atribut perlu mengandung huruf atau angka.');
    }

    final existingDefinitions =
        await (_database.select(_database.speciesAttributeDefinitions)
              ..where((table) => table.speciesId.equals(speciesId)))
            .get();
    if (existingDefinitions.any((item) => item.key == key)) {
      throw ArgumentError(
        'Atribut dengan label serupa sudah tersedia untuk spesies ini.',
      );
    }

    final id = _uuid.v4();
    final now = DateTime.now().toUtc();

    await _database.into(_database.speciesAttributeDefinitions).insert(
          SpeciesAttributeDefinitionsCompanion.insert(
            id: id,
            speciesId: speciesId,
            key: key,
            label: normalizedLabel,
            category: _normalize(category) ?? 'general',
            valueType: valueType,
            appliesTo: appliesTo,
            unitCode: Value(normalizedUnit),
            optionsJson: Value(
              normalizedOptions.isEmpty ? null : jsonEncode(normalizedOptions),
            ),
            isRequired: Value(isRequired),
            displayOrder: Value(existingDefinitions.length),
            status: const Value('draft'),
            createdAt: now,
            updatedAt: now,
          ),
        );

    return id;
  }

  String _makeKey(String value) {
    return value
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'^_+|_+$'), '');
  }

  String? _normalize(String? value) {
    final normalized = value?.trim();
    return normalized == null || normalized.isEmpty ? null : normalized;
  }
}
