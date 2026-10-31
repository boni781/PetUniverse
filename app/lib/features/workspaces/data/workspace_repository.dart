import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/tables/app_users.dart';
import '../../../core/database/tables/workspaces.dart';
import '../../../core/workspace/workspace_mode.dart';

class WorkspaceRepository {
  WorkspaceRepository(this._database);

  final AppDatabase _database;
  static const Uuid _uuid = Uuid();

  Future<Map<WorkspaceMode, String>> ensureDefaultWorkspaces() async {
    final personalId = await ensureWorkspace(
      mode: WorkspaceMode.personal,
      name: 'Ruang Personal',
    );
    final professionalId = await ensureWorkspace(
      mode: WorkspaceMode.professional,
      name: 'Ruang Professional',
    );

    return {
      WorkspaceMode.personal: personalId,
      WorkspaceMode.professional: professionalId,
    };
  }

  Future<String> ensureWorkspace({
    required WorkspaceMode mode,
    required String name,
  }) async {
    final existing = await (_database.select(_database.workspaces)
          ..where(
            (table) =>
                table.workspaceType.equals(mode.name) &
                table.deletedAt.isNull(),
          ))
        .getSingleOrNull();

    if (existing != null) return existing.id;

    final workspaceId = _uuid.v4();
    final generatedUserId = _uuid.v4();
    final now = DateTime.now().toUtc();

    await _database.transaction(() async {
      final localOwner = await (_database.select(_database.appUsers)
            ..limit(1))
          .getSingleOrNull();
      final userId = localOwner?.id ?? generatedUserId;

      if (localOwner == null) {
        await _database.into(_database.appUsers).insert(
              AppUsersCompanion.insert(
                id: userId,
                displayName: 'Pemilik Perangkat',
                createdAt: now,
                updatedAt: now,
              ),
            );
      }

      await _database.into(_database.workspaces).insert(
            WorkspacesCompanion.insert(
              id: workspaceId,
              workspaceType: mode.name,
              name: name.trim(),
              createdByUserId: userId,
              createdAt: now,
              updatedAt: now,
            ),
          );

      await _database.into(_database.workspaceMemberships).insert(
            WorkspaceMembershipsCompanion.insert(
              id: _uuid.v4(),
              workspaceId: workspaceId,
              userId: userId,
              role: 'owner',
              membershipStatus: 'active',
              joinedAt: Value(now),
              createdAt: now,
              updatedAt: now,
            ),
          );
    });

    return workspaceId;
  }

  Future<List<Workspace>> getAllWorkspaces() {
    return (_database.select(_database.workspaces)
          ..where((table) => table.deletedAt.isNull())
          ..orderBy([(table) => OrderingTerm.asc(table.createdAt)]))
        .get();
  }
}
