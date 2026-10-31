import 'package:drift/drift.dart';
import 'app_users.dart';
import 'workspaces.dart';

class WorkspaceMemberships extends Table {
  TextColumn get id => text()();
  TextColumn get workspaceId => text().references(Workspaces, #id)();
  TextColumn get userId => text().references(AppUsers, #id)();
  TextColumn get role => text()();
  TextColumn get membershipStatus => text()();
  DateTimeColumn get joinedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}
