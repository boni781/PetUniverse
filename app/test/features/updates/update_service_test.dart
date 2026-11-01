import 'package:flutter_test/flutter_test.dart';
import 'package:pet_universe/features/updates/data/update_service.dart';

void main() {
  group('UpdateService.compareVersions', () {
    test('compares semantic version parts numerically', () {
      expect(UpdateService.compareVersions('0.10.0', '0.9.9'), 1);
      expect(UpdateService.compareVersions('1.0.0', '0.99.99'), 1);
      expect(UpdateService.compareVersions('0.4.2', '0.4.3'), -1);
      expect(UpdateService.compareVersions('0.9.9', '1.0.0'), -1);
    });

    test('accepts a leading v in release tags', () {
      expect(UpdateService.compareVersions('v1.2.0', '1.1.9'), 1);
      expect(UpdateService.compareVersions('V1.2.0', 'v1.2.0'), 0);
    });

    test('ignores build metadata when comparing app versions', () {
      expect(UpdateService.compareVersions('0.1.0+9', '0.1.0+1'), 0);
    });

    test('throws for an invalid semantic version', () {
      expect(
        () => UpdateService.compareVersions('latest', '0.1.0'),
        throwsA(isA<UpdateException>()),
      );
    });
  });
}
