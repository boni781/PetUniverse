import 'package:drift/drift.dart';
import 'animal_profiles.dart';
import 'habitats.dart';
import 'workspaces.dart';

class AnimalHabitatAssignments extends Table {
  TextColumn get id => text()();
  TextColumn get workspaceId => text().references(Workspaces, #id)();
  TextColumn get animalProfileId => text().references(AnimalProfiles, #id)();
  TextColumn get habitatId => text().references(Habitats, #id)();
  TextColumn get assignmentRole => text().withDefault(const Constant('primary'))();
  DateTimeColumn get validFrom => dateTime()();
  DateTimeColumn get validTo => dateTime().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  @override
  Set<Column<Object>> get primaryKey => {id};
}
