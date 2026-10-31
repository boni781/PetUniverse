import 'package:drift/drift.dart';
import 'species.dart';

class SpeciesAttributeDefinitions extends Table {
  TextColumn get id => text()();
  TextColumn get speciesId => text().references(Species, #id)();
  TextColumn get key => text()();
  TextColumn get label => text()();
  TextColumn get category => text()();
  TextColumn get valueType => text()();
  TextColumn get appliesTo => text()();
  TextColumn get unitCode => text().nullable()();
  TextColumn get optionsJson => text().nullable()();
  TextColumn get validationRulesJson => text().nullable()();
  BoolColumn get isRequired => boolean().withDefault(const Constant(false))();
  IntColumn get definitionVersion => integer().withDefault(const Constant(1))();
  IntColumn get displayOrder => integer().withDefault(const Constant(0))();
  TextColumn get status => text().withDefault(const Constant('draft'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  @override
  Set<Column<Object>> get primaryKey => {id};
}
