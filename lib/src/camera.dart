part of flutter_naver_map;

/// 지도 카에라의 위치를 나타낸다.
/// [target]에서 보이는 카메라 화면은 가진 위,경도와 [zoom]레벨, [tilt]각도,
/// 그리고 [bearing]의 값들을 모두 종합한다.
class CameraPosition extends Equatable {
  const CameraPosition({
    this.bearing = 0.0,
    required this.target,
    this.tilt = 0.0,
    this.zoom = 15.0,
  });

  /// 카메라 회전 각도. 북쪽에서 시계 방향으로의 회전량.
  ///
  /// 기본값은 '0'이고 카메라가 북쪽을 가르킨다.
  /// 90.0이 들어가게 되면 카메라의 상단이 동쪽을 바라본다.
  final double bearing;

  /// 카메라가 가르키는 위치의 위,경도값
  final LatLng target;

  /// 기본값으로 최소값인 0.0을 가진다. 지도의 기울기 값.
  /// 0의 값일때 카메라는 땅을 바로 위에서 바라본다.
  final double tilt;

  /// 기본값으로 0을 가진다.
  /// 지원되는 zoom level 은 장치나 지도 데이터에 따라 다른 범위를 가진다.
  final double zoom;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'bearing': bearing,
        'target': target._toJson(),
        'tilt': tilt,
        'zoom': zoom,
      };

  static CameraPosition? fromMap(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }
    return CameraPosition(
      bearing: json['bearing'] as double,
      target: LatLng._fromJson(json['target'] as List<double>?)!,
      tilt: json['tilt'] as double,
      zoom: json['zoom'] as double,
    );
  }

  @override
  String toString() {
    return 'CameraPosition(bearing: $bearing, target: $target, tilt: $tilt'
        ' zoom: $zoom)';
  }

  @override
  List<Object?> get props => [
        runtimeType,
        bearing,
        target,
        tilt,
        zoom,
      ];
}

/// 카메라의 동적 움직임을 정의한 클래스입니다.
/// 현재 위치로 부터의 온전한 움직임을 지원합니다.
@JsonSerializable()
class CameraUpdate<T extends CameraUpdateOptions> {
  CameraUpdate(
    this.options, {
    this.pivot,
    this.curve = CameraAnimation.none,
    this.duration = Duration.zero,
  }) : assert(
          pivot == null || options is CameraUpdateWithParams,
          "pivot can't be set when using CameraUpdateWithFitBounds",
        ) {
    if (options is CameraUpdateWithParams) {
      type = 'CameraUpdateWithParams';
    } else if (options is CameraUpdateWithFitBounds) {
      type = 'CameraUpdateWithFitBounds';
    }
  }

  // json serialization
  factory CameraUpdate.fromJson(Map<String, dynamic> json) =>
      _$CameraUpdateFromJson(json);

  late final String? type;

  Map<String, dynamic> toJson() => _$CameraUpdateToJson(this);

  @CameraUpdateOptionsConverter()
  final T options;

  /// 피봇 지점. 0, 0일 경우 왼쪽 위, 1, 1일 경우 오른쪽 아래 지점을 의미합니다.
  @OffsetConverter()
  final Offset? pivot;

  /// Animation curve to use when animating the camera.
  ///
  /// Defaults to [CameraAnimation.none].
  @CameraAnimationConverter()
  final CameraAnimation curve;

  /// Animation duration to use when animating the camera.
  ///
  /// Defaults to 0.
  ///
  /// If [curve] is [CameraAnimation.none], this value is ignored.
  /// If [duration] is 0, the animation will be instantaneous.
  @DurationConverter()
  final Duration duration;
}

abstract class CameraUpdateOptions extends Equatable {
  const CameraUpdateOptions();

  factory CameraUpdateOptions.fromJson(_) => const CameraUpdateWithParams();
  Map<String, dynamic> toJson();
}

/// [CameraUpdateOptions] that updates the camera position.
///
///
/// 카메라를 이동할 지점에 관한 다양한 정보를 나타내는 클래스. 주로 NMFCameraUpdate를 만들기 위한 파라미터로 사용됩니다.
///

/// - xxxTo:: 속성을 절대적인 값으로 지정합니다.
/// - xxxBy:: 속성을 현재 지도의 cameraPosition의 상대적인 값으로 지정합니다.
///
/// 동일한 속성에 대해 xxxTo: 계열의 메서드와 xxxBy: 계열의 메서드를 모두 호출하면 앞선 호출은 무시됩니다.
@JsonSerializable()
class CameraUpdateWithParams extends CameraUpdateOptions {
  const CameraUpdateWithParams({
    this.scrollTo,
    this.scrollBy,
    this.zoomTo,
    this.zoomBy,
    this.zoomIn,
    this.zoomOut,
    this.tiltTo,
    this.tiltBy,
    this.rotateTo,
    this.rotateBy,
  })  : assert(
          scrollTo == null || scrollBy == null,
          'scrollTo and scrollBy cannot be set at the same time',
        ),
        assert(
          (zoomTo != null ? 1 : 0) +
                  (zoomBy != null ? 1 : 0) +
                  (zoomIn != null ? 1 : 0) +
                  (zoomOut != null ? 1 : 0) <=
              1,
          'zoomTo, zoomBy, zoomIn, zoomOut cannot be set at the same time',
        ),
        assert(
          tiltTo == null || tiltBy == null,
          'tiltTo and tiltBy cannot be set at the same time',
        ),
        assert(
          rotateTo == null || rotateBy == null,
          'bearingTo and bearingBy cannot be set at the same time',
        );

