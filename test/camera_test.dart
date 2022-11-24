import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'CameraOptions',
    () {
      test(
        'throws AssertionError when tilt is less than 0',
        () {
          expect(
            () => CameraUpdateOptions(
              tilt: -1,
            ),
            throwsAssertionError,
          );
        },
      );
      test(
        'throws AssertionError when tilt is greater than 70',
        () {
          expect(
            () => CameraUpdateOptions(
              tilt: 71,
            ),
            throwsAssertionError,
          );
        },
      );
      test(
        'throws AssertionError when zoom is less than 0',
        () {
          expect(
            () => CameraUpdateOptions(
              zoom: -1,
            ),
            throwsAssertionError,
          );
        },
      );
      test(
        'throws AssertionError when zoom is greater than 21',
        () {
          expect(
            () => CameraUpdateOptions(
              zoom: 22,
            ),
            throwsAssertionError,
          );
        },
      );
    },
  );
}
