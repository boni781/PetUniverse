import 'package:drift/drift.dart';
import 'animal_profiles.dart';

class GroupDetails extends Table {
  TextColumn get animalProfileId => text().references(AnimalProfiles, #id)();
  TextColumn get groupPurpose => text().nullable()();
  TextColumn get memberTrackingMode => text()();
  IntColumn get reportedCount => integer().nullable()();
  DateTimeColumn get countObservedAt => dateTime().nullable()();
  TextColumn get countNote => text().nullable()();
  @override
  Set<Column<Object>> get primaryKey => {animalProfileId};
}
