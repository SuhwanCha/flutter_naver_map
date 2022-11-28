part of flutter_naver_map;

class OffsetConverter implements JsonConverter<Offset, List<double>> {
  const OffsetConverter();

  @override
  Offset fromJson(List<double> json) {
    return Offset(json[0], json[1]);
  }

  @override
  List<double> toJson(Offset object) {
    return [object.dx, object.dy];
  }
}

class LatLngConverter implements JsonConverter<LatLng, List<double>> {
  const LatLngConverter();

  @override
  LatLng fromJson(List<double> json) {
    return LatLng(json[0], json[1]);
  }

  @override
  List<double> toJson(LatLng object) {
    return [object.latitude, object.longitude];
  }
}

class LatLngBoundsConverter
    implements JsonConverter<LatLngBounds, List<List<double>>> {
  const LatLngBoundsConverter();

  @override
  LatLngBounds fromJson(List<List<double>> json) {
    return LatLngBounds(
      southwest: LatLng(json[0][0], json[0][1]),
      northeast: LatLng(json[1][0], json[1][1]),
    );
  }

  @override
  List<List<double>> toJson(LatLngBounds object) {
    return [
      [object.southwest.latitude, object.southwest.longitude],
      [object.northeast.latitude, object.northeast.longitude],
    ];
  }
}

class EdgeInsetsConverter implements JsonConverter<EdgeInsets, List<double>> {
  const EdgeInsetsConverter();

  @override
  EdgeInsets fromJson(List<double> json) {
    return EdgeInsets.fromLTRB(
      json[0],
      json[1],
      json[2],
      json[3],
    );
  }

  @override
  List<double> toJson(EdgeInsets object) {
    return [
      object.left,
      object.top,
      object.right,
      object.bottom,
    ];
  }
}

class CameraAnimationConverter implements JsonConverter<CameraAnimation, int> {
  const CameraAnimationConverter();

  @override
  CameraAnimation fromJson(int json) {
    return CameraAnimation.values[json];
  }

  @override
  int toJson(CameraAnimation object) {
    return object.index;
  }
}

class DurationConverter implements JsonConverter<Duration, int> {
  const DurationConverter();

  @override
  Duration fromJson(int json) {
    return Duration(milliseconds: json);
  }

  @override
  int toJson(Duration object) {
    return object.inMilliseconds;
  }
}

class CameraUpdateOptionsConverter<T extends AbstractCameraUpdateOptions>
    implements JsonConverter<T, Map<String, dynamic>> {
  const CameraUpdateOptionsConverter();

  @override
  T fromJson(Map<String, dynamic> json) {
    if (T is CameraUpdateOptions) {
      return CameraUpdateOptions.fromJson(json) as T;
    } else {
      return CameraUpdateFitBounds.fromJson(json) as T;
    }
  }

  @override
  Map<String, dynamic> toJson(AbstractCameraUpdateOptions object) {
    return (object as T).toJson();
  }
}

class MapTypeConverter implements JsonConverter<MapType, int> {
  const MapTypeConverter();

  @override
  MapType fromJson(int json) {
    return MapType.values[json];
  }

  @override
  int toJson(MapType object) {
    return object.index;
  }
}

class LocationTrackingModeConverter
    implements JsonConverter<LocationTrackingMode, int> {
  const LocationTrackingModeConverter();

  @override
  LocationTrackingMode fromJson(int json) {
    return LocationTrackingMode.values[json];
  }

  @override
  int toJson(LocationTrackingMode object) {
    return object.index;
  }
}

class SizeConverter implements JsonConverter<Size, List<double>> {
  const SizeConverter();

  @override
  Size fromJson(List<double> json) {
    return Size(json[0], json[1]);
  }

  @override
  List<double> toJson(Size object) {
    return [object.width, object.height];
  }
}

class AnchorPointConverter implements JsonConverter<AnchorPoint, List<double>> {
  const AnchorPointConverter();

  @override
  AnchorPoint fromJson(List<double> json) {
    return AnchorPoint(json[0], json[1]);
  }

  @override
  List<double> toJson(AnchorPoint object) {
    return [object.x, object.y];
  }
}

class ColorConverter implements JsonConverter<Color, int> {
  const ColorConverter();

  @override
  Color fromJson(int json) {
    return Color(json);
  }

  @override
  int toJson(Color object) {
    return object.value;
  }
}
