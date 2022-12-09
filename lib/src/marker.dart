part of flutter_naver_map;

/// Marker class for [NaverMap].
// @JsonSerializable(explicitToJson: true)
class Marker extends Equatable {
  const Marker({
    required this.id,
    required this.position,
    this.infoWindow,
    this.opacity,
    this.size,
    this.flatten,
    this.onTap,
    this.icon,
    this.captionText,
    this.captionTextSize,
    this.captionColor,
    this.captionStrokeColor,
    this.maxZoom,
    this.minZoom,
    this.angle,
    this.anchor,
    this.captionMaxWidth,
    this.captionMaxZoom,
    this.captionMinZoom,
    this.captionOffset,
    this.captionPerspectiveEnabled,
    this.zIndex,
    this.globalZIndex,
    this.iconTintColor,
    this.subCaptionText,
    this.subCaptionTextSize,
    this.subCaptionColor,
    this.subCaptionStrokeColor,
    this.subCaptionMaxWidth,
  });

  // json serialization
  factory Marker.fromJson(Map<String, dynamic> json) => _$MarkerFromJson(json);

  /// Converts this object to the JSON representation.
  Map<String, dynamic> toJson() => _$MarkerToJson(this);

  /// A unique identifier for a [Marker].
  @JsonKey(name: 'markerId')
  final String id;

  /// Is an overlay that displays additional information over a marker or at a
  /// specified location on the map
  ///
  /// It is usually in the form of a speech bubble displaying text. As the
  /// information to be displayed in an info window is specified by an adapter,
  /// it can be dynamically updated by using the marker at which an info window
  /// will open.
  ///
  /// ![infowindow](https://navermaps.github.io/ios-map-sdk/assets/5-3-open-in-marker.png)
  final String? infoWindow;

  /// Adds a color to an icon image
  ///
  /// The color you specified is (additive-mixed)[https://en.wikipedia.org/wiki/Additive_color] with the color of an icon image.
  /// Note that the alpha of the additive color is ignored and only the alpha of
  /// the icon image color is used.
  @ColorConverter()
  final Color? iconTintColor;

  /// Specifies an icon for the marker.
  // TODO(suhwancha): rename [OverlayImage]
  @JsonKey(ignore: true)
  final OverlayImage? icon;

  /// Specify the size of an icon
  ///
  /// If you do not specify the size, the width or height of the icon is
  /// adjusted to the size of the image.
  ///
  /// Example: `Size(25, 40)`
  /// ![size](https://navermaps.github.io/ios-map-sdk/assets/5-2-resize.png)
  // TODO(suhwancha): implement json converter and prune wid and height
  @SizeConverter()
  final Size? size;

  /// The fraction to scale the marker's alpha value.
  ///
  /// An opacity of 1.0 is fully opaque. An opacity of 0.0 is fully transparent
  /// (i.e., invisible).
  @JsonKey(name: 'alpha')
  final double? opacity;

  /// Whether the marker is flat against the map
  ///
  /// ![flat](https://navermaps.github.io/ios-map-sdk/assets/5-2-flat.png)
  @JsonKey(name: 'flat')
  final bool? flatten;

  /// The point on the icon image that will be placed at the coordinates of the
  /// marker
  ///
  /// An anchor point is a proportion value where the top left is `(0, 0)`, and
  /// the bottom right is `(1, 1)`.
  ///
  /// This property is useful when the default marker image is not used.
  /// For example, if you specify an image that has a tail at the bottom right
  /// as a marker’s icon as shown below, the image points to the bottom right
  /// but the marker is anchored to the map based on the point at the bottom of
  /// the middle of the image, which makes a gap between the coordinates of the
  /// image and those of the marker.
  /// ![anchor](https://navermaps.github.io/ios-map-sdk/assets/5-2-distance.png)
  @AnchorPointConverter()
  final AnchorPoint? anchor;

  /// The angle of the marker in degrees clockwise from north.
  /// The direction is up for 0 degree, right for 90 degrees, and down for 180
  /// degrees.
  ///
  /// Example: `90`
  ///
  /// ![angle](https://navermaps.github.io/ios-map-sdk/assets/5-2-angle.png)
  final double? angle;

  /// Text to be displayed as a caption
  ///
  /// The caption is displayed in a box below the marker icon.
  ///
  /// ![caption](https://navermaps.github.io/ios-map-sdk/assets/5-2-caption.png)
  final String? captionText;

  /// The limit of the width of the caption box
  ///
  ///
  /// If a line of caption text is too long to fit the specified width, it
  /// automatically wraps. Note that if text is written without spaces, it may
  /// not wrap.
  ///
  /// ![caption](https://navermaps.github.io/ios-map-sdk/assets/5-2-caption-width.png)
  @JsonKey(name: 'captionRequestedWidth')
  final double? captionMaxWidth;

  /// The distance between the icon and the caption
  ///
  /// ![caption](https://navermaps.github.io/ios-map-sdk/assets/5-2-offset.png)
  final double? captionOffset;

