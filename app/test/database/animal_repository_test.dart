import 'dart:convert';

import 'package:drift/drift.dart' show DatabaseConnection;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_universe/core/database/app_database.dart';
import 'package:pet_universe/core/workspace/workspace_mode.dart';
import 'package:pet_universe/features/animals/data/animal_repository.dart';
import 'package:pet_universe/features/species/data/species_repository.dart';
import 'package:pet_universe/features/workspaces/data/workspace_repository.dart';

void main() {
  late AppDatabase database;
  late WorkspaceRepository workspaces;
  late AnimalRepository animals;
  late SpeciesRepository species;

  setUp(() {
    database = AppDatabase.forTesting(
      DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      ),
    );
    workspaces = WorkspaceRepository(database);
    animals = AnimalRepository(database);
    species = SpeciesRepository(database);
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

  test('creates an individual profile, detail row, and outbox atomically',
      () async {
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

  test('saves species attributes and individual details in one transaction',
      () async {
    final workspaceId = await workspaces.ensureWorkspace(
      mode: WorkspaceMode.personal,
      name: 'Ruang Atribut',
    );
    final speciesId = await species.createCustomSpecies(
      workspaceId: workspaceId,
      commonName: 'Kucing domestik',
      scientificName: 'Felis catus',
      categoryKey: 'mammal',
    );
    final colorDefinitionId = await species.createAttributeDefinition(
      workspaceId: workspaceId,
      speciesId: speciesId,
      label: 'Warna bulu',
      valueType: 'single_choice',
      options: ['Hitam', 'Putih', 'Belang'],
      isRequired: true,
    );
    final lengthDefinitionId = await species.createAttributeDefinition(
      workspaceId: workspaceId,
      speciesId: speciesId,
      label: 'Panjang tubuh',
      valueType: 'measurement',
      unitCode: 'cm',
    );

    final profileId = await animals.createIndividual(
      workspaceId: workspaceId,
      displayName: 'Milo',
      speciesId: speciesId,
      sexCode: 'Jantan',
      birthDate: DateTime.utc(2023, 4, 12),
      birthDatePrecision: 'estimated',
      attributeValues: {
        colorDefinitionId: 'Belang',
        lengthDefinitionId: 42.5,
      },
    );

    final profile = await animals.getProfileById(profileId);
    final details = await (database.select(database.individualDetails)
          ..where((table) => table.animalProfileId.equals(profileId)))
        .getSingle();
    final values = await (database.select(database.speciesAttributeValues)
          ..where((table) => table.animalProfileId.equals(profileId)))
        .get();
    final outbox = await (database.select(database.syncOutbox)
          ..where((table) => table.entityId.equals(profileId)))
        .getSingle();

    expect(profile?.speciesId, speciesId);
    expect(details.sexCode, 'Jantan');
    expect(details.birthDatePrecision, 'estimated');
    expect(values, hasLength(2));

    final byDefinition = {
      for (final value in values) value.attributeDefinitionId: value,
    };
    expect(
      (jsonDecode(byDefinition[colorDefinitionId]!.valueJson)
          as Map<String, dynamic>)['value'],
      'Belang',
    );
    expect(
      (jsonDecode(byDefinition[lengthDefinitionId]!.valueJson)
          as Map<String, dynamic>)['value'],
      42.5,
    );
    expect(byDefinition[lengthDefinitionId]!.unitCode, 'cm');

    final payload = jsonDecode(outbox.payloadJson) as Map<String, dynamic>;
    expect(payload['speciesId'], speciesId);
    expect(payload['attributes'], hasLength(2));
    expect(outbox.status, 'pending');
  });

  test('rejects a missing required species attribute without partial records',
      () async {
    final workspaceId = await workspaces.ensureWorkspace(
      mode: WorkspaceMode.personal,
      name: 'Ruang Validasi Atribut',
    );
    final speciesId = await species.createCustomSpecies(
      workspaceId: workspaceId,
      commonName: 'Ikan uji',
      categoryKey: 'aquatic',
    );
    await species.createAttributeDefinition(
      workspaceId: workspaceId,
      speciesId: speciesId,
      label: 'Pola warna',
      valueType: 'text',
      isRequired: true,
    );

    await expectLater(
      animals.createIndividual(
        workspaceId: workspaceId,
        displayName: 'Ikan A',
        speciesId: speciesId,
      ),
      throwsArgumentError,
    );

    final profiles = await database.select(database.animalProfiles).get();
    final values = await database.select(database.speciesAttributeValues).get();
    final outbox = await database.select(database.syncOutbox).get();
    expect(profiles, isEmpty);
    expect(values, isEmpty);
    expect(outbox, isEmpty);
  });

  test('prevents a profile from using another workspace custom species',
      () async {
    final personalId = await workspaces.ensureWorkspace(
      mode: WorkspaceMode.personal,
      name: 'Ruang Personal',
    );
    final professionalId = await workspaces.ensureWorkspace(
      mode: WorkspaceMode.professional,
      name: 'Ruang Professional',
    );
    final speciesId = await species.createCustomSpecies(
      workspaceId: personalId,
      commonName: 'Spesies privat',
    );

    await expectLater(
      animals.createIndividual(
        workspaceId: professionalId,
        displayName: 'Profil silang',
        speciesId: speciesId,
      ),
      throwsArgumentError,
    );

    expect(
      await database.select(database.animalProfiles).get(),
      isEmpty,
    );
  });

  test('creates a group with a dated estimate rather than a verified count',
      () async {
    final workspaceId = await workspaces.ensureWorkspace(
      mode: WorkspaceMode.professional,
      name: 'Ruang Kelompok',
    );
    final observedAt = DateTime.utc(2026, 10, 31);

    final profileId = await animals.createGroup(
      workspaceId: workspaceId,
      displayName: 'Koloni guppy',
      groupPurpose: 'Pembesaran',
      memberTrackingMode: 'estimated',
      reportedCount: 24,
      countObservedAt: observedAt,
      countNote: 'Pengamatan saat pemindahan',
    );

    final group = await (database.select(database.groupDetails)
          ..where((table) => table.animalProfileId.equals(profileId)))
        .getSingle();

    expect(group.groupPurpose, 'Pembesaran');
    expect(group.memberTrackingMode, 'estimated');
    expect(group.reportedCount, 24);
    expect(group.countObservedAt?.isAtSameMomentAs(observedAt), isTrue);
    expect(group.countNote, 'Pengamatan saat pemindahan');
  });

  test('updates an individual profile without creating a new profile', () async {
    final workspaceId = await workspaces.ensureWorkspace(
      mode: WorkspaceMode.personal,
      name: 'Ruang Edit Individu',
    );
    final speciesId = await species.createCustomSpecies(
      workspaceId: workspaceId,
      commonName: 'Kucing domestik',
    );
    final colorDefinitionId = await species.createAttributeDefinition(
      workspaceId: workspaceId,
      speciesId: speciesId,
      label: 'Warna bulu',
      valueType: 'text',
    );

    final profileId = await animals.createIndividual(
      workspaceId: workspaceId,
      displayName: 'Milo',
      speciesId: speciesId,
      sexCode: 'Jantan',
      attributeValues: {colorDefinitionId: 'Putih'},
    );

    await animals.updateIndividual(
      workspaceId: workspaceId,
      profileId: profileId,
      displayName: 'Milo Putih',
      speciesId: speciesId,
      sexCode: 'Jantan',
      lifeStageCode: 'Dewasa',
      attributeValues: {colorDefinitionId: 'Krem'},
    );

    final profiles = await database.select(database.animalProfiles).get();
    final allValues = await (database.select(database.speciesAttributeValues)
          ..where((table) => table.animalProfileId.equals(profileId)))
        .get();
    final activeValues = allValues.where((value) => value.deletedAt == null);
    final outbox = await (database.select(database.syncOutbox)
          ..where((table) => table.entityId.equals(profileId))
          ..orderBy([(table) => OrderingTerm.asc(table.createdAt)]))
        .get();
    final detail = await animals.getProfileDetail(
      workspaceId: workspaceId,
      profileId: profileId,
    );

    expect(profiles, hasLength(1));
    expect(profiles.single.id, profileId);
    expect(profiles.single.displayName, 'Milo Putih');
    expect(allValues, hasLength(2));
    expect(activeValues, hasLength(1));
    expect(
      (jsonDecode(activeValues.single.valueJson)
          as Map<String, dynamic>)['value'],
      'Krem',
    );
    expect(outbox, hasLength(2));
    expect(
      outbox.map((operation) => operation.operationKind).toSet(),
      {'create', 'update'},
    );
    expect(detail?.profile.displayName, 'Milo Putih');
    expect(detail?.individualDetails?.lifeStageCode, 'Dewasa');
    expect(detail?.attributes, hasLength(1));
    expect(detail?.attributes.single.value, 'Krem');
  });

  test('updates group count and preserves estimated count meaning', () async {
    final workspaceId = await workspaces.ensureWorkspace(
      mode: WorkspaceMode.professional,
      name: 'Ruang Edit Kelompok',
    );
    final profileId = await animals.createGroup(
      workspaceId: workspaceId,
      displayName: 'Koloni awal',
    );

    final observedAt = DateTime(2026, 11, 1);
    await animals.updateGroup(
      workspaceId: workspaceId,
      profileId: profileId,
      displayName: 'Koloni guppy',
      groupPurpose: 'Pembesaran',
      memberTrackingMode: 'estimated',
      reportedCount: 32,
      countObservedAt: observedAt,
      countNote: 'Hasil pengamatan terbaru',
    );

    final profile = await animals.getProfileById(profileId);
    final group = await (database.select(database.groupDetails)
          ..where((table) => table.animalProfileId.equals(profileId)))
        .getSingle();
    final outbox = await (database.select(database.syncOutbox)
          ..where((table) => table.entityId.equals(profileId))
          ..orderBy([(table) => OrderingTerm.asc(table.createdAt)]))
        .get();

    expect(profile?.displayName, 'Koloni guppy');
    expect(group.memberTrackingMode, 'estimated');
    expect(group.reportedCount, 32);
    expect(group.countObservedAt?.isAtSameMomentAs(observedAt), isTrue);
    expect(outbox, hasLength(2));
    expect(
      outbox.map((operation) => operation.operationKind),
      contains('update'),
    );
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
