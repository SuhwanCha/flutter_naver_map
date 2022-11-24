part of flutter_naver_map;

@JsonSerializable()
class NaverMapOptions {
  const NaverMapOptions({
    this.mapType = MapType.basic,
    this.initialCameraPosition,
    this.initLocationTrackingMode = LocationTrackingMode.noFollow,
    this.liteModeEnabled = false,
    this.indoorEnabled = false,
    this.nightModeEnabled = false,
    this.layers = const [MapLayer.building],
    this.buildingHeight = 1,
    this.symbolScale = 1,
    this.symbolPerspectiveRatio = 1.0,
    this.rotateGesturesEnabled = true,
    this.scrollGesturesEnabled = true,
    this.tiltGesturesEnabled = true,
    this.zoomGesturesEnabled = true,
    this.locationButtonEnabled = false,
    this.useSurface = false,
    this.minZoom = 0.0,
    this.maxZoom = 21.0,
    this.logoInteractionEnabled = true,
    this.logoAlign = LogoAlign.bottomLeft,
    this.logoMargin = EdgeInsets.zero,
    this.scaleBarEnabled = true,
  }) : assert(
          nightModeEnabled != true || mapType == MapType.navi,
          'nightModeEnabled can only be set to true when mapType is navi.',
        );

  factory NaverMapOptions.fromJson(Map<String, dynamic> json) =>
      _$NaverMapOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$NaverMapOptionsToJson(this);

  /// Initial camera position of the map.
  /// 카메라의 최초 포지션.
  ///
  /// If this is null, the map will be initialized with a default camera
  /// position of Naver HQ.
  /// It only works when [LocationTrackingMode] is [LocationTrackingMode.none]
  /// or [LocationTrackingMode.noFollow].
  ///
  /// [LocationTrackingMode]가 [LocationTrackingMode.none]이거나
  /// [LocationTrackingMode.noFollow]인 경우에만 반영된디.
  final CameraPosition? initialCameraPosition;

  /// Type of map tiles to be displayed.
  /// 지도 타입 설정.
  ///
  /// Defaults to [MapType.basic].
  @MapTypeConverter()
  final MapType mapType;

  /// Initial location tracking mode of the map.
  /// 최초 지도 생성시에 위치추적모드를 선택할 수 있습니다.
  ///
  /// Default is [LocationTrackingMode.noFollow].
  /// 기본값은 [LocationTrackingMode.noFollow] 입니다.
  @LocationTrackingModeConverter()
  final LocationTrackingMode initLocationTrackingMode;

  /// The liteModeEnabled property enables or disables the lite mode.
  ///
  /// With the lite mode enabled, the map is loaded more quickly and consumes
  /// less memory. A lite mode app, however, has the following limitations:
  ///
  /// The image quality of the map is deteriorated.
  /// - The lite mode is not available on the Navi map type.
  /// - No layer groups are available.
  /// - Indoor maps and night mode are not available.
  /// - Display options cannot be changed.
  /// - When a camera is rotated or tilted, map symbols are also rotated or
  /// tilted.
  /// - When the zoom level becomes bigger or smaller, map symbols somewhat
  /// become bigger or smaller as well.
  /// - Click events for map symbols cannot be handled.
  /// - Overlapping of markers and map symbols cannot be handled.
  ///
  /// ![lite mode](https://navermaps.github.io/android-map-sdk/assets/2-3-lite-true.png)
  /// ![lite mode](https://navermaps.github.io/android-map-sdk/assets/2-3-lite-false.png)
  ///
  /// 이 속성을 사용하면 라이트 모드를 활성화할 수 있습니다.
  /// 기본값은 false입니다.
  /// 라이트 모드가 활성화되면 지도의 로딩이 빨라지고 메모리 소모가 줄어듭니다.
  /// 그러나 다음과 같은 제약이 생깁니다.
  ///
  /// - 지도의 전반적인 화질이 하락합니다.
  /// - Navi 지도 유형을 사용할 수 없습니다.
  /// - 레이어 그룹을 활성화할 수 없습니다.
  /// - 실내지도, 야간 모드를 사용할 수 없습니다.
  /// - 디스플레이 옵션을 변경할 수 없습니다.
  /// - 카메라가 회전하거나 기울어지면 지도 심벌도 함께 회전하거나 기울어집니다.
  /// - 줌 레벨이 커지거나 작아지면 지도 심벌도 일정 정도 함께 커지거나 작아집니다.
  /// - 지도 심벌의 클릭 이벤트를 처리할 수 없습니다.
  /// - 마커와 지도 심벌 간 겹침을 처리할 수 없습니다.
  final bool liteModeEnabled;

  /// Enables or disables the night mode.
  ///
  /// With the night mode enabled, the overall map becomes darker. Note that the
  /// night mode does not have any effect on a map type that does not support
  /// the mode even if it is enabled.
  /// Only the [MapType.navi] type supports the night mode.
  ///
  /// 속성을 사용하면 야간 모드를 활성화할 수 있습니다.
  ///
  /// 야간 모드가 활성화되면 지도의 전반적인 스타일이 어두운 톤으로 변경됩니다. 단, 지도 유형이 야간 모드를 지원하지
  /// 않을 경우 야간 모드를 활성화하더라도 아무런 변화가 일어나지 않습니다.
  /// Navi 지도 유형만이 야간 모드를 지원합니다.
  /// 기본값은 fasle 입니다.
  final bool nightModeEnabled;