  /// Called when the marker is tapped.
  ///
  /// The [Marker] that was tapped and the [Size] of the marker icon are passed
  @JsonKey(ignore: true)
  final void Function(Marker? marker, Map<String, int?> iconSize)? onTap;

  /// The color of the caption text
  @ColorConverter()
  final Color? captionColor;

  /// The stroke color of the caption text
  ///
  /// ![caption](https://navermaps.github.io/ios-map-sdk/assets/5-2-color.png)
  @JsonKey(name: 'captionHaloColor')
  @ColorConverter()
  final Color? captionStrokeColor;

  /// Size of the caption text
  final double? captionTextSize;

  /// Position of the marker on the map
  final LatLng position;

  /// Text to be displayed as a subcaption
  ///
  /// {@template subcaption}
  /// Allowing you to specify its text, color and size, separate from the main
  /// caption’s, sub captions are useful to provide addition information.
  ///
  /// Note that the alignment and offset of a sub caption cannot be specified;
  /// it is unconditionally placed beneath the main caption.
  ///
  /// ![caption](https://navermaps.github.io/ios-map-sdk/assets/5-2-sub-caption.png)
  /// {@endtemplate}

  final String? subCaptionText;

  /// The color of the subcaption text
  ///
  /// {@macro subcaption}
  final double? subCaptionTextSize;

  /// The limit of the width of the subcaption box
  ///
  /// If a line of subcaption text is too long to fit the specified width, it
  /// automatically wraps. Note that if text is written without spaces, it may
  /// not wrap.
  ///
  /// {@macro subcaption}
  @JsonKey(name: 'subCaptionRequestedWidth')
  final double? subCaptionMaxWidth;

  /// The color of the subcaption text
  ///
  /// {@macro subcaption}
  @ColorConverter()
  final Color? subCaptionColor;

  /// The stroke color of the subcaption text
  ///
  /// {@macro subcaption}
  @JsonKey(name: 'subCaptionHaloColor')
  @ColorConverter()
  final Color? subCaptionStrokeColor;

  /// 캡션이 보이는 최대 줌 레벨을 지정합니다.
  ///
  ///
  /// 지도의 줌 레벨이 캡션의 최대 줌 레벨보다 클 경우 아이콘만 나타나고
  /// 캡션은 화면에 나타나지 않으며 이벤트도 받지 못합니다.
  final double? captionMaxZoom;

  /// 캡션이 보이는 최소 줌 레벨을 지정합니다.
  ///
  ///
  /// 지도의 줌 레벨이 캡션의 최소 줌 레벨보다 작을 경우 아이콘만 나타나고
  /// 캡션은 화면에 나타나지 않으며 이벤트도 받지 못합니다.
  final double? captionMinZoom;

  /// 오버레이가 보이는 최대, 최소 줌 레벨을 지정합니다. 지도의 줌 레벨이
  /// 오버레이의 최대 줌 레벨보다 크거나 지도의 줌 레벨이 오보레이의
  /// 줌 레벨보다 작은 경우 오버레이는 화면에 나타나지 않으며
  /// 이벤트도 받지 못합니다.
  final double? maxZoom;

  /// 오버레이가 보이는 최대, 최소 줌 레벨을 지정합니다. 지도의 줌 레벨이
  /// 오버레이의 최대 줌 레벨보다 크거나 지도의 줌 레벨이 오보레이의
  /// 줌 레벨보다 작은 경우 오버레이는 화면에 나타나지 않으며
  /// 이벤트도 받지 못합니다.
  final double? minZoom;

  /// 캡션에 원근 효과를 적용할지 여부를 반환합니다.
  /// 원근 효과를 적용할 경우 가까운 캡션은 크게, 먼 캡션은 작게 표시됩니다.
  ///
  ///
  /// 기본값은 false입니다.
  final bool? captionPerspectiveEnabled;

  /// 보조 Z 인덱스를 지정합니다. 전역 Z 인덱스가 동일한 여러 오버레이가 화면에서
  /// 겹쳐지면 보조 Z 인덱스가 큰 오버레이가 작은 오버레이를 덮습니다.
  final int? zIndex;

  /// 전역 Z 인덱스를 지정합니다. 여러 오버레이가 화면에서 겹쳐지면 전역 Z
  /// 인덱스가 큰 오버레이가 작은 오버레이를 덮습니다.
  ///
  /// 또한 값이 0 이상이면 오버레이가 심벌 위에, 0 미만이면 심벌 아래에 그려집니다.
  ///
  ///
  /// 기본값은 DEFAULT_GLOBAL_Z_INDEX입니다
  final int? globalZIndex;

  // Map<String, dynamic> _toJson() {
  //   final json = <String, dynamic>{};

  //   void addIfPresent(String fieldName, dynamic value) {
  //     if (value != null) {
  //       json[fieldName] = value;
  //     }
  //   }

