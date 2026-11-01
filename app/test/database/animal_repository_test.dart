import 'package:drift/drift.dart' show DatabaseConnection;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_universe/core/database/app_database.dart';
import 'package:pet_universe/core/workspace/workspace_mode.dart';
import 'package:pet_universe/features/animals/data/animal_repository.dart';
import 'package:pet_universe/features/workspaces/data/workspace_repository.dart';

void main() {
  late AppDatabase database;
  late WorkspaceRepository workspaces;
  late AnimalRepository animals;

  setUp(() {
    database = AppDatabase.forTesting(DatabaseConnection(
    NativeDatabase.memory(),
    closeStreamsSynchronously: true,
  ));
    workspaces = WorkspaceRepository(database);
    animals = AnimalRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('creates the two default workspace scopes', () async {
    final ids = await workspaces.ensureDefaultWorkspaces();

    expect(ids[WorkspaceMode.personal], isNotNull);
    expect(ids[WorkspaceMode.professional], isNotNull);
    expect(ids[WorkspaceMode.personal], isNot(ids[WorkspaceMode.professional]));

    final records = await workspaces.getAllWorkspaces();
    expect(records, hasLength(2));
  });

  test('creates an individual profile, detail row, and outbox atomically', () async {
    final workspaceId = await workspaces.ensureWorkspace(
      mode: WorkspaceMode.personal,
      name: 'Ruang Tes',
    );

    final profileId = await animals.createIndividual(
      workspaceId: workspaceId,
      displayName: 'Milo',
    );

    final profile = await animals.getProfileById(profileId);
    final details = await (database.select(database.individualDetails)
          ..where((table) => table.animalProfileId.equals(profileId)))
        .get();
    final groups = await (database.select(database.groupDetails)
          ..where((table) => table.animalProfileId.equals(profileId)))
        .get();
    final outbox = await database.select(database.syncOutbox).get();

    expect(profile?.displayName, 'Milo');
    expect(profile?.recordKind, 'individual');
    expect(details, hasLength(1));
    expect(groups, isEmpty);
    expect(outbox, hasLength(1));
    expect(outbox.single.entityId, profileId);
    expect(outbox.single.status, 'pending');
  });

  test('creates a group profile without inventing a member count', () async {
    final workspaceId = await workspaces.ensureWorkspace(
      mode: WorkspaceMode.professional,
      name: 'Ruang Tes Profesional',
    );

    final profileId = await animals.createGroup(
      workspaceId: workspaceId,
      displayName: 'Koloni guppy',
    );

    final group = await (database.select(database.groupDetails)
          ..where((table) => table.animalProfileId.equals(profileId)))
        .getSingle();

    expect(group.memberTrackingMode, 'not_tracked');
    expect(group.reportedCount, isNull);
  });

  test('rejects an empty animal name before writing records', () async {
    final workspaceId = await workspaces.ensureWorkspace(
      mode: WorkspaceMode.personal,
      name: 'Ruang Validasi',
    );

    await expectLater(
      animals.createIndividual(
        workspaceId: workspaceId,
        displayName: '   ',
      ),
      throwsArgumentError,
    );

    final profiles = await database.select(database.animalProfiles).get();
    final outbox = await database.select(database.syncOutbox).get();
    expect(profiles, isEmpty);
    expect(outbox, isEmpty);
  });
}
