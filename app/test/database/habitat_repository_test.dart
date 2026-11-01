import 'dart:convert';

import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_universe/core/database/app_database.dart';
import 'package:pet_universe/core/workspace/workspace_mode.dart';
import 'package:pet_universe/features/animals/data/animal_repository.dart';
import 'package:pet_universe/features/habitats/data/habitat_repository.dart';
import 'package:pet_universe/features/workspaces/data/workspace_repository.dart';

void main() {
  late AppDatabase database;
  late WorkspaceRepository workspaces;
  late AnimalRepository animals;
  late HabitatRepository habitats;

  setUp(() {
    database = AppDatabase.forTesting(
      DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      ),
    );
    workspaces = WorkspaceRepository(database);
    animals = AnimalRepository(database);
    habitats = HabitatRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('creates a workspace habitat and queues its local change', () async {
    final workspaceId = await workspaces.ensureWorkspace(
      mode: WorkspaceMode.personal,
      name: 'Ruang Habitat',
    );

    final habitatId = await habitats.createHabitat(
      workspaceId: workspaceId,
      name: 'Akuarium utama',
      habitatType: 'aquarium',
      description: 'Area pemeliharaan ikan hias',
      capacityValue: 120,
      capacityUnit: 'liter',
    );

    final habitat = await habitats.getHabitat(
      workspaceId: workspaceId,
      habitatId: habitatId,
    );
    final outbox = await (database.select(database.syncOutbox)
          ..where(
            (table) =>
                table.entityKind.equals('habitat') &
                table.entityId.equals(habitatId),
          ))
        .getSingle();
    final payload = jsonDecode(outbox.payloadJson) as Map<String, dynamic>;

    expect(habitat?.name, 'Akuarium utama');
    expect(habitat?.habitatType, 'aquarium');
    expect(habitat?.capacityValue, 120);
    expect(habitat?.capacityUnit, 'liter');
    expect(outbox.operationKind, 'create');
    expect(outbox.status, 'pending');
    expect(payload['name'], 'Akuarium utama');
    expect(payload['capacityUnit'], 'liter');
  });

  test('rejects invalid capacity and does not leave a partial habitat', () async {
    final workspaceId = await workspaces.ensureWorkspace(
      mode: WorkspaceMode.personal,
      name: 'Ruang Kapasitas',
    );

    await expectLater(
      habitats.createHabitat(
        workspaceId: workspaceId,
        name: 'Kandang A',
        habitatType: 'cage',
        capacityValue: 0,
        capacityUnit: 'ekor',
      ),
      throwsArgumentError,
    );

    await expectLater(
      habitats.createHabitat(
        workspaceId: workspaceId,
        name: 'Kandang B',
        habitatType: 'cage',
        capacityValue: 10,
      ),
      throwsArgumentError,
    );

    expect(await database.select(database.habitats).get(), isEmpty);
    expect(await database.select(database.syncOutbox).get(), isEmpty);
  });

  test('prevents habitat hierarchy cycles', () async {
    final workspaceId = await workspaces.ensureWorkspace(
      mode: WorkspaceMode.professional,
      name: 'Ruang Bertingkat',
    );

    final facilityId = await habitats.createHabitat(
      workspaceId: workspaceId,
      name: 'Fasilitas utama',
      habitatType: 'enclosure',
    );
    final roomId = await habitats.createHabitat(
      workspaceId: workspaceId,
      name: 'Ruangan A',
      habitatType: 'enclosure',
      parentHabitatId: facilityId,
    );

    await expectLater(
      habitats.updateHabitat(
        workspaceId: workspaceId,
        habitatId: facilityId,
        name: 'Fasilitas utama',
        habitatType: 'enclosure',
        parentHabitatId: roomId,
      ),
      throwsArgumentError,
    );

    final facility = await habitats.getHabitat(
      workspaceId: workspaceId,
      habitatId: facilityId,
    );
    expect(facility?.parentHabitatId, isNull);
  });

  test('moving a profile closes the previous primary assignment', () async {
    final workspaceId = await workspaces.ensureWorkspace(
      mode: WorkspaceMode.professional,
      name: 'Ruang Perpindahan',
    );
    final profileId = await animals.createIndividual(
      workspaceId: workspaceId,
      displayName: 'Milo',
    );
    final firstHabitatId = await habitats.createHabitat(
      workspaceId: workspaceId,
      name: 'Kandang awal',
      habitatType: 'cage',
    );
    final secondHabitatId = await habitats.createHabitat(
      workspaceId: workspaceId,
      name: 'Kandang baru',
      habitatType: 'cage',
    );

    final firstStart = DateTime.utc(2026, 1, 2, 8);
    final secondStart = DateTime.utc(2026, 2, 3, 9);

    final firstAssignmentId = await habitats.assignProfile(
      workspaceId: workspaceId,
      profileId: profileId,
      habitatId: firstHabitatId,
      validFrom: firstStart,
      note: 'Penempatan awal',
    );
    final secondAssignmentId = await habitats.assignProfile(
      workspaceId: workspaceId,
      profileId: profileId,
      habitatId: secondHabitatId,
      validFrom: secondStart,
      note: 'Dipindahkan',
    );

    final assignments = await habitats.getAssignmentsForProfile(
      workspaceId: workspaceId,
      profileId: profileId,
    );
    final first = assignments.singleWhere(
      (entry) => entry.assignment.id == firstAssignmentId,
    );
    final second = assignments.singleWhere(
      (entry) => entry.assignment.id == secondAssignmentId,
    );

    expect(assignments, hasLength(2));
    expect(
      first.assignment.validTo?.isAtSameMomentAs(secondStart),
      isTrue,
    );
    expect(second.assignment.validTo, isNull);
    expect(first.habitat?.name, 'Kandang awal');
    expect(second.habitat?.name, 'Kandang baru');

    final assignmentOutbox = await (database.select(database.syncOutbox)
          ..where(
            (table) =>
                table.entityKind.equals('animal_habitat_assignment'),
          ))
        .get();
    expect(assignmentOutbox, hasLength(3));
    expect(
      assignmentOutbox.map((item) => item.operationKind).toSet(),
      {'create', 'update'},
    );
  });

  test('does not duplicate an active placement or its outbox operation', () async {
    final workspaceId = await workspaces.ensureWorkspace(
      mode: WorkspaceMode.personal,
      name: 'Ruang Duplikasi',
    );
    final profileId = await animals.createIndividual(
      workspaceId: workspaceId,
      displayName: 'Luna',
    );
    final habitatId = await habitats.createHabitat(
      workspaceId: workspaceId,
      name: 'Aviary',
      habitatType: 'aviary',
    );

    final firstId = await habitats.assignProfile(
      workspaceId: workspaceId,
      profileId: profileId,
      habitatId: habitatId,
      validFrom: DateTime.utc(2026, 3, 1),
    );
    final repeatedId = await habitats.assignProfile(
      workspaceId: workspaceId,
      profileId: profileId,
      habitatId: habitatId,
      validFrom: DateTime.utc(2026, 3, 5),
    );

    final assignments = await database.select(
      database.animalHabitatAssignments,
    ).get();
    final outbox = await (database.select(database.syncOutbox)
          ..where(
            (table) =>
                table.entityKind.equals('animal_habitat_assignment'),
          ))
        .get();

    expect(repeatedId, firstId);
    expect(assignments, hasLength(1));
    expect(outbox, hasLength(1));
  });

  test('prevents assigning a profile from another workspace', () async {
    final personalId = await workspaces.ensureWorkspace(
      mode: WorkspaceMode.personal,
      name: 'Ruang Personal',
    );
    final professionalId = await workspaces.ensureWorkspace(
      mode: WorkspaceMode.professional,
      name: 'Ruang Professional',
    );
    final profileId = await animals.createIndividual(
      workspaceId: professionalId,
      displayName: 'Profil profesional',
    );
    final habitatId = await habitats.createHabitat(
      workspaceId: personalId,
      name: 'Habitat privat',
      habitatType: 'enclosure',
    );

    await expectLater(
      habitats.assignProfile(
        workspaceId: personalId,
        profileId: profileId,
        habitatId: habitatId,
        validFrom: DateTime.utc(2026, 4, 1),
      ),
      throwsStateError,
    );

    expect(
      await database.select(database.animalHabitatAssignments).get(),
      isEmpty,
    );
  });

  test('an assigned habitat cannot be archived until its placement is closed',
      () async {
    final workspaceId = await workspaces.ensureWorkspace(
      mode: WorkspaceMode.professional,
      name: 'Ruang Arsip',
    );
    final profileId = await animals.createIndividual(
      workspaceId: workspaceId,
      displayName: 'Kiko',
    );
    final habitatId = await habitats.createHabitat(
      workspaceId: workspaceId,
      name: 'Kandang aktif',
      habitatType: 'cage',
    );
    final assignmentId = await habitats.assignProfile(
      workspaceId: workspaceId,
      profileId: profileId,
      habitatId: habitatId,
      validFrom: DateTime.utc(2026, 5, 1),
    );

    await expectLater(
      habitats.archiveHabitat(
        workspaceId: workspaceId,
        habitatId: habitatId,
      ),
      throwsStateError,
    );

    await habitats.closeAssignment(
      workspaceId: workspaceId,
      assignmentId: assignmentId,
      validTo: DateTime.utc(2026, 5, 2),
    );
    await habitats.archiveHabitat(
      workspaceId: workspaceId,
      habitatId: habitatId,
    );

    final archived = await habitats.getHabitat(
      workspaceId: workspaceId,
      habitatId: habitatId,
    );
    final history = await habitats.getAssignmentsForHabitat(
      workspaceId: workspaceId,
      habitatId: habitatId,
    );

    expect(archived?.status, 'archived');
    expect(history, hasLength(1));
    expect(history.single.assignment.validTo, isNotNull);
  });
}
