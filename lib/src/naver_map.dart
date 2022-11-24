// ignore_for_file: prefer_constructors_over_static_methods

part of flutter_naver_map;

/// ### 네이버지도
/// 네이버 지도는 네이버 SDK 를 flutter 에서 사용할 수 있게 하는 주요 widget 이다.
class NaverMap extends StatefulWidget {
  const NaverMap({
    required this.controller,
    this.options = const NaverMapOptions(),
    Key? key,
    this.onMapCreated,
    this.onMapTap,
    this.onMapLongTap,
    this.onMapDoubleTap,
    this.onMapTwoFingerTap,
    this.onSymbolTap,
    this.onCameraChange,
    this.onCameraIdle,
    this.pathOverlays,
    this.contentPadding,
    this.markers = const [],
    this.circles = const [],
    this.polygons = const [],
  }) : super(key: key);

  final NaverMapController controller;

  /// 지도가 완전히 만들어진 후에 컨트롤러를 파라미터로 가지는 콜백.
  /// 해당 콜백이 호출되기 전에는 지도가 만들어지는 중이다.
  final MapCreateCallback? onMapCreated;

  /// 지도를 탭했을때 호출되는 콜백함수.
  ///
  ///
  /// 사용자가 선택한 지점의 [LatLng]을 파라미터로 가진다.
  final OnMapTap? onMapTap;

  /// ### 지도를 롱 탭했을때 호출되는 콜백함수. (Android only)
  ///
  /// 사용자가 선택한 지점의 [LatLng]을 파라미터로 가진다.
  final OnMapLongTap? onMapLongTap;

  /// 카메라가 움직일때 호출되는 콜백
  final OnCameraChange? onCameraChange;

  /// 카메라의 움직임이 완료되었을때 호출되는 콜백
  final VoidCallback? onCameraIdle;

  final NaverMapOptions options;

  /// 지도에 표시될 마커의 리스트입니다.
  final List<Marker> markers;

  /// 지도에 표시될 [PathOverlay]의 [Set] 입니다..
  final Set<PathOverlay>? pathOverlays;

  /// 지도에 표시될 [CircleOverlay]의 [List]입니다.
  final List<CircleOverlay> circles;

  /// 지도에 표시될 [PolygonOverlay]의 [List]입니다.
  final List<PolygonOverlay> polygons;

  /// 지도가 더블탭될때 콜백되는 메서드. (Android only)
  final OnMapDoubleTap? onMapDoubleTap;

  /// 지도가 두 손가락으로 탭 되었을때 호출되는 콜백 메서드. (Android only)
  final OnMapTwoFingerTap? onMapTwoFingerTap;

  /// <h2>심볼 탭 이벤트</h2>
  /// <p>빌딩을 나타내는 심볼이나, 공공시설을 표시하는 심볼등을 선택했을 경우 호출된다.</p>
  final OnSymbolTap? onSymbolTap;

  /// ## 콘텐트 패딩
  /// Stack 구조의 화면에서 지도 상에 UI요소가 지도의 일부를 덮을 경우, 카메라는 지도
  /// 뷰의 중심에 위치하므로 실제 보이는 지도의 중심과 카메라의 위치가 불일치하게 됩니다.
  final EdgeInsets? contentPadding;

  @override
  NaverMapState createState() => NaverMapState();
}

class NaverMapState extends State<NaverMap> {
  Map<String, Marker> _markers = <String, Marker>{};
  Map<String, CircleOverlay> _circles = <String, CircleOverlay>{};
  Map<PathOverlayId, PathOverlay> _paths = <PathOverlayId, PathOverlay>{};
  Map<String, PolygonOverlay> _polygons = <String, PolygonOverlay>{};

  @override
  void initState() {
    super.initState();
    _markers = _keyByMarkerId(widget.markers);
    _paths = _keyByPathOverlayId(widget.pathOverlays);
    _circles = _keyByCircleId(widget.circles);
    _polygons = _keyByPolygonId(widget.polygons);
  }

  Future<void> onPlatformViewCreated(int id) async {
    await widget.controller.init(id, this);

    // TODO(suhwancha): request permission if needed

    widget.onMapCreated?.call();
  }