  //   addIfPresent('markerId', id);
  //   addIfPresent('alpha', opacity);
  //   addIfPresent('flat', flatten);
  //   addIfPresent('position', position.toJson());
  //   addIfPresent('captionText', captionText);
  //   addIfPresent('captionTextSize', captionTextSize);
  //   addIfPresent('captionColor', captionColor?.value);
  //   addIfPresent('captionHaloColor', captionStrokeColor?.value);
  //   addIfPresent('maxZoom', maxZoom);
  //   addIfPresent('minZoom', minZoom);
  //   addIfPresent('angle', angle);
  //   addIfPresent('captionRequestedWidth', captionMaxWidth);
  //   addIfPresent('captionMaxZoom', captionMaxZoom);
  //   addIfPresent('captionMinZoom', captionMinZoom);
  //   addIfPresent('captionOffset', captionOffset);
  //   addIfPresent('captionPerspectiveEnabled', captionPerspectiveEnabled);
  //   addIfPresent('zIndex', zIndex);
  //   addIfPresent('globalZIndex', globalZIndex);
  //   addIfPresent('iconTintColor', iconTintColor?.value);
  //   addIfPresent('subCaptionText', subCaptionText);
  //   addIfPresent('subCaptionTextSize', subCaptionTextSize);
  //   addIfPresent('subCaptionColor', subCaptionColor?.value);
  //   addIfPresent('subCaptionHaloColor', subCaptionStrokeColor?.value);
  //   addIfPresent('subCaptionRequestedWidth', subCaptionMaxWidth);
  //   addIfPresent('icon', icon?.key.name);
  //   addIfPresent('infoWindow', infoWindow);
  //   addIfPresent('anchor', anchor?._json);
  //   print(json);
  //   return json;
  // }

  /// 같은 값을 가진 새로운 Maker 객체를 반환한다.
  Marker clone() {
    return Marker(
      position: position,
      id: id,
      opacity: opacity,
      angle: angle,
      captionColor: captionColor,
      captionStrokeColor: captionStrokeColor,
      captionMaxZoom: captionMaxZoom,
      captionMinZoom: captionMinZoom,
      captionOffset: captionOffset,
      captionPerspectiveEnabled: captionPerspectiveEnabled,
      captionMaxWidth: captionMaxWidth,
      captionText: captionText,
      captionTextSize: captionTextSize,
      flatten: flatten,
      globalZIndex: globalZIndex,
      iconTintColor: iconTintColor,
      maxZoom: maxZoom,
      minZoom: minZoom,
      onTap: onTap,
      subCaptionColor: subCaptionColor,
      subCaptionStrokeColor: subCaptionStrokeColor,
      subCaptionMaxWidth: subCaptionMaxWidth,
      subCaptionText: subCaptionText,
      subCaptionTextSize: subCaptionTextSize,
      zIndex: zIndex,
      icon: icon,
      infoWindow: infoWindow,
      anchor: anchor,
    );
  }

  @override
  String toString() {
    return 'Marker{markerId: $id, alpha: $opacity, '
        'flat: $flatten, position: $position, zIndex: $zIndex, '
        'onMarkerTab: $onTap, infowindow : $infoWindow}';
  }

  @override
  List<Object?> get props => [
        id,
        opacity,
        flatten,
        position,
        captionText,
        captionTextSize,
        captionColor,
        captionStrokeColor,
        maxZoom,
        minZoom,
        angle,
        captionMaxWidth,
        captionMaxZoom,
        captionMinZoom,
        captionOffset,
        captionPerspectiveEnabled,
        zIndex,
        globalZIndex,
        iconTintColor,
        subCaptionText,
        subCaptionTextSize,
        subCaptionColor,
        subCaptionStrokeColor,
        subCaptionMaxWidth,
        icon,
        infoWindow,
        anchor,
      ];
}

List<Map<String, dynamic>>? _serializeMarkerSet(Iterable<Marker?>? markers) {
  if (markers == null) {
    return null;
  }
  // return null;
  return markers.map<Map<String, dynamic>>((Marker? m) => m!.toJson()).toList();
}

Map<String, Marker> _keyByMarkerId(Iterable<Marker> markers) {
  return Map<String, Marker>.fromEntries(
    markers.map(
      (Marker marker) => MapEntry<String, Marker>(marker.id, marker.clone()),
    ),
  );
}

/// ## [Marker]의 anchor 속성에 사용되는 클래스.
/// ### 앵커는 아이콘 이미지에서 기준이 되는 지점을 의미하는 값으로, 아이콘에서 앵커로 지정된 지점이 마커의 좌표에 위치하게 됩니다.
/// 앵커로 지정된 지점이 정보창의 좌표에 위치합니다.
/// 값의 범위는 x, y 각각 0 ~ 1 이며, (0,0)일 경우 좌상단, (1,1)일 경우 우츨 하단을 의미합니다.
/// 기본값은 중앙 하단인 (0.5, 1)입니다.
class AnchorPoint extends Equatable {
  /// ### AnchorPoint(x, y)
  /// 첫번째 인자는 포인트의 x축 값,
  /// 두번째 인자는 포인트의 y축 값을 의미한다.
  const AnchorPoint(this.x, this.y)
      : assert(x >= 0 && x <= 1, 'x must be between 0 and 1'),
        assert(y >= 0 && y <= 1, 'y must be between 0 and 1');
  final double x;
  final double y;

  @override
  List<Object?> get props => [
        x,
        y,
      ];
}
