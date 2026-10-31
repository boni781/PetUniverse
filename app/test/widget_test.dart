import 'dart:ui' show Offset, Size;

import 'package:flutter/material.dart' show SingleChildScrollView;
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_universe/pet_universe_app.dart';

void main() {
  testWidgets('shows the initial PetUniverse application shell', (tester) async {
    await tester.pumpWidget(const PetUniverseApp());

    expect(find.text('PetUniverse'), findsOneWidget);
    expect(find.text('Semua hewan, satu tempat.'), findsOneWidget);
    expect(find.text('Fondasi aplikasi'), findsOneWidget);
    expect(find.text('Android'), findsOneWidget);
    expect(find.text('iOS'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('home page remains usable on a short display', (tester) async {
    tester.view.physicalSize = const Size(800, 480);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const PetUniverseApp());

    expect(find.text('Semua hewan, satu tempat.'), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -240),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}
