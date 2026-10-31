import 'package:drift/drift.dart';
import 'animal_profiles.dart';

class IndividualDetails extends Table {
  TextColumn get animalProfileId => text().references(AnimalProfiles, #id)();
  TextColumn get sexCode => text().nullable()();
  DateTimeColumn get birthDate => dateTime().nullable()();
  TextColumn get birthDatePrecision => text().nullable()();
  DateTimeColumn get acquiredAt => dateTime().nullable()();
  TextColumn get lifeStageCode => text().nullable()();
  TextColumn get lifeStageSource => text().nullable()();
  @override
  Set<Column> get primaryKey => {animalProfileId};
}
