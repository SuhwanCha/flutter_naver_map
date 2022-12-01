part of flutter_naver_map;

class NaverMapController {
  NaverMapController();

  MethodChannel? _channel;

  LocationOverlay? locationOverlay;

  bool get isInitialized => _channel != null;

  /// [StreamController] to emit events from the native side.
  late final StreamController<bool> _cameraStreamController;

  Future<void> init(
    MethodChannel channel,
    StreamController<bool> streamController,
  ) async {
    _channel = channel;
    _cameraStreamController = streamController;
    locationOverlay = LocationOverlay(this);
  }

  Future<void> moveCamera({
    required AbstractCameraUpdateOptions options,
    Offset? pivot,
    CameraAnimation curve = CameraAnimation.none,
    Duration duration = Duration.zero,
  }) async {
    // Native method doens't implemented asynchoronously, so we need to wait for
    // the result with a completer and Subscription.

    final cameraUpdate = CameraUpdate(
      options: options,
      pivot: pivot,
      curve: curve,
      duration: duration,
    );

    await _channel?.invokeMethod<void>('camera#move', <String, dynamic>{
      'cameraUpdate': cameraUpdate.toJson(),
    });

    final complete = Completer<void>();

    StreamSubscription<bool>? subscription;

    subscription = _cameraStreamController.stream.listen((isFinished) {
      if (isFinished) {
        subscription?.cancel();
        complete.complete();
      }
    });

    return complete.future;
  }

  /// Updates the options on the map.
  Future<void> update(NaverMapOptions options) async {
    return _channel?.invokeMethod(
      'map#update',
      <String, dynamic>{
        'options': options.toJson(),
      },
    );
  }

  /// 네이버 맵 위젯의 메모리 할당을 해제합니다
  /// 현재, IOS 기기에서 네이버 맵 인스턴스 해제가 되지 않는 이슈가 있어, 이 Method는 IOS 플랫폼에서만 지원 합니다.
  /// (안드로이드 기기는 자동 해제됩니다.)
  /// Ex) Platform.isIOS 조건문 이용
  Future<void> clearMapView() async {
    await _channel?.invokeMethod<List<dynamic>>('map#clearMapView');
  }

  /// 현재 지도에 보여지는 영역에 대한 [LatLngBounds] 객체를 리턴.
  Future<LatLngBounds> getVisibleRegion() async {
    final latLngBounds = (await _channel
        ?.invokeMapMethod<String, dynamic>('map#getVisibleRegion'))!;
    final southwest =
        LatLng.fromJson(latLngBounds['southwest'] as List<double>);
    final northeast =
        LatLng.fromJson(latLngBounds['northeast'] as List<double>);

    return LatLngBounds(northeast: northeast, southwest: southwest);
  }

  /// 현재 지도의 중심점 좌표에 대한 [CameraPosition] 객체를 리턴.
  Future<CameraPosition> getCameraPosition() async {
    final position = (await _channel
        ?.invokeMethod<Map<String, dynamic>>('map#getPosition'))!;
    return CameraPosition(
      target: LatLng.fromJson(position['target'] as List<double>),
      zoom: position['zoom'] as double,
      tilt: position['tilt'] as double,
      bearing: position['bearing'] as double,
    );
  }

  /// 지도가 보여지는 view 의 크기를 반환.
  /// Map<String, double>로 반환.
  ///
  /// ['width' : 가로 pixel, 'height' : 세로 pixel]
  Future<Map<String, int?>> getSize() async {
    final size =
        (await _channel?.invokeMethod<Map<String, dynamic>>('map#getSize'))!;
    return <String, int?>{
      'width': size['width'] as int?,
      'height': size['height'] as int?,
    };
  }

  /// Update [LocationTrackingMode] of the map.
  @Deprecated('Use [update] instead')
  Future<void> setLocationTrackingMode(LocationTrackingMode mode) async {
    await _channel?.invokeMethod('tracking#mode', <String, dynamic>{
      'locationTrackingMode': mode.index,
    });
  }