  /// Enables or disables an indoor map
  ///
  /// If this property is enabled, the map shows an indoor map for the focused
  /// area when the map is at high zoom levels and the area has an indoor map.
  ///
  /// Note that indoor maps are not displayed on a map type that does not
  /// support them even if they are enabled. Only the [MapType.basic] and
  /// [MapType.terrain] map types support indoor maps.
  final bool indoorEnabled;

  /// Displays layer groups that represent additional information on the
  /// background map.
  ///
  /// Default value is [MapLayer.building].
  final List<MapLayer> layers;

  /// Specifies the height of buildings displayed in three dimensions
  ///
  /// When your map is tilted, buildings on the map are displayed in three
  /// dimensions.
  /// This value can range from `0` to `1`: if the value is set to `0`,
  /// buildings are not displayed in three dimensions even if the map is tilted.
  final double buildingHeight;

  /// Specifies the size of symbols
  ///
  /// This value can range from `0` to `2`: the bigger the value is, the bigger
  /// symbols are
  ///
  /// ![symbol scale](https://navermaps.github.io/android-map-sdk/assets/2-3-symbol-default.png)
  /// ![symbol scale](https://navermaps.github.io/android-map-sdk/assets/2-3-symbol-2.png)
  final double symbolScale;

  /// Specifies the perspective of symbols on your map
  ///
  /// When your map is tilted, closer symbols become bigger while distant
  /// symbols become smaller. This value can range from `0` to `1`: smaller
  /// values decrease perspective, and if the value is 0, no perspective applies
  ///
  /// ![symbol perspective](https://navermaps.github.io/android-map-sdk/assets/2-3-perspective-default.png)
  /// ![symbol perspective](https://navermaps.github.io/android-map-sdk/assets/2-3-perspective-off.png)
  final double symbolPerspectiveRatio;

  /// Enable or disable the gesture of rotate
  final bool rotateGesturesEnabled;

  /// Enable or disable the gesture of scroll
  final bool scrollGesturesEnabled;

  /// Enable or disable the gesture of tilt
  final bool tiltGesturesEnabled;

  /// Enable or disable the gesture of zoom
  final bool zoomGesturesEnabled;

  /// Enable or disable the button of location tracking mode
  final bool locationButtonEnabled;

  /// ## 안드로이드에서 GLSurfaceView 사용 여부
  /// 값이 true인 경우, 안드로이드에서 naver map을 `GLSurfaceView`를 사용해서 렌더링하고,
  /// 반대인 경우 `TextureView`를 사용해서 렌더링한다.
  /// `GLSurfaceView`를 사용할 경우 지도의 속도는 원활해지나, android 기기에서 hot reload시,
  /// naver map SDK 내부 binary 에서 발생하는 에러로 app crash 가 발생한다.
  ///
  /// > 또한 `GLSurfaceView`를 사용하여 지도가 렌더링 되는 동안, [TextField]에 포커스가
  /// 이동하면 app crash가 발생한다. Flutter Engine에서 [TextField]의 변화를 업데이트할 때,
  /// `GLThread`를 사용하는데, 이 과정에서 `DeadObjectException`이 발생한다.
  ///
  /// 만약 `GLSurfaceView`를 사용하는 [NaverMap]가 생성된 상태에서 [TextField]를 사용하지
  /// 않는다면 다음과 같이 사용하면 release mode로 build된 app에서 더 좋은 성능을 기대할 수 있다.
  ///
  /// ```dart
  /// import 'package:flutter/foundation.dart';
  ///
  /// @override
  /// Widget build(BuildContext context) {
  ///   return NaverMap(
  ///     useSurface: kReleaseMode,
  ///   );
  /// }
  /// ```
  ///
  /// - 기본값은 false 이다.
  final bool useSurface;

  /// Minimum zoom level
  final double minZoom;

  /// Maximum zoom level
  final double maxZoom;

  /// Enable logo interaction
  /// default true
  ///
  /// You should implement LegalNotice and OpenSourceLicense to use this
  /// feature.
  /// It's implemented in [NaverMapController], and you can use it like this:
  /// ```dart
  /// widget.controller.future.then((value) => value.showLegalNotice());
  /// widget.controller.future.then((value) => value.showOpenSourceLicense());
  /// ```
  /// 네이버 로고 클릭을 활성화할지 여부를 지정합니다. 활성화하면 네이버 로고 클릭시 범례, 법적 공지,
  /// 오픈소스 라이선스를 보여주는 알림창이 열립니다.
  /// 이 옵션을 NO로 지정하는 앱은 반드시 앱 내에 네이버 지도 SDK의 법적 공지
  /// (-showLegalNotice) 및 오픈소스 라이선스(-showOpenSourceLicense)뷰 컨트롤러를 호출하는
  /// 메뉴를 만들어야 합니다.
  /// 기본값은 YES입니다.
  final bool logoInteractionEnabled;

  /// Alignment of Naver logo
  final LogoAlign logoAlign;

  /// Margin of Naver logo
  @EdgeInsetsConverter()
  final EdgeInsets logoMargin;

  /// 축척바 표시 여부
  /// default true
  final bool scaleBarEnabled;
}
