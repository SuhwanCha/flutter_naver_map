part of flutter_naver_map;

/// build 시에 새로운 마커들은 [NaverMap] 에 적용된다.
///
/// [NaverMapController] 에서 마커를 업데이트할 떄 사용된다.
class _MarkerUpdates extends Equatable {
  /// 업데이트 이전의 [Marker]와 새로운 [Marker]를 이용해서
  /// [_MarkerUpdates] 객체를 생성한다.
  _MarkerUpdates.from(Set<Marker>? previous, Set<Marker>? current) {
    previous ??= Set<Marker>.identity();
    current ??= Set<Marker>.identity();

    final previousMarkers = _keyByMarkerId(previous);
    final currentMarkers = _keyByMarkerId(current);

    final prevMarkerIds = previousMarkers.keys.toSet();
    final currentMarkerIds = currentMarkers.keys.toSet();

    Marker? idToCurrentMarker(String id) {
      return currentMarkers[id];
    }

    final markerIdsToRemove = prevMarkerIds.difference(currentMarkerIds);

    final markersToAdd = currentMarkerIds
        .difference(prevMarkerIds)
        .map(idToCurrentMarker)
        .toSet();

    /// 새로운 마커의 아이디가 기존의 것과 다른 경우 true 리턴.
    bool hasChanged(Marker? current) {
      final previous = previousMarkers[current!.markerId];
      return current != previous;
    }

    final markersToChange = currentMarkerIds
        .intersection(prevMarkerIds)
        .map(idToCurrentMarker)
        .where(hasChanged)
        .toSet();

    _markersToAdd = markersToAdd;
    _markerIdsToRemove = markerIdsToRemove;
    _markersToChange = markersToChange;
  }

  late final Set<Marker?>? _markersToAdd;
  late final Set<String>? _markerIdsToRemove;
  late final Set<Marker?>? _markersToChange;

  Map<String, dynamic> _toMap() {
    final updateMap = <String, dynamic>{};

    void addIfNonNull(String fieldName, dynamic value) {
      if (value != null) {
        updateMap[fieldName] = value;
      }
    }

    addIfNonNull('markersToAdd', _serializeMarkerSet(_markersToAdd));
    addIfNonNull('markersToChange', _serializeMarkerSet(_markersToChange));
    addIfNonNull(
      'markerIdsToRemove',
      _markerIdsToRemove!.map<dynamic>((String m) => m).toList(),
    );

    return updateMap;
  }

  @override
  String toString() {
    return '_MarkerUpdates{markersToAdd: $_markersToAdd, '
        'markerIdsToRemove: $_markerIdsToRemove, '
        'markersToChange: $_markersToChange}';
  }

  @override
  List<Object?> get props => [
        _markersToAdd,
        _markerIdsToRemove,
        _markersToChange,
      ];
}