  @Deprecated('Use [update] instead')
  Future<void> setMapType(MapType type) async {
    await _channel?.invokeMethod('map#type', {'mapType': type.index});
  }

  // /// <h3>현재 지도의 모습을 캡쳐하여 cache file 에 저장하고 완료되면 [onSnapShotDone]을 통해 파일의 경로를 전달한다.</h3>
  // /// <br/>
  // /// <p>네이티브에서 실행중 문제가 발생시에 [onSnapShotDone]의 파라미터로 null 이 들어온다</p>
  // void takeSnapshot(void Function(String? path) onSnapShotDone) {
  //   _onSnapShotDone = onSnapShotDone;
  //   _channel?.invokeMethod<String>('map#capture');
  // }

  /// <h3>지도의 content padding 을 설정한다.</h3>
  /// <p>인자로 받는 값의 단위는 DP 단위이다.</p>
  Future<void> setContentPadding({
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) async {
    await _channel?.invokeMethod('map#padding', <String, dynamic>{
      'left': left ?? 0.0,
      'right': right ?? 0.0,
      'top': top ?? 0.0,
      'bottom': bottom ?? 0.0,
    });
  }

  /// <h2>현재 지도의 축적을 미터/DP 단위로 반환합니다.</h2>
  /// <p>dp 단위를 미터로 환산하는 경우 해당 메서드를 통해서 확인할 수 있다.</p>
  Future<double> getMeterPerDp() async {
    final result = await _channel?.invokeMethod<double>('meter#dp');
    return result ?? 0.0;
  }

  /// <h2>현재 지도의 축적을 미터/Pixel 단위로 반환합니다.</h2>
  /// <p>픽셀 단위를 미터로 환산하는 경우 해당 메서드를 통해서 확인할 수 있다.</p>
  Future<double> getMeterPerPx() async {
    final result = await _channel?.invokeMethod<double>('meter#px');
    return result ?? 0.0;
  }

  /// 네이버 지도 SDK의 법적 공지
  void showLegalNotice() {
    _channel?.invokeMethod('showLegalNotice');
  }

  /// 네이버 지도 SDK의 오픈소스 라이선스
  void showOpenSourceLicense() {
    _channel?.invokeMethod('showOpenSourceLicense');
  }
}

/// <h2>위치 오버레이</h2>
/// <p>위치 오버레이는 사용자의 위치를 나타내는 데 특화된 오버레이이로, 지도상에 단 하나만
/// 존재합니다. 사용자가 바라보는 방향을 손쉽게 지정할 수 있고 그림자, 강조용 원도 나타낼 수 있습니다.</p>
class LocationOverlay {
  /// 해당 객체를 참조하기 위햐서 [NaverMapController]의 맵버변수를 참조하거나,
  /// [NaverMapController]객체를 인자로 넘겨서 새롭게 생성하여 참조한다.
  LocationOverlay(NaverMapController controller)
      : _channel = controller._channel;
  final MethodChannel? _channel;

  /// 위치 오버레이의 좌표를 변경할 수 있습니다.
  /// 처음 생성된 위치 오버레이는 카메라의 초기 좌표에 위치해 있습니다.
  void setPosition(LatLng position) {
    _channel?.invokeMethod('LO#set#position', {
      'position': position.toJson(),
    });
  }

  /// __setBearing__ 을 이용하면 위치 오버레이의 베어링을 변경할 수 있습니다.
  /// flat이 true인 마커의 andgle속성과 유사하게 아이콘이 지도를 기준으로 회전합니다.
  /// > ***0.0은 정북쪽을 의미합니다.***
  ///
  /// 다음은 위치 오버레이의 베어링을 동쪽으로 변경하는 예제입니다.
  /// ```
  /// locaionOverlay.setBearing(90.0);
  /// ```
  void setBearing(double bearing) {
    _channel?.invokeMethod('LO#set#bearing', {'bearing': bearing});
  }
}
