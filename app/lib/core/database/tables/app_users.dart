import 'package:drift/drift.dart';

class AppUsers extends Table {
  TextColumn get id => text()();
  TextColumn get displayName => text().withLength(min: 1, max: 120)();
  TextColumn get email => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}
