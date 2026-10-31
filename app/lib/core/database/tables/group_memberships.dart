import 'package:drift/drift.dart';
import 'animal_profiles.dart';
import 'workspaces.dart';

class GroupMemberships extends Table {
  TextColumn get id => text()();
  TextColumn get workspaceId => text().references(Workspaces, #id)();
  TextColumn get groupProfileId => text().references(AnimalProfiles, #id)();
  TextColumn get individualProfileId => text().references(AnimalProfiles, #id)();
  DateTimeColumn get validFrom => dateTime()();
  DateTimeColumn get validTo => dateTime().nullable()();
  TextColumn get membershipNote => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}
