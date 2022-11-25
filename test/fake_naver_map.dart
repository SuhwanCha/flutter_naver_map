// // ignore_for_file: inference_failure_on_function_invocation

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_naver_map/flutter_naver_map.dart';
// import 'package:flutter_test/flutter_test.dart';

// class FakeNaverMapController {
//   FakeNaverMapController();
//   late final MethodChannel? _channel;
//   bool get isInitialized => _channel != null;

//   final cameraStreamController =
//       StreamController<CameraUpdatedReason>.broadcast();

//   Future<void> init(int id) async {
//     _channel = MethodChannel('flutter_naver_map_$id');
//     await _channel?.invokeMockMethod<void>('map#waitForMap');
//     _channel?.setMockMethodCallHandler(_handleMethodCall);
//   }

//   Future<dynamic> _handleMethodCall(MethodCall call) async {
//     switch (call.method) {
//       case 'map#waitForMap':
//         return <String, dynamic>{'mapId': 0};
//       default:
//         throw MissingPluginException();
//     }
//   }

//   Future<void> moveCamera(CameraUpdate cameraUpdate) async {
//     await _channel?.invokeMockMethod<void>('camera#move', <String, dynamic>{
//       'cameraUpdate': cameraUpdate.toJson(),
//     });

//     final complete = Completer<void>();

//     StreamSubscription<CameraUpdatedReason>? subscription;

//     subscription = cameraStreamController.stream.listen((reason) {
//       if (reason == CameraUpdatedReason.programmatically) {
//         subscription?.cancel();
//         complete.complete();
//       }
//     });

//     return complete.future;
//   }
// }

// class FakeNaverMap extends StatefulWidget {
//   FakeNaverMap({
//     Key? key,
//     required this.controller,
//     this.options = const NaverMapOptions(),
//     this.onMapCreated,
//     this.onMapTap,
//     this.onMapLongTap,
//     this.onMapDoubleTap,
//     this.onMapTwoFingerTap,
//     this.onSymbolTap,
//     this.onCameraChange,
//     this.onCameraIdle,
//     this.pathOverlays,
//     this.contentPadding,
//     this.markers = const [],
//     this.circles = const [],
//     this.polygons = const [],
//   }) : super(key: key) {
//     controller.init(0, NaverMapState());
//   }
//   final NaverMapController controller;
//   final MapCreateCallback? onMapCreated;
//   final OnMapTap? onMapTap;
//   final OnMapLongTap? onMapLongTap;
//   final OnCameraChange? onCameraChange;
//   final VoidCallback? onCameraIdle;
//   final NaverMapOptions options;
//   final List<Marker> markers;
//   final Set<PathOverlay>? pathOverlays;
//   final List<CircleOverlay> circles;
//   final List<PolygonOverlay> polygons;
//   final OnMapDoubleTap? onMapDoubleTap;
//   final OnMapTwoFingerTap? onMapTwoFingerTap;
//   final OnSymbolTap? onSymbolTap;
//   final EdgeInsets? contentPadding;

//   @override
//   State<FakeNaverMap> createState() => _FakeNaverMapState();
// }

// class _FakeNaverMapState extends State<FakeNaverMap> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// part of flutter_naver_map;

// class NaverMapController {
//   NaverMapController();

//   late final MethodChannel? _channel;

//   late final NaverMapState _naverMapState;

//   void Function(String? path)? _onSnapShotDone;

//   LocationOverlay? locationOverlay;

//   bool get isInitialized => _channel != null;

//   /// [StreamController] to emit events from the native side.
//   final cameraStreamController =
//       StreamController<CameraUpdatedReason>.broadcast();

//   Future<void> init(int id, NaverMapState naverMapState) async {
//     _channel = MethodChannel('${viewType}_$id');
//     _naverMapState = naverMapState;
//     await _channel?.invokeMockMethod<void>('map#waitForMap');
//     _channel?.setMethodCallHandler(_handleMethodCall);
//     locationOverlay = LocationOverlay(this);
//   }

//   Future<void> moveCamera(CameraUpdate cameraUpdate) async {
//     // Native method doens't implemented asynchoronously, so we need to wait for
//     // the result with a completer and Subscription.

//     await _channel?.invokeMockMethod<void>('camera#move', <String, dynamic>{
//       'cameraUpdate': cameraUpdate.toJson(),
//     });

//     final complete = Completer<void>();

//     StreamSubscription<CameraUpdatedReason>? subscription;

//     subscription = cameraStreamController.stream.listen((reason) {
//       if (reason == CameraUpdatedReason.programmatically) {
//         subscription?.cancel();
//         complete.complete();
//       }
//     });

//     return complete.future;
//   }

//   /// Updates the options on the map.
//   Future<void> update(NaverMapOptions options) async {
//     return _channel?.invokeMockMethod(
//       'map#update',
//       <String, dynamic>{
//         'options': options.toJson(),
//       },
//     );
//   }

