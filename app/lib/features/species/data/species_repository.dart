import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';

class SpeciesRepository {
  SpeciesRepository(this._database);

  final AppDatabase _database;
  static const Uuid _uuid = Uuid();

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

  Future<String> createCustomSpecies({
    required String workspaceId,
    required String commonName,
    String? scientificName,
    String taxonomicRank = 'unknown',
    String categoryKey = 'other',
  }) async {
    final name = commonName.trim();
    if (name.isEmpty) {
      throw ArgumentError.value(commonName, 'commonName', 'Nama spesies wajib diisi.');
    }

    final id = _uuid.v4();
    final now = DateTime.now().toUtc();

    await _database.into(_database.species).insert(
          SpeciesCompanion.insert(
            id: id,
            origin: 'custom',
            workspaceId: Value(workspaceId),
            taxonomicRank: taxonomicRank,
            scientificName: Value(_normalize(scientificName)),
            commonName: name,
            categoryKey: categoryKey,
            catalogStatus: 'draft',
            createdAt: now,
            updatedAt: now,
          ),
        );

    return id;
  }

  String? _normalize(String? value) {
    final normalized = value?.trim();
    return normalized == null || normalized.isEmpty ? null : normalized;
  }
}