  @override
  Widget build(BuildContext context) {
    final createParams = <String, dynamic>{
      'initialCameraPosition': widget.options.initialCameraPosition?.toJson(),
      'options': widget.options.toJson(),
      'markers': _serializeMarkerSet(widget.markers) ?? [],
      'paths': _serializePathOverlaySet(widget.pathOverlays) ?? [],
      'circles': _serializeCircleSet(widget.circles) ?? [],
      'polygons': _serializePolygonSet(widget.polygons) ?? [],
    };

    if (defaultTargetPlatform == TargetPlatform.android) {
      final view = AndroidView(
        viewType: viewType,
        onPlatformViewCreated: onPlatformViewCreated,
        creationParams: createParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
      return view;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final view = UiKitView(
        viewType: viewType,
        onPlatformViewCreated: onPlatformViewCreated,
        creationParams: createParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
      return view;
    }

    return Text(
      '$defaultTargetPlatform is not yet supported by the maps plugin',
    );
  }

  @override
  void didUpdateWidget(NaverMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    // _updateOptions();
    _updateMarkers();
    _updatePathOverlay();
    _updateCircleOverlay();
    _updatePolygonOverlay();
  }

  // Future<void> _updateOptions() async {
  //   final newOption = _NaverMapOptions.fromWidget(widget);
  //   final updates = _naverMapOptions.updatesMap(newOption);
  //   if (updates.isEmpty) return;
  //   final controller = widget.controller;
  //   await controller._updateMapOptions(updates);
  //   _naverMapOptions = newOption;
  // }

  Future<void> _updateMarkers() async {
    final controller = widget.controller;
    await controller._updateMarkers(
      _MarkerUpdates.from(
        _markers.values.toSet(),
        widget.markers.toSet(),
      ),
    );
    _markers = _keyByMarkerId(widget.markers);
  }

  Future<void> _updatePathOverlay() async {
    final controller = widget.controller;
    await controller._updatePathOverlay(
      _PathOverlayUpdates.from(
        _paths.values.toSet(),
        widget.pathOverlays?.toSet(),
      ),
    );
    _paths = _keyByPathOverlayId(widget.pathOverlays);
  }

  Future<void> _updateCircleOverlay() async {
    final controller = widget.controller;
    await controller._updateCircleOverlay(
      _CircleOverlayUpdate.from(
        _circles.values.toSet(),
        widget.circles.toSet(),
      ),
    );
    _circles = _keyByCircleId(widget.circles);
  }

  Future<void> _updatePolygonOverlay() async {
    final controller = widget.controller;
    await controller._updatePolygonOverlay(
      _PolygonOverlayUpdate.from(
        _polygons.values.toSet(),
        widget.polygons.toSet(),
      ),
    );
    _polygons = _keyByPolygonId(widget.polygons);
  }

  void _markerTapped(String markerId, int? iconWidth, int? iconHeight) {
    if (_markers[markerId]?.onMarkerTab != null) {
      _markers[markerId]!.onMarkerTab!(
        _markers[markerId],
        <String, int?>{'width': iconWidth, 'height': iconHeight},
      );
    }
  }

  void _pathOverlayTapped(String pathId) {
    final pathOverlayId = PathOverlayId(pathId);
    if (_paths[pathOverlayId]?.onPathOverlayTab != null) {
      _paths[pathOverlayId]!.onPathOverlayTab!(pathOverlayId);
    }
  }

  void _circleOverlayTapped(String overlayId) {
    if (_circles[overlayId]?.onTap != null) {
      _circles[overlayId]!.onTap!(overlayId);
    }
  }

  void _polygonOverlayTapped(String overlayId) {
    if (_polygons[overlayId]?.onTap != null) {
      _polygons[overlayId]!.onTap!(overlayId);
    }
  }

  void _mapTap(LatLng position) {
    widget.onMapTap?.call(position);
  }

  void _mapLongTap(LatLng position) {
    widget.onMapLongTap?.call(position);
  }

  void _mapDoubleTap(LatLng position) {
    widget.onMapDoubleTap?.call(position);
  }

  void _mapTwoFingerTap(LatLng position) {
    widget.onMapTwoFingerTap?.call(position);
  }

  void _symbolTab(LatLng? position, String? caption) {
    assert(
      position != null && caption != null,
      'position and caption must not be null',
    );
    widget.onSymbolTap?.call(position, caption);
  }

  void _cameraMove(
    LatLng? position,
    CameraChangeReason reason,
    bool? isAnimated,
  ) {
    widget.onCameraChange?.call(position, reason, isAnimated);
  }

  void _cameraIdle() {
    widget.onCameraIdle?.call();
  }
}
