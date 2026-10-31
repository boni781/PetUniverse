import 'package:drift/drift.dart';
import 'app_users.dart';

class Workspaces extends Table {
  TextColumn get id => text()();
  TextColumn get workspaceType => text()();
  TextColumn get name => text().withLength(min: 1, max: 120)();
  TextColumn get createdByUserId => text().references(AppUsers, #id)();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}
