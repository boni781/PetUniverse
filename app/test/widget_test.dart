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
  });
}
