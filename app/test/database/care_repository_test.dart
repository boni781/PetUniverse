import 'package:drift/drift.dart' show DatabaseConnection;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_universe/core/database/app_database.dart';
import 'package:pet_universe/core/workspace/workspace_mode.dart';
import 'package:pet_universe/features/animals/data/animal_repository.dart';
import 'package:pet_universe/features/care/data/care_repository.dart';
import 'package:pet_universe/features/workspaces/data/workspace_repository.dart';

void main() {
  late AppDatabase database;
  late WorkspaceRepository workspaces;
  late AnimalRepository animals;
  late CareRepository care;

  setUp(() {
    database = AppDatabase.forTesting(
      DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      ),
    );
    workspaces = WorkspaceRepository(database);
    animals = AnimalRepository(database);
    care = CareRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  Future<(String, String)> createWorkspaceAndProfile({
    String name = 'Milo',
    WorkspaceMode mode = WorkspaceMode.personal,
  }) async {
    final workspaceId = await workspaces.ensureWorkspace(
      mode: mode,
      name: 'Ruang Care',
    );
    final profileId = await animals.createIndividual(
      workspaceId: workspaceId,
      displayName: name,
    );
    return (workspaceId, profileId);
  }

  test('creates a recurring care schedule and queues its local change',
      () async {
    final (workspaceId, profileId) = await createWorkspaceAndProfile();
    final start = DateTime.utc(2026, 11, 1, 8);

    final scheduleId = await care.createSchedule(
      workspaceId: workspaceId,
      animalProfileId: profileId,
      title: 'Pakan pagi',
      careType: 'feeding',
      recurrenceType: 'interval',
      intervalDays: 2,
      scheduledAt: start,
      instructions: 'Porsi sesuai catatan harian',
    );

    final schedule = await (database.select(database.careSchedules)
          ..where((table) => table.id.equals(scheduleId)))
        .getSingle();
    final outbox = await (database.select(database.syncOutbox)
          ..where(
            (table) =>
                table.entityKind.equals('care_schedule') &
                table.entityId.equals(scheduleId),
          ))
        .getSingle();

    expect(schedule.animalProfileId, profileId);
    expect(schedule.careType, 'feeding');
    expect(schedule.recurrenceType, 'interval');
    expect(schedule.intervalDays, 2);
    expect(schedule.nextDueAt.isAtSameMomentAs(start), isTrue);
    expect(schedule.isActive, isTrue);
    expect(outbox.operationKind, 'create');
    expect(outbox.status, 'pending');
  });

  test('rejects invalid interval and profile from another workspace',
      () async {
    final (workspaceId, _) = await createWorkspaceAndProfile(name: 'Luna');
    final otherWorkspaceId = await workspaces.ensureWorkspace(
      mode: WorkspaceMode.professional,
      name: 'Ruang lain',
    );
    final otherProfileId = await animals.createIndividual(
      workspaceId: otherWorkspaceId,
      displayName: 'Kiko',
    );

    await expectLater(
      care.createSchedule(
        workspaceId: workspaceId,
        animalProfileId: otherProfileId,
        title: 'Jadwal silang',
        careType: 'feeding',
        recurrenceType: 'daily',
        scheduledAt: DateTime.utc(2026, 11, 1),
      ),
      throwsStateError,
    );

    await expectLater(
      care.createSchedule(
        workspaceId: workspaceId,
        animalProfileId: (await animals.watchProfiles(workspaceId).first)
            .single
            .id,
        title: 'Interval tanpa angka',
        careType: 'cleaning',
        recurrenceType: 'interval',
        scheduledAt: DateTime.utc(2026, 11, 1),
      ),
      throwsArgumentError,
    );

    expect(await database.select(database.careSchedules).get(), isEmpty);
    expect(
      await (database.select(database.syncOutbox)
            ..where((table) => table.entityKind.equals('care_schedule')))
          .get(),
      isEmpty,
    );
  });

  test('completing a recurring schedule creates a record and advances due date',
      () async {
    final (workspaceId, profileId) = await createWorkspaceAndProfile();
    final start = DateTime.utc(2026, 11, 1, 8);
    final performedAt = DateTime.utc(2026, 11, 1, 9, 30);

    final scheduleId = await care.createSchedule(
      workspaceId: workspaceId,
      animalProfileId: profileId,
      title: 'Pemberian pakan',
      careType: 'feeding',
      recurrenceType: 'daily',
      scheduledAt: start,
    );

    final recordId = await care.completeSchedule(
      workspaceId: workspaceId,
      scheduleId: scheduleId,
      performedAt: performedAt,
      quantityValue: 25,
      quantityUnit: 'gram',
      notes: 'Pakan habis',
    );

    final schedule = await (database.select(database.careSchedules)
          ..where((table) => table.id.equals(scheduleId)))
        .getSingle();
    final record = await (database.select(database.careRecords)
          ..where((table) => table.id.equals(recordId)))
        .getSingle();

    expect(schedule.isActive, isTrue);
    expect(
      schedule.nextDueAt.isAtSameMomentAs(DateTime.utc(2026, 11, 2, 8)),
      isTrue,
    );
    expect(schedule.lastCompletedAt?.isAtSameMomentAs(performedAt), isTrue);
    expect(record.scheduleId, scheduleId);
    expect(record.scheduledFor?.isAtSameMomentAs(start), isTrue);
    expect(record.quantityValue, 25);
    expect(record.quantityUnit, 'gram');
    expect(record.notes, 'Pakan habis');

    final outbox = await (database.select(database.syncOutbox)
          ..where((table) => table.entityId.equals(scheduleId)))
        .get();
    expect(outbox, hasLength(2));
    expect(outbox.map((item) => item.operationKind).toSet(), {'create', 'update'});
  });

  test('completing a one-time schedule deactivates it and keeps the record',
      () async {
    final (workspaceId, profileId) = await createWorkspaceAndProfile();
    final start = DateTime.utc(2026, 11, 1, 7);

    final scheduleId = await care.createSchedule(
      workspaceId: workspaceId,
      animalProfileId: profileId,
      title: 'Pemeriksaan awal',
      careType: 'health_check',
      recurrenceType: 'once',
      scheduledAt: start,
    );
    await care.completeSchedule(
      workspaceId: workspaceId,
      scheduleId: scheduleId,
      performedAt: DateTime.utc(2026, 11, 1, 8),
    );

    final schedule = await (database.select(database.careSchedules)
          ..where((table) => table.id.equals(scheduleId)))
        .getSingle();
    final records = await (database.select(database.careRecords)
          ..where((table) => table.scheduleId.equals(scheduleId)))
        .get();

    expect(schedule.isActive, isFalse);
    expect(schedule.lastCompletedAt, isNotNull);
    expect(records, hasLength(1));
    expect(records.single.title, 'Pemeriksaan awal');
  });

  test('manual activity validates quantity and records feeding details',
      () async {
    final (workspaceId, profileId) = await createWorkspaceAndProfile();

    await expectLater(
      care.recordCare(
        workspaceId: workspaceId,
        animalProfileId: profileId,
        title: 'Pakan',
        careType: 'feeding',
        quantityValue: 0,
        quantityUnit: 'gram',
      ),
      throwsArgumentError,
    );

    await expectLater(
      care.recordCare(
        workspaceId: workspaceId,
        animalProfileId: profileId,
        title: 'Pakan',
        careType: 'feeding',
        quantityValue: 10,
      ),
      throwsArgumentError,
    );

    final recordId = await care.recordCare(
      workspaceId: workspaceId,
      animalProfileId: profileId,
      title: 'Pakan tambahan',
      careType: 'feeding',
      quantityValue: 12.5,
      quantityUnit: 'gram',
      notes: 'Diberikan setelah aktivitas',
    );
    final record = await (database.select(database.careRecords)
          ..where((table) => table.id.equals(recordId)))
        .getSingle();
    final outbox = await (database.select(database.syncOutbox)
          ..where((table) => table.entityId.equals(recordId)))
        .getSingle();

    expect(record.scheduleId, isNull);
    expect(record.quantityValue, 12.5);
    expect(record.quantityUnit, 'gram');
    expect(record.notes, 'Diberikan setelah aktivitas');
    expect(outbox.entityKind, 'care_record');
    expect(outbox.operationKind, 'create');
  });

  test('archiving a schedule does not delete completed activity history',
      () async {
    final (workspaceId, profileId) = await createWorkspaceAndProfile();
    final scheduleId = await care.createSchedule(
      workspaceId: workspaceId,
      animalProfileId: profileId,
      title: 'Pembersihan kandang',
      careType: 'cleaning',
      recurrenceType: 'weekly',
      scheduledAt: DateTime.utc(2026, 11, 1),
    );
    await care.completeSchedule(
      workspaceId: workspaceId,
      scheduleId: scheduleId,
      performedAt: DateTime.utc(2026, 11, 1, 10),
    );

    await care.archiveSchedule(
      workspaceId: workspaceId,
      scheduleId: scheduleId,
    );

    final schedule = await (database.select(database.careSchedules)
          ..where((table) => table.id.equals(scheduleId)))
        .getSingle();
    final history = await (database.select(database.careRecords)
          ..where((table) => table.scheduleId.equals(scheduleId)))
        .get();

    expect(schedule.isActive, isFalse);
    expect(schedule.archivedAt, isNotNull);
    expect(history, hasLength(1));
  });
}
