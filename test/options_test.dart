// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('nightModeEnabled can only be set to true when mapType is navi', () {
    expect(
      () => NaverMapOptions(
        nightModeEnabled: true,
        mapType: MapType.basic,
      ),
      throwsAssertionError,
    );
  });
}
