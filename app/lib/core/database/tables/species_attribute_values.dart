import 'package:drift/drift.dart';

import 'animal_profiles.dart';
import 'species_attribute_definitions.dart';
import 'workspaces.dart';

class SpeciesAttributeValues extends Table {
  TextColumn get id => text()();

  TextColumn get workspaceId => text().references(Workspaces, #id)();

  TextColumn get animalProfileId =>
      text().references(AnimalProfiles, #id)();

  TextColumn get attributeDefinitionId =>
      text().references(SpeciesAttributeDefinitions, #id)();

  TextColumn get valueJson => text()();

  TextColumn get unitCode => text().nullable()();

  DateTimeColumn get observedAt => dateTime().nullable()();

  TextColumn get valueSource =>
      text().withDefault(const Constant('user'))();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
