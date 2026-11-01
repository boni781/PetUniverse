import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart' show DatabaseConnection;
import 'package:drift/native.dart';
import 'package:pet_universe/core/database/app_database.dart';
import 'package:pet_universe/pet_universe_app.dart';

AppDatabase createTestDatabase() {
  return AppDatabase.forTesting(DatabaseConnection(
    NativeDatabase.memory(),
    closeStreamsSynchronously: true,
  ));
}

void main() {
  testWidgets('shows the dashboard and workspace selector', (tester) async {
    final database = createTestDatabase();
    addTearDown(database.close);

    tester.view.physicalSize = const Size(800, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(PetUniverseApp(database: database));
    await tester.pumpAndSettle();

    expect(find.text('PetUniverse'), findsOneWidget);
    expect(find.text('Selamat datang di PetUniverse 👋'), findsOneWidget);
    expect(find.text('Ringkasan'), findsOneWidget);
    expect(find.text('Professional'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('switches workspace to Professional', (tester) async {
    final database = createTestDatabase();
    addTearDown(database.close);

    tester.view.physicalSize = const Size(800, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(PetUniverseApp(database: database));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Professional').last);
    await tester.pumpAndSettle();

    expect(
      find.textContaining('Ruang kerja untuk mengelola banyak hewan'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('mobile navigation opens local animal management', (tester) async {
    final database = createTestDatabase();
    addTearDown(database.close);

    tester.view.physicalSize = const Size(800, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(PetUniverseApp(database: database));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Hewan').last);
    await tester.pumpAndSettle();

    expect(find.text('Pengelolaan hewan'), findsOneWidget);
    expect(find.text('Belum ada profil hewan'), findsOneWidget);
    expect(find.text('Buat profil pertama'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('a new individual profile appears after local save', (tester) async {
    final database = createTestDatabase();
    addTearDown(database.close);

    tester.view.physicalSize = const Size(800, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(PetUniverseApp(database: database));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Hewan').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Buat profil pertama'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('animal-name-field')),
      'Milo',
    );
    await tester.tap(find.text('Simpan lokal'));
    await tester.pumpAndSettle();

    expect(find.text('Milo'), findsOneWidget);
    expect(find.textContaining('Individu'), findsOneWidget);
    expect(find.textContaining('tersimpan di perangkat'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('desktop layout renders without overflow', (tester) async {
    final database = createTestDatabase();
    addTearDown(database.close);

    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(PetUniverseApp(database: database));
    await tester.pumpAndSettle();

    expect(find.text('Katalog spesies'), findsOneWidget);
    expect(find.text('Selamat datang di PetUniverse 👋'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
