import 'package:drift/drift.dart';
import 'species.dart';
import 'workspaces.dart';

class AnimalProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get workspaceId => text().references(Workspaces, #id)();
  TextColumn get recordKind => text()();
  TextColumn get displayName => text().withLength(min: 1, max: 160)();
  TextColumn get speciesId => text().nullable().references(Species, #id)();
  TextColumn get profileStatus => text().withDefault(const Constant('active'))();
  TextColumn get notes => text().nullable()();
  TextColumn get identificationType => text().nullable()();
  TextColumn get identificationValue => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  @override
  Set<Column<Object>> get primaryKey => {id};
}
