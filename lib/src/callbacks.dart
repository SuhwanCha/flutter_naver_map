part of flutter_naver_map;

typedef MapCreateCallback = void Function(NaverMapController controller);

typedef CameraPositionCallback = void Function(CameraPosition position);

typedef OnMarkerTab = void Function(Marker? marker, Map<String, int?> iconSize);

typedef OnMapTap = void Function(LatLng latLng);

typedef OnMapLongTap = void Function(LatLng latLng);

typedef OnMapDoubleTap = void Function(LatLng latLng);

typedef OnMapTwoFingerTap = void Function(LatLng latLng);

typedef OnCameraChange = void Function(
  LatLng? latLng,
  CameraChangeReason reason,
  bool? isAnimated,
);

typedef OnSymbolTap = void Function(LatLng? position, String? caption);

typedef OnPathOverlayTab = void Function(PathOverlayId pathOverlayId);
