import 'package:drift/drift.dart';

import 'species.dart';

class SpeciesSources extends Table {
  TextColumn get id => text()();

  TextColumn get speciesId => text().references(Species, #id)();

  TextColumn get sourceName => text()();

  TextColumn get sourceUrl => text().nullable()();

  TextColumn get publisher => text().nullable()();

  DateTimeColumn get accessedAt => dateTime().nullable()();

  TextColumn get licenseOrUsageNote => text().nullable()();

  TextColumn get validationStatus =>
      text().withDefault(const Constant('unreviewed'))();

  TextColumn get reviewedBy => text().nullable()();

  DateTimeColumn get reviewedAt => dateTime().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
