import 'package:drift/drift.dart' show DatabaseConnection;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_universe/core/database/app_database.dart';
import 'package:pet_universe/pet_universe_app.dart';

AppDatabase createTestDatabase() {
  return AppDatabase.forTesting(
    DatabaseConnection(
      NativeDatabase.memory(),
      closeStreamsSynchronously: true,
    ),
  );
}

typedef _AppTestBody = Future<void> Function(AppDatabase database);

Future<void> _withPetUniverse(
  WidgetTester tester,
  _AppTestBody body, {
  Size viewSize = const Size(800, 900),
}) async {
  final database = createTestDatabase();

  tester.view.physicalSize = viewSize;
  tester.view.devicePixelRatio = 1;

  try {
    await tester.pumpWidget(PetUniverseApp(database: database));
    await body(database);
  } finally {
    // Dispose StreamBuilder subscriptions and close Drift before the
    // testWidgets binding checks for pending timers.
    await tester.pumpWidget(const SizedBox.shrink());
    await database.close();

    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  }
}

void main() {
  testWidgets('shows the dashboard and workspace selector', (tester) async {
    await _withPetUniverse(tester, (database) async {
      await tester.pumpAndSettle();

      expect(find.text('PetUniverse'), findsOneWidget);
      expect(find.text('Selamat datang di PetUniverse 👋'), findsOneWidget);
      expect(find.text('Ringkasan'), findsOneWidget);
      expect(find.text('Professional'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });

  testWidgets('switches workspace to Professional', (tester) async {
    await _withPetUniverse(tester, (database) async {
      await tester.pumpAndSettle();
      await tester.tap(find.text('Professional').last);
      await tester.pumpAndSettle();

      expect(
        find.textContaining('Ruang kerja untuk mengelola banyak hewan'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    });
  });

  testWidgets('mobile navigation opens local animal management',
      (tester) async {
    await _withPetUniverse(tester, (database) async {
      await tester.pumpAndSettle();
      await tester.tap(find.text('Hewan').last);
      await tester.pumpAndSettle();

      expect(find.text('Pengelolaan hewan'), findsOneWidget);
      expect(find.text('Belum ada profil hewan'), findsOneWidget);
      expect(find.text('Buat profil pertama'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });

  testWidgets('a new individual profile appears after local save',
      (tester) async {
    await _withPetUniverse(tester, (database) async {
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
  });

  testWidgets('desktop navigation opens habitat management', (tester) async {
    await _withPetUniverse(
      tester,
      (database) async {
        await tester.pumpAndSettle();
        await tester.tap(find.text('Habitat').first);
        await tester.pumpAndSettle();

        expect(find.text('Habitat dan kandang'), findsOneWidget);
        expect(find.text('Tambah habitat'), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
      viewSize: const Size(1440, 900),
    );
  });

  testWidgets('mobile More menu opens habitat management', (tester) async {
    await _withPetUniverse(tester, (database) async {
      await tester.pumpAndSettle();
      await tester.tap(find.text('Lainnya').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Habitat dan kandang'));
      await tester.pumpAndSettle();

      expect(find.text('Habitat dan kandang'), findsOneWidget);
      expect(find.text('Belum ada habitat'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });

  testWidgets('mobile navigation opens care management', (tester) async {
    await _withPetUniverse(tester, (database) async {
      await tester.pumpAndSettle();
      await tester.tap(find.text('Jadwal').last);
      await tester.pumpAndSettle();

      expect(find.text('Jadwal perawatan'), findsOneWidget);
      expect(find.text('Buat jadwal perawatan'), findsOneWidget);
      expect(find.text('Belum ada jadwal perawatan'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });

  testWidgets('desktop layout renders without overflow', (tester) async {
    await _withPetUniverse(
      tester,
      (database) async {
        await tester.pumpAndSettle();

        expect(find.text('Katalog spesies'), findsOneWidget);
        expect(find.text('Selamat datang di PetUniverse 👋'), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
      viewSize: const Size(1440, 900),
    );
  });
}
