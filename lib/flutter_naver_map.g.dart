// GENERATED CODE - DO NOT MODIFY BY HAND

part of flutter_naver_map;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CameraUpdate<T> _$CameraUpdateFromJson<T extends CameraUpdateOptions>(
        Map<String, dynamic> json) =>
    CameraUpdate<T>(
      CameraUpdateOptionsConverter<T>()
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

Map<String, dynamic> _$CameraUpdateToJson<T extends CameraUpdateOptions>(
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

CameraUpdateWithParams _$CameraUpdateWithParamsFromJson(
        Map<String, dynamic> json) =>
    CameraUpdateWithParams(
      scrollTo: _$JsonConverterFromJson<List<double>, LatLng>(
          json['scrollTo'], const LatLngConverter().fromJson),
      scrollBy: _$JsonConverterFromJson<List<double>, Offset>(
          json['scrollBy'], const OffsetConverter().fromJson),
      zoomTo: (json['zoomTo'] as num?)?.toDouble(),
      zoomBy: (json['zoomBy'] as num?)?.toDouble(),
      zoomIn: json['zoomIn'] as bool?,
      zoomOut: json['zoomOut'] as bool?,
      tiltTo: (json['tiltTo'] as num?)?.toDouble(),
      tiltBy: (json['tiltBy'] as num?)?.toDouble(),
      rotateTo: (json['rotateTo'] as num?)?.toDouble(),
      rotateBy: (json['rotateBy'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CameraUpdateWithParamsToJson(
        CameraUpdateWithParams instance) =>
    <String, dynamic>{
      'scrollTo': _$JsonConverterToJson<List<double>, LatLng>(
          instance.scrollTo, const LatLngConverter().toJson),
      'scrollBy': _$JsonConverterToJson<List<double>, Offset>(
          instance.scrollBy, const OffsetConverter().toJson),
      'zoomTo': instance.zoomTo,
      'zoomBy': instance.zoomBy,
      'zoomIn': instance.zoomIn,
      'zoomOut': instance.zoomOut,
      'tiltTo': instance.tiltTo,
      'tiltBy': instance.tiltBy,
      'rotateTo': instance.rotateTo,
      'rotateBy': instance.rotateBy,
    };

CameraUpdateWithFitBounds _$CameraUpdateWithFitBoundsFromJson(
        Map<String, dynamic> json) =>
    CameraUpdateWithFitBounds(
      bounds: const LatLngBoundsConverter()
          .fromJson(json['bounds'] as List<List<double>>),
      padding: _$JsonConverterFromJson<List<double>, EdgeInsets>(
          json['padding'], const EdgeInsetsConverter().fromJson),
    );

Map<String, dynamic> _$CameraUpdateWithFitBoundsToJson(
        CameraUpdateWithFitBounds instance) =>
    <String, dynamic>{
      'bounds': const LatLngBoundsConverter().toJson(instance.bounds),
      'padding': _$JsonConverterToJson<List<double>, EdgeInsets>(
          instance.padding, const EdgeInsetsConverter().toJson),
    };
