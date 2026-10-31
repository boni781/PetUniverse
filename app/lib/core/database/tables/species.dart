import 'package:drift/drift.dart';
import 'workspaces.dart';

class Species extends Table {
  TextColumn get id => text()();
  TextColumn get origin => text()();
  TextColumn get workspaceId => text().nullable().references(Workspaces, #id)();
  TextColumn get taxonomicRank => text()();
  TextColumn get scientificName => text().nullable()();
  TextColumn get commonName => text().withLength(min: 1, max: 160)();
  TextColumn get categoryKey => text()();
  TextColumn get parentTaxonId => text().nullable().references(Species, #id)();
  TextColumn get catalogStatus => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}
