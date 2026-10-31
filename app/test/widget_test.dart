import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_universe/pet_universe_app.dart';

void main() {
  testWidgets('shows the dashboard and workspace selector', (tester) async {
    tester.view.physicalSize = const Size(800, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const PetUniverseApp());

    expect(find.text('PetUniverse'), findsOneWidget);
    expect(find.text('Selamat datang di PetUniverse 👋'), findsOneWidget);
    expect(find.text('Ringkasan'), findsOneWidget);
    expect(find.text('Professional'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('switches workspace to Professional', (tester) async {
    tester.view.physicalSize = const Size(800, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const PetUniverseApp());
    await tester.tap(find.text('Professional').last);
    await tester.pumpAndSettle();

    expect(
      find.textContaining('Ruang kerja untuk mengelola banyak hewan'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('mobile navigation opens animal management', (tester) async {
    tester.view.physicalSize = const Size(800, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const PetUniverseApp());
    await tester.tap(find.text('Hewan').last);
    await tester.pumpAndSettle();

    expect(find.text('Pengelolaan hewan'), findsOneWidget);
    expect(find.text('Belum ada profil hewan'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('desktop layout renders without overflow', (tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const PetUniverseApp());

    expect(find.text('Katalog spesies'), findsOneWidget);
    expect(find.text('Selamat datang di PetUniverse 👋'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
