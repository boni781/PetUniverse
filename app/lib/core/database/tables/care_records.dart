import 'package:drift/drift.dart';

import 'animal_profiles.dart';
import 'care_schedules.dart';
import 'workspaces.dart';

class CareRecords extends Table {
  TextColumn get id => text()();

  TextColumn get workspaceId => text().references(Workspaces, #id)();

  TextColumn get animalProfileId =>
      text().references(AnimalProfiles, #id)();

  TextColumn get scheduleId =>
      text().nullable().references(CareSchedules, #id)();

  TextColumn get careType => text()();

  TextColumn get title => text().withLength(min: 1, max: 160)();

  DateTimeColumn get performedAt => dateTime()();

  DateTimeColumn get scheduledFor => dateTime().nullable()();

  RealColumn get quantityValue => real().nullable()();

  TextColumn get quantityUnit => text().nullable()();

  TextColumn get notes => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
