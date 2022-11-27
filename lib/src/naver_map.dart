// ignore_for_file: prefer_constructors_over_static_methods

part of flutter_naver_map;

/// ### 네이버지도
/// 네이버 지도는 네이버 SDK 를 flutter 에서 사용할 수 있게 하는 주요 widget 이다.
class NaverMap extends StatefulWidget {
  NaverMap({
    required this.controller,
    this.options = const NaverMapOptions(),
    super.key,
    this.onMapCreated,
    this.onTap,
    this.onLongPress,
    this.onMapDoubleTap,
    this.onMapTwoFingerTap,
    this.onSymbolTap,
    this.onCameraChange,
    this.onCameraChangeStop,
    this.pathOverlays,
    this.contentPadding,
    this.markers = const [],
    this.circles = const [],
    this.polygons = const [],
  }) {}

  late final MethodChannel _channel;

  /// [NaverMapController] for controlling the [NaverMap].
  final NaverMapController controller;

  /// Called when the map is created.
  ///
  /// The [NaverMapController] hasn't been initialized before this callback is
  /// called.
  final void Function()? onMapCreated;

  /// Called when tap gesture is detected.
  ///
  /// The position at which the pointer contacted the screen is available in the
  /// [LatLng].
  final void Function(LatLng latLng)? onTap;

  // TODO(suhwancha): check it can be implemented in iOS

  /// Called when a long press gesture is detected.
  ///
  /// Triggered when a pointer has remained in contact with the screen at the
  /// same location for a long period of time.
  ///
  ///
  /// The position at which the pointer contacted the screen is available in the
  /// [LatLng].
  final void Function(LatLng latlng)? onLongPress;

  /// Called when camera position is changed.
  ///
  /// [onCameraChange] is called with the [LatLng] of the camera position,
  /// [CameraUpdatedReason] of the camera update, and [bool] of the camera
  /// animation.
  final void Function(
    LatLng? latlng,
    CameraUpdatedReason reason,
    bool? isAnimated,
  )? onCameraChange;

  /// Called when camera position is stop changed.
  final VoidCallback? onCameraChangeStop;

  /// Called when a double tap gesture is detected.
  ///
  /// Only available on Android.
  final void Function(LatLng latlng)? onMapDoubleTap;

  /// 지도가 두 손가락으로 탭 되었을때 호출되는 콜백 메서드. (Android only)
  final void Function(LatLng latLng)? onMapTwoFingerTap;

  /// <h2>심볼 탭 이벤트</h2>
  /// <p>빌딩을 나타내는 심볼이나, 공공시설을 표시하는 심볼등을 선택했을 경우 호출된다.</p>
  final void Function(LatLng? position, String? caption)? onSymbolTap;

  /// Options to configure the [NaverMap].
  final NaverMapOptions options;

  /// 지도에 표시될 마커의 리스트입니다.
  final List<Marker> markers;

  /// 지도에 표시될 [PathOverlay]의 [Set] 입니다..
  final Set<PathOverlay>? pathOverlays;

  /// 지도에 표시될 [CircleOverlay]의 [List]입니다.
  final List<CircleOverlay> circles;

  /// 지도에 표시될 [PolygonOverlay]의 [List]입니다.
  final List<PolygonOverlay> polygons;

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
    widget._channel = MethodChannel('${viewType}_$id');
    await widget._channel.invokeMethod<void>('map#waitForMap');
    widget._channel.setMethodCallHandler(_handleMethodCall);

    await widget.controller.init(id, this);
    // TODO(suhwancha): request permission if needed

