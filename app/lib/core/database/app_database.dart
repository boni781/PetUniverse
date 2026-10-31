import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';

import 'tables/animal_habitat_assignments.dart';
import 'tables/animal_profiles.dart';
import 'tables/app_users.dart';
import 'tables/group_details.dart';
import 'tables/group_memberships.dart';
import 'tables/habitats.dart';
import 'tables/individual_details.dart';
import 'tables/species.dart';
import 'tables/species_attribute_definitions.dart';
import 'tables/sync_outbox.dart';
import 'tables/workspace_memberships.dart';
import 'tables/workspaces.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    AppUsers,
    Workspaces,
    WorkspaceMemberships,
    Species,
    SpeciesAttributeDefinitions,
    AnimalProfiles,
    IndividualDetails,
    GroupDetails,
    GroupMemberships,
    Habitats,
    AnimalHabitatAssignments,
    SyncOutbox,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_connect());

  AppDatabase.forTesting(super.connection);

  static DatabaseConnection _connect() {
    return driftDatabase(
      name: 'pet_universe',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
        onResult: (result) {
          if (result.missingFeatures.isNotEmpty) {
            debugPrint(
              'PetUniverse database browser fallback: '
              '${result.chosenImplementation}; '
              'missing features: ${result.missingFeatures}',
            );
          }
        },
      ),
    );
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (migrator) async {
          await migrator.createAll();
        },
        onUpgrade: (migrator, from, to) async {
          throw StateError(
            'No database migration is registered from schema $from to $to. '
            'PetUniverse will not reset or delete existing local data.',
          );
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}
