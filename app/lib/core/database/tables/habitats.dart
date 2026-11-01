import 'package:drift/drift.dart';
import 'workspaces.dart';

class Habitats extends Table {
  TextColumn get id => text()();
  TextColumn get workspaceId => text().references(Workspaces, #id)();
  TextColumn get parentHabitatId => text().nullable().references(Habitats, #id)();
  TextColumn get name => text().withLength(min: 1, max: 160)();
  TextColumn get habitatType => text()();
  TextColumn get status => text().withDefault(const Constant('active'))();
  TextColumn get description => text().nullable()();
  RealColumn get capacityValue => real().nullable()();
  TextColumn get capacityUnit => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  @override
  Set<Column<Object>> get primaryKey => {id};
}