    widget.onMapCreated?.call();
  }

  Future<dynamic> _handleMethodCall(MethodCall call) {
    // TODO(suhwancha): implement arguments to dart object
    Map<String, dynamic>? arguments;
    try {
      arguments =
          Map<String, dynamic>.from(call.arguments as Map<Object?, Object?>);
    } catch (e) {
      arguments = null;
    }

    switch (call.method) {
      case 'map#clearMapView':
        clearMapView();
        break;
      // case 'marker#onTap':
      //   assert(arguments!['markerId'] != null, 'markerId is null');
      //   final markerId = arguments!['markerId']! as String;
      //   final iconWidth = arguments['iconWidth'] as int?;
      //   final iconHeight = arguments['iconHeight'] as int?;
      //   _naverMapState._markerTapped(markerId, iconWidth, iconHeight);
      //   break;
      // case 'path#onTap':
      //   assert(arguments!['pathId'] != null, 'pathId is null');
      //   final pathId = arguments!['pathId']! as String;
      //   _naverMapState._pathOverlayTapped(pathId);
      //   break;
      // case 'circle#onTap':
      //   assert(arguments!['circleId'] != null, 'circleId is null');
      //   final overlayId = arguments!['overlayId']! as String;
      //   _naverMapState._circleOverlayTapped(overlayId);
      //   break;
      // case 'polygon#onTap':
      //   assert(arguments!['polygonId'] != null, 'polygonId is null');
      //   final overlayId = arguments!['polygonOverlayId']! as String;
      //   _naverMapState._polygonOverlayTapped(overlayId);
      //   break;
      case 'map#onTap':
        final latLng = LatLng.fromArguments(arguments!);
        widget.onTap?.call(latLng);
        break;
      case 'map#onLongTap':
        final latLng = LatLng.fromArguments(arguments!);
        widget.onLongPress?.call(latLng);
        break;
      case 'map#onMapDoubleTap':
        final latLng = LatLng.fromArguments(arguments!);
        widget.onMapDoubleTap?.call(latLng);
        break;
      case 'map#onMapTwoFingerTap':
        final latLng = LatLng.fromArguments(arguments!);
        widget.onMapTwoFingerTap?.call(latLng);
        break;
      case 'map#onSymbolClick':
        final latLng = LatLng.fromArguments(arguments!);
        final caption = arguments['caption'] as String?;
        widget.onSymbolTap?.call(latLng, caption);
        break;
      case 'camera#move':
        // TODO(suhwancha): this method isn't work
        assert(arguments!['reason'] != null, 'reason is null');
        final position =
            LatLng.fromJson(arguments!['position'] as List<double>);
        final reason = CameraUpdatedReason.values[arguments['reason']! as int];
        // TODO(suhwancha): implement stream
        // cameraStreamController.add(reason);
        final isAnimated = arguments['animated'] as bool?;
        widget.onCameraChange?.call(position, reason, isAnimated);
        break;
      case 'camera#idle':
        widget.onCameraChangeStop?.call();
        break;
      case 'snapshot#done':
        // if (_onSnapShotDone != null) {
        //   _onSnapShotDone!(arguments!['path'] as String?);
        //   _onSnapShotDone = null;
        // }
        break;
    }
    return Future<void>.value();
  }

  Future<void> clearMapView() async {
    await widget._channel.invokeMethod<List<dynamic>>('map#clearMapView');
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
    // TODO(suhwancha): we need to check [NaverMapOptions] cloud be changed
    _updateOptions();
    _updateMarkers();
    _updatePathOverlay();
    _updateCircleOverlay();
    _updatePolygonOverlay();
  }

  Future<void> _updateOptions() async {
    final controller = widget.controller;
    await controller._updateOptions(widget.options);
  }

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
    if (_markers[markerId]?.onMarkerTap != null) {
      _markers[markerId]!.onMarkerTap!(
        _markers[markerId],
        <String, int?>{'width': iconWidth, 'height': iconHeight},
      );
    }
  }

  void _pathOverlayTapped(String pathId) {
    final pathOverlayId = PathOverlayId(pathId);
    if (_paths[pathOverlayId]?.onPathOverlayTap != null) {
      _paths[pathOverlayId]!.onPathOverlayTap!(pathOverlayId);
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

  void _mapLongTap(LatLng position) {
    widget.onLongPress?.call(position);
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
    CameraUpdatedReason reason,
    bool? isAnimated,
  ) {
    widget.onCameraChange?.call(position, reason, isAnimated);
  }

  void _cameraIdle() {
    widget.onCameraChangeStop?.call();
  }
}
