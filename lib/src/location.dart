part of flutter_naver_map;

/// 위도와 경도가 한 쌍을 이루어서 저장되는 class.
///
@LatLngConverter()
class LatLng extends Equatable {
  const LatLng(double latitude, double longitude)
      : latitude =
            latitude < -90.0 ? -90.0 : (90.0 < latitude ? 90.0 : latitude),
        longitude = (longitude + 180.0) % 360.0 - 180.0;

  factory LatLng.fromJson(List<double> json) =>
      const LatLngConverter().fromJson(json);

  factory LatLng.fromArguments(Map<String, dynamic> arguments) {
    final position = arguments['position'] as List<Object?>;
    return LatLng(position[0]! as double, position[1]! as double);
  }

  List<double> toJson() => const LatLngConverter().toJson(this);

  /// Latitude
  final double latitude;

  /// Longitude
  final double longitude;

  @override
  String toString() => '$latitude, $longitude';

  @override
  List<Object?> get props => [latitude, longitude];
}

/// 북동쪽 위, 경도와 남서쪽 위,경도로 만들어진 사각형 영역이다.
class LatLngBounds extends Equatable {
  LatLngBounds({required this.southwest, required this.northeast})
      : assert(
          southwest.latitude <= northeast.latitude,
          'southwest latitude must be less than or equal to northeast latitude',
        ),
        assert(
          southwest.longitude <= northeast.longitude,
          'southwest longitude must be less than or equal to northeast '
          'longitude',
        );

  /// <h2>LatLng 의 배열로 LatLngBounds 를 만드는 factory</h2>
  /// <hr/>
  /// <p>list로 전달된 [LatLng]들의 배열들을 이용해서 south, north, east, west 를
  /// 계산하여 [LatLngBounds]를 생성한다.</p>
  factory LatLngBounds.fromLatLngList(List<LatLng> latLngs) {
    if (latLngs.length < 2) {
      throw ArgumentError('최소한 2개 이상의 리스트 길이가 있어야 LatLngBounds를 만들 수 있습니다.');
    }
    var south = 200.0;
    var west = 200.0;
    var north = -200.0;
    var east = -200.0;
    for (final latLng in latLngs) {
      if (south > latLng.longitude) south = latLng.longitude;
      if (north < latLng.longitude) north = latLng.longitude;
      if (east < latLng.latitude) east = latLng.latitude;
      if (west > latLng.latitude) west = latLng.latitude;
    }
    return LatLngBounds(
      southwest: LatLng(west, south),
      northeast: LatLng(east, north),
    );
  }

  /// The southwest corner of the rectangle.
  final LatLng southwest;

  /// The northeast corner of the rectangle.
  final LatLng northeast;

  @Deprecated('Use toJson instead')
  List<List<double>> get json => [southwest.toJson(), northeast.toJson()];

  /// Returns whether this rectangle contains the given [LatLng].
  bool contains(LatLng point) {
    return _containsLatitude(point.latitude) &&
        _containsLongitude(point.longitude);
  }

  bool _containsLatitude(double lat) {
    return (southwest.latitude <= lat) && (lat <= northeast.latitude);
  }

  bool _containsLongitude(double lng) {
    if (southwest.longitude <= northeast.longitude) {
      return southwest.longitude <= lng && lng <= northeast.longitude;
    } else {
      return southwest.longitude <= lng || lng <= northeast.longitude;
    }
  }

  static LatLngBounds? fromList(List<List<double>>? json) {
    if (json == null) {
      return null;
    }
    return LatLngBounds(
      southwest: LatLng.fromJson(json[0]),
      northeast: LatLng.fromJson(json[1]),
    );
  }

  @override
  String toString() {
    return '$southwest, $northeast';
  }

  @override
  List<Object?> get props => [southwest, northeast];
}
//
//List<Map<String, double>> _serializeLatLngList(List<LatLng> locations) {
//  if (locations == null) return null;
//  return locations.map((location) => location._toJson()).toList();
//}

enum LocationTrackingMode {
  /// 위치를 추적하지 않습니다.
  none,

  /// 위치 추적이 활성화되고, 현위치 오버레이가 사용자의 위치를 따라 움직입니다.
  /// 그러나 지도는 움직이지 않습니다.
  noFollow,

  /// 위치 추적이 활성화되고, 현위치 오버레이와 카메라의 좌표가 사용자의 위치를 따라
  /// 움직입니다. API나 제스처를 사용해 임의로 카메라를 움직일 경우 모드가
  /// NoFollow로 바뀝니다.
  follow,

  /// 위치 추적이 활성화되고, 현위치 오버레이, 카메라의 좌표, 베어링이 사용자의 위치
  /// 및 방향을 따라 움직입니다. API나 제스처를 사용해 임의로 카메라를 움직일 경우
  /// 모드가 NoFollow로 바뀝니다.
  face,
}