  // json serialization
  factory CameraUpdateWithParams.fromJson(Map<String, dynamic> json) =>
      _$CameraUpdateWithParamsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CameraUpdateWithParamsToJson(this);

  /// 카메라의 좌표를 target으로 변경하도록 지정합니다.
  @LatLngConverter()
  final LatLng? scrollTo;

  /// 카메라를 현재 위치에서 `delta` pt만큼 이동하도록 지정합니다.
  @OffsetConverter()
  final Offset? scrollBy;

  /// 카메라의 줌을 zoom으로 변경하도록 지정합니다.
  final double? zoomTo;

  /// 카메라의 즘 레벨을 delta만큼 변경하도록 지정합니다. 양수로 지정할 경우 확대, 음수로 지정할 경우 축소됩니다.
  final double? zoomBy;

  /// 카메라의 줌 레벨을 1만큼 증가하도록 지정합니다.
  ///
  /// Eqauals to `zoomBy: 1`
  final bool? zoomIn;

  /// 카메라의 줌 레벨을 1만큼 감소하도록 지정합니다.
  ///
  /// Eqauals to `zoomBy: -1`
  final bool? zoomOut;

  /// 카메라의 기울기 각도를 tilt로 변경하도록 지정합니다.
  final double? tiltTo;

  /// 카메라의 기울기 각도를 delta만큼 변경하도록 지정합니다. 양수로 지정하면 지도가 기울어지고 음수로 지정하면 수직에 가까워집니다.
  final double? tiltBy;

  /// 카메라의 헤딩 각도를 heading으로 변경하도록 지정합니다.
  final double? rotateTo;

  /// 카메라의 헤딩 각도를 delta만큼 변경하도록 지정합니다. 양수로 지정하면 시계방향으로 회전하고 음수로 지정하면 반시계방향으로
  /// 회전합니다.
  final double? rotateBy;

  @override
  List<Object?> get props => [
        scrollTo,
        scrollBy,
        zoomTo,
        zoomBy,
        zoomIn,
        zoomOut,
        tiltTo,
        tiltBy,
        rotateTo,
        rotateBy,
      ];
}

/// bounds가 화면에 온전히 보이는 좌표와 최대 줌 레벨로 카메라의 위치를 변경하는 [CameraUpdate] 객체를 생성합니다.
/// 기울기 각도와 베어링 각도는 0으로 변경되며, 피봇 지점은 무시됩니다.
@JsonSerializable()
class CameraUpdateWithFitBounds extends CameraUpdateOptions {
  const CameraUpdateWithFitBounds({
    required this.bounds,
    this.padding,
  });

  // json serialization
  factory CameraUpdateWithFitBounds.fromJson(Map<String, dynamic> json) =>
      _$CameraUpdateWithFitBoundsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CameraUpdateWithFitBoundsToJson(this);

  /// 카메라로 볼 영역.
  @LatLngBoundsConverter()
  final LatLngBounds bounds;

  /// 카메라가 변경된 후 영역과 지도 화면 간 확보할 최소 여백. pt 단위.
  @EdgeInsetsConverter()
  final EdgeInsets? padding;

  @override
  List<Object?> get props => [bounds, padding];
}

/// ## 카메라의 변경 원인
/// [NaverMap]의 onCameraChange 의 인자로 전달되는 값으로, 카메라가 움직이는 원인을 의미한다.
/// 각각의 값은 다음과 같은 의미를 가진다.
/// - [CameraChangeReason.developer]
///     - 개발자가 API를 호출해 카메라가 움직였음을 나타낸다. (기본값)
/// - [CameraChangeReason.gesture]
///     - 사용자의 제스처로 인해 카메라가 움직였음을 나타낸다.
/// - [CameraChangeReason.control]
///     - 사용자의 버튼 선택으로 인해 카메라가 움직였음을 나타낸다.
/// - [CameraChangeReason.location]
///     - 위치 트래킹 기능으로 인해 카메라가 움직였음을 나타낸다.
enum CameraChangeReason {
  /// 개발자가 API를 호출해 카메라가 움직였음을 나타낸다. (기본값)
  developer,

  /// 사용자의 제스처로 인해 카메라가 움직였음을 나타낸다.
  gesture,

  /// 사용자의 버튼 선택으로 인해 카메라가 움직였음을 나타낸다.
  control,

  /// 위치 트래킹 기능으로 인해 카메라가 움직였음을 나타낸다.
  location,
}
