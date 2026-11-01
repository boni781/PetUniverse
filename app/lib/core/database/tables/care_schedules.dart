import 'package:drift/drift.dart';

import 'animal_profiles.dart';
import 'workspaces.dart';

class CareSchedules extends Table {
  TextColumn get id => text()();

  TextColumn get workspaceId => text().references(Workspaces, #id)();

  TextColumn get animalProfileId =>
      text().references(AnimalProfiles, #id)();

  TextColumn get title => text().withLength(min: 1, max: 160)();

  TextColumn get careType => text()();

  TextColumn get instructions => text().nullable()();

  TextColumn get recurrenceType =>
      text().withDefault(const Constant('once'))();

  IntColumn get intervalDays => integer().nullable()();

  DateTimeColumn get scheduledAt => dateTime()();

  DateTimeColumn get nextDueAt => dateTime()();

  BoolColumn get isActive =>
      boolean().withDefault(const Constant(true))();

  DateTimeColumn get lastCompletedAt => dateTime().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  DateTimeColumn get archivedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
