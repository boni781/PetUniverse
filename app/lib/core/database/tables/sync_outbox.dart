import 'package:drift/drift.dart';
import 'workspaces.dart';

class SyncOutbox extends Table {
  TextColumn get operationId => text()();
  TextColumn get workspaceId => text().references(Workspaces, #id)();
  TextColumn get entityKind => text()();
  TextColumn get entityId => text()();
  TextColumn get operationKind => text()();
  IntColumn get baseServerVersion => integer().nullable()();
  IntColumn get payloadVersion => integer().withDefault(const Constant(1))();
  TextColumn get payloadJson => text()();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get attemptCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get nextAttemptAt => dateTime().nullable()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  TextColumn get lastErrorCode => text().nullable()();
  @override
  Set<Column> get primaryKey => {operationId};
}