//   Future<dynamic> _handleMethodCall(MethodCall call) {
//     // TODO(suhwancha): implement arguments to dart object
//     Map<String, dynamic>? arguments;

//     try {
//       arguments =
//           Map<String, dynamic>.from(call.arguments as Map<Object?, Object?>);
//     } catch (e) {
//       arguments = null;
//     }

//     switch (call.method) {
//       case 'map#clearMapView':
//         clearMapView();
//         break;
//       case 'camera#move':
//         assert(arguments!['reason'] != null, 'reason is null');
//         final position =
//             LatLng.fromJson(arguments!['position'] as List<double>);
//         final reason = CameraUpdatedReason.values[arguments['reason']! as int];
//         cameraStreamController.add(reason);
//         final isAnimated = arguments['animated'] as bool?;
//         _naverMapState._cameraMove(position, reason, isAnimated);
//         break;
//       case 'camera#idle':
//         _naverMapState._cameraIdle();
//         break;
//       case 'snapshot#done':
//         if (_onSnapShotDone != null) {
//           _onSnapShotDone!(arguments!['path'] as String?);
//           _onSnapShotDone = null;
//         }
//         break;
//     }
//     return Future<void>.value();
//   }

//   /// 네이버 맵 위젯의 메모리 할당을 해제합니다
//   /// 현재, IOS 기기에서 네이버 맵 인스턴스 해제가 되지 않는 이슈가 있어, 이 Method는 IOS 플랫폼에서만 지원 합니다.
//   /// (안드로이드 기기는 자동 해제됩니다.)
//   /// Ex) Platform.isIOS 조건문 이용
//   Future<void> clearMapView() async {
//     await _channel?.invokeMockMethod<List<dynamic>>('map#clearMapView');
//   }

//   Future<void> _updateMarkers(_MarkerUpdates markerUpdate) async {
//     await _channel?.invokeMockMethod<void>(
//       'markers#update',
//       markerUpdate._toMap(),
//     );
//   }

//   Future<void> _updatePathOverlay(
//     _PathOverlayUpdates pathOverlayUpdates,
//   ) async {
//     await _channel?.invokeMockMethod(
//       'pathOverlay#update',
//       pathOverlayUpdates._toMap(),
//     );
//   }

//   Future<void> _updateCircleOverlay(
//     _CircleOverlayUpdate circleOverlayUpdate,
//   ) async {
//     await _channel?.invokeMockMethod(
//       'circleOverlay#update',
//       circleOverlayUpdate._toMap(),
//     );
//   }

//   Future<void> _updatePolygonOverlay(
//     _PolygonOverlayUpdate polygonOverlayUpdate,
//   ) async {
//     await _channel?.invokeMockMethod(
//       'polygonOverlay#update',
//       polygonOverlayUpdate._toMap(),
//     );
//   }

//   /// 현재 지도에 보여지는 영역에 대한 [LatLngBounds] 객체를 리턴.
//   Future<LatLngBounds> getVisibleRegion() async {
//     final latLngBounds = (await _channel
//         ?.invokeMapMethod<String, dynamic>('map#getVisibleRegion'))!;
//     final southwest =
//         LatLng.fromJson(latLngBounds['southwest'] as List<double>);
//     final northeast =
//         LatLng.fromJson(latLngBounds['northeast'] as List<double>);

//     return LatLngBounds(northeast: northeast, southwest: southwest);
//   }

//   /// 현재 지도의 중심점 좌표에 대한 [CameraPosition] 객체를 리턴.
//   Future<CameraPosition> getCameraPosition() async {
//     final position = (await _channel
//         ?.invokeMockMethod<Map<String, dynamic>>('map#getPosition'))!;
//     return CameraPosition(
//       target: LatLng.fromJson(position['target'] as List<double>),
//       zoom: position['zoom'] as double,
//       tilt: position['tilt'] as double,
//       bearing: position['bearing'] as double,
//     );
//   }

//   /// 지도가 보여지는 view 의 크기를 반환.
//   /// Map<String, double>로 반환.
//   ///
//   /// ['width' : 가로 pixel, 'height' : 세로 pixel]
//   Future<Map<String, int?>> getSize() async {
//     final size =
//         (await _channel?.invokeMockMethod<Map<String, dynamic>>('map#getSize'))!;
//     return <String, int?>{
//       'width': size['width'] as int?,
//       'height': size['height'] as int?,
//     };
//   }

//   Future<void> setLocationTrackingMode(LocationTrackingMode mode) async {
//     await _channel?.invokeMockMethod('tracking#mode', <String, dynamic>{
//       'locationTrackingMode': mode.index,
//     });
//   }

