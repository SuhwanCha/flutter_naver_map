// GENERATED CODE - DO NOT MODIFY BY HAND

part of flutter_naver_map;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CameraPosition _$CameraPositionFromJson(Map<String, dynamic> json) =>
    CameraPosition(
      target: LatLng.fromJson((json['target'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList()),
      bearing: (json['bearing'] as num?)?.toDouble() ?? 0.0,
      tilt: (json['tilt'] as num?)?.toDouble() ?? 0.0,
      zoom: (json['zoom'] as num?)?.toDouble() ?? 15.0,
    );

Map<String, dynamic> _$CameraPositionToJson(CameraPosition instance) =>
    <String, dynamic>{
      'bearing': instance.bearing,
      'target': instance.target,
      'tilt': instance.tilt,
      'zoom': instance.zoom,
    };

CameraUpdate<T> _$CameraUpdateFromJson<T extends AbstractCameraUpdateOptions>(
        Map<String, dynamic> json) =>
    CameraUpdate<T>(
      options: CameraUpdateOptionsConverter<T>()
          .fromJson(json['options'] as Map<String, dynamic>),
      pivot: _$JsonConverterFromJson<List<double>, Offset>(
          json['pivot'], const OffsetConverter().fromJson),
      curve: json['curve'] == null
          ? CameraAnimation.none
          : const CameraAnimationConverter().fromJson(json['curve'] as int),
      duration: json['duration'] == null
          ? Duration.zero
          : const DurationConverter().fromJson(json['duration'] as int),
    )..type = json['type'] as String?;

Map<String, dynamic>
    _$CameraUpdateToJson<T extends AbstractCameraUpdateOptions>(
            CameraUpdate<T> instance) =>
        <String, dynamic>{
          'type': instance.type,
          'options': CameraUpdateOptionsConverter<T>().toJson(instance.options),
          'pivot': _$JsonConverterToJson<List<double>, Offset>(
              instance.pivot, const OffsetConverter().toJson),
          'curve': const CameraAnimationConverter().toJson(instance.curve),
          'duration': const DurationConverter().toJson(instance.duration),
        };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

CameraUpdateOptions _$CameraUpdateOptionsFromJson(Map<String, dynamic> json) =>
    CameraUpdateOptions(
      position: _$JsonConverterFromJson<List<double>, LatLng>(
          json['scrollTo'], const LatLngConverter().fromJson),
      scrollBy: _$JsonConverterFromJson<List<double>, Offset>(
          json['scrollBy'], const OffsetConverter().fromJson),
      zoom: (json['zoomTo'] as num?)?.toDouble(),
      zoomBy: (json['zoomBy'] as num?)?.toDouble(),
      zoomIn: json['zoomIn'] as bool?,
      zoomOut: json['zoomOut'] as bool?,
      tilt: (json['tiltTo'] as num?)?.toDouble(),
      tiltBy: (json['tiltBy'] as num?)?.toDouble(),
      rotate: (json['rotateTo'] as num?)?.toDouble(),
      rotateBy: (json['rotateBy'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CameraUpdateOptionsToJson(
        CameraUpdateOptions instance) =>
    <String, dynamic>{
      'scrollTo': _$JsonConverterToJson<List<double>, LatLng>(
          instance.position, const LatLngConverter().toJson),
      'scrollBy': _$JsonConverterToJson<List<double>, Offset>(
          instance.scrollBy, const OffsetConverter().toJson),
      'zoomTo': instance.zoom,
      'zoomBy': instance.zoomBy,
      'zoomIn': instance.zoomIn,
      'zoomOut': instance.zoomOut,
      'tiltTo': instance.tilt,
      'tiltBy': instance.tiltBy,
      'rotateTo': instance.rotate,
      'rotateBy': instance.rotateBy,
    };

CameraUpdateFitBounds _$CameraUpdateFitBoundsFromJson(
        Map<String, dynamic> json) =>
    CameraUpdateFitBounds(
      bounds: const LatLngBoundsConverter()
          .fromJson(json['bounds'] as List<List<double>>),
      padding: _$JsonConverterFromJson<List<double>, EdgeInsets>(
          json['padding'], const EdgeInsetsConverter().fromJson),
    );

Map<String, dynamic> _$CameraUpdateFitBoundsToJson(
        CameraUpdateFitBounds instance) =>
    <String, dynamic>{
      'bounds': const LatLngBoundsConverter().toJson(instance.bounds),
      'padding': _$JsonConverterToJson<List<double>, EdgeInsets>(
          instance.padding, const EdgeInsetsConverter().toJson),
    };

NaverMapOptions _$NaverMapOptionsFromJson(Map<String, dynamic> json) =>
    NaverMapOptions(
      mapType: json['mapType'] == null
          ? MapType.basic
          : const MapTypeConverter().fromJson(json['mapType'] as int),
      initialCameraPosition: json['initialCameraPosition'] == null
          ? null
          : CameraPosition.fromJson(
              json['initialCameraPosition'] as Map<String, dynamic>),
      initLocationTrackingMode: json['initLocationTrackingMode'] == null
          ? LocationTrackingMode.noFollow
          : const LocationTrackingModeConverter()
              .fromJson(json['initLocationTrackingMode'] as int),
      liteModeEnabled: json['liteModeEnabled'] as bool? ?? false,
      indoorEnabled: json['indoorEnabled'] as bool? ?? false,
      nightModeEnabled: json['nightModeEnabled'] as bool? ?? false,
      layers: (json['layers'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$MapLayerEnumMap, e))
              .toList() ??
          const [MapLayer.building],
      buildingHeight: (json['buildingHeight'] as num?)?.toDouble() ?? 1,
      symbolScale: (json['symbolScale'] as num?)?.toDouble() ?? 1,
      symbolPerspectiveRatio:
          (json['symbolPerspectiveRatio'] as num?)?.toDouble() ?? 1.0,
      rotateGesturesEnabled: json['rotateGesturesEnabled'] as bool? ?? true,
      scrollGesturesEnabled: json['scrollGesturesEnabled'] as bool? ?? true,
      tiltGesturesEnabled: json['tiltGesturesEnabled'] as bool? ?? true,
      zoomGesturesEnabled: json['zoomGesturesEnabled'] as bool? ?? true,
      locationButtonEnabled: json['locationButtonEnabled'] as bool? ?? false,
      useSurface: json['useSurface'] as bool? ?? false,
      minZoom: (json['minZoom'] as num?)?.toDouble() ?? 0.0,
      maxZoom: (json['maxZoom'] as num?)?.toDouble() ?? 21.0,
      logoInteractionEnabled: json['logoInteractionEnabled'] as bool? ?? true,
      logoAlign: $enumDecodeNullable(_$LogoAlignEnumMap, json['logoAlign']) ??
          LogoAlign.bottomLeft,
      logoMargin: json['logoMargin'] == null
          ? EdgeInsets.zero
          : const EdgeInsetsConverter()
              .fromJson(json['logoMargin'] as List<double>),
      scaleBarEnabled: json['scaleBarEnabled'] as bool? ?? true,
    );

Map<String, dynamic> _$NaverMapOptionsToJson(NaverMapOptions instance) =>
    <String, dynamic>{
      'initialCameraPosition': instance.initialCameraPosition,
      'mapType': const MapTypeConverter().toJson(instance.mapType),
      'initLocationTrackingMode': const LocationTrackingModeConverter()
          .toJson(instance.initLocationTrackingMode),
      'liteModeEnabled': instance.liteModeEnabled,
      'nightModeEnabled': instance.nightModeEnabled,
      'indoorEnabled': instance.indoorEnabled,
      'layers': instance.layers.map((e) => _$MapLayerEnumMap[e]!).toList(),
      'buildingHeight': instance.buildingHeight,
      'symbolScale': instance.symbolScale,
      'symbolPerspectiveRatio': instance.symbolPerspectiveRatio,
      'rotateGesturesEnabled': instance.rotateGesturesEnabled,
      'scrollGesturesEnabled': instance.scrollGesturesEnabled,
      'tiltGesturesEnabled': instance.tiltGesturesEnabled,
      'zoomGesturesEnabled': instance.zoomGesturesEnabled,
      'locationButtonEnabled': instance.locationButtonEnabled,
      'useSurface': instance.useSurface,
      'minZoom': instance.minZoom,
      'maxZoom': instance.maxZoom,
      'logoInteractionEnabled': instance.logoInteractionEnabled,
      'logoAlign': _$LogoAlignEnumMap[instance.logoAlign]!,
      'logoMargin': const EdgeInsetsConverter().toJson(instance.logoMargin),
      'scaleBarEnabled': instance.scaleBarEnabled,
    };

const _$MapLayerEnumMap = {
  MapLayer.building: 0,
  MapLayer.traffic: 1,
  MapLayer.transit: 2,
  MapLayer.bicycle: 3,
  MapLayer.mountain: 4,
  MapLayer.cadastral: 5,
};

const _$LogoAlignEnumMap = {
  LogoAlign.bottomLeft: 0,
  LogoAlign.bottomRight: 1,
  LogoAlign.topLeft: 2,
  LogoAlign.topRight: 3,
};