//   /// ### 지도의 유형 변경
//   /// [MapType]을 전달하면 해당 유형으로 지도의 타일 유형이 변경된다.
//   Future<void> setMapType(MapType type) async {
//     await _channel?.invokeMockMethod('map#type', {'mapType': type.index});
//   }

//   /// <h3>현재 지도의 모습을 캡쳐하여 cache file 에 저장하고 완료되면 [onSnapShotDone]을 통해 파일의 경로를 전달한다.</h3>
//   /// <br/>
//   /// <p>네이티브에서 실행중 문제가 발생시에 [onSnapShotDone]의 파라미터로 null 이 들어온다</p>
//   // TODO(suhwancha): make this method to use Future
//   void takeSnapshot(void Function(String? path) onSnapShotDone) {
//     _onSnapShotDone = onSnapShotDone;
//     _channel?.invokeMockMethod<String>('map#capture');
//   }

//   /// <h3>지도의 content padding 을 설정한다.</h3>
//   /// <p>인자로 받는 값의 단위는 DP 단위이다.</p>
//   Future<void> setContentPadding({
//     double? left,
//     double? right,
//     double? top,
//     double? bottom,
//   }) async {
//     await _channel?.invokeMockMethod('map#padding', <String, dynamic>{
//       'left': left ?? 0.0,
//       'right': right ?? 0.0,
//       'top': top ?? 0.0,
//       'bottom': bottom ?? 0.0,
//     });
//   }

//   /// <h2>현재 지도의 축적을 미터/DP 단위로 반환합니다.</h2>
//   /// <p>dp 단위를 미터로 환산하는 경우 해당 메서드를 통해서 확인할 수 있다.</p>
//   Future<double> getMeterPerDp() async {
//     final result = await _channel?.invokeMockMethod<double>('meter#dp');
//     return result ?? 0.0;
//   }

//   /// <h2>현재 지도의 축적을 미터/Pixel 단위로 반환합니다.</h2>
//   /// <p>픽셀 단위를 미터로 환산하는 경우 해당 메서드를 통해서 확인할 수 있다.</p>
//   Future<double> getMeterPerPx() async {
//     final result = await _channel?.invokeMockMethod<double>('meter#px');
//     return result ?? 0.0;
//   }

//   /// 네이버 지도 SDK의 법적 공지
//   void showLegalNotice() {
//     _channel?.invokeMockMethod('showLegalNotice');
//   }

//   /// 네이버 지도 SDK의 오픈소스 라이선스
//   void showOpenSourceLicense() {
//     _channel?.invokeMockMethod('showOpenSourceLicense');
//   }
// }

// /// <h2>위치 오버레이</h2>
// /// <p>위치 오버레이는 사용자의 위치를 나타내는 데 특화된 오버레이이로, 지도상에 단 하나만
// /// 존재합니다. 사용자가 바라보는 방향을 손쉽게 지정할 수 있고 그림자, 강조용 원도 나타낼 수 있습니다.</p>
// class LocationOverlay {
//   /// 해당 객체를 참조하기 위햐서 [NaverMapController]의 맵버변수를 참조하거나,
//   /// [NaverMapController]객체를 인자로 넘겨서 새롭게 생성하여 참조한다.
//   LocationOverlay(NaverMapController controller)
//       : _channel = controller._channel;
//   final MethodChannel? _channel;

//   /// 위치 오버레이의 좌표를 변경할 수 있습니다.
//   /// 처음 생성된 위치 오버레이는 카메라의 초기 좌표에 위치해 있습니다.
//   void setPosition(LatLng position) {
//     _channel?.invokeMockMethod('LO#set#position', {
//       'position': position.toJson(),
//     });
//   }

//   /// __setBearing__ 을 이용하면 위치 오버레이의 베어링을 변경할 수 있습니다.
//   /// flat이 true인 마커의 andgle속성과 유사하게 아이콘이 지도를 기준으로 회전합니다.
//   /// > ***0.0은 정북쪽을 의미합니다.***
//   ///
//   /// 다음은 위치 오버레이의 베어링을 동쪽으로 변경하는 예제입니다.
//   /// ```
//   /// locaionOverlay.setBearing(90.0);
//   /// ```
//   void setBearing(double bearing) {
//     _channel?.invokeMockMethod('LO#set#bearing', {'bearing': bearing});
//   }
// }

// extension MethodChannelMock on MethodChannel {
//   Future<T?> invokeMockMethod<T>(String method, [dynamic arguments]) async {
//     const codec = StandardMethodCodec();
//     final data = codec.encodeMethodCall(MethodCall(method, arguments));

//     print(method);

//     return null

//     // return null as T;

//     // return ServicesBinding.instance.defaultBinaryMessenger
//     //     .handlePlatformMessage(
//     //   name,
//     //   data,
//     //   (ByteData? data) {},
//     // );
//   }
// }
