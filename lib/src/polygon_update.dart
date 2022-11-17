part of flutter_naver_map;

class _PolygonOverlayUpdate extends Equatable {
  _PolygonOverlayUpdate.from(
    Set<PolygonOverlay>? previous,
    Set<PolygonOverlay>? current,
  ) {
    previous ??= Set.identity();
    current ??= Set.identity();

    final prevPolygon = _keyByPolygonId(previous);
    final currentPolygon = _keyByPolygonId(current);

    final prevPolygonIds = prevPolygon.keys.toSet();
    final currentPolygonIds = currentPolygon.keys.toSet();

    PolygonOverlay? idToCurrentPolygon(String id) => currentPolygon[id];

    final polygonIdToRemove_ = prevPolygonIds.difference(currentPolygonIds);

    bool hasChanged(PolygonOverlay? current) =>
        current != prevPolygon[current!.polygonOverlayId];

    final polygonToChange_ = currentPolygonIds
        .intersection(prevPolygonIds)
        .map(idToCurrentPolygon)
        .where(hasChanged)
        .toSet();

    final polygonToAdd_ = currentPolygonIds
        .difference(prevPolygonIds)
        .map(idToCurrentPolygon)
        .toSet();

    _polygonToAdd = polygonToAdd_;
    _idToRemove = polygonIdToRemove_;
    _polygonToChange = polygonToChange_;
  }
  late final Set<PolygonOverlay?>? _polygonToAdd;
  late final Set<String>? _idToRemove;
  late final Set<PolygonOverlay?>? _polygonToChange;

  Map<String, dynamic> _toMap() {
    final updateMap = <String, dynamic>{};
    void addIfNonNull(String fieldName, dynamic value) {
      if (value != null) {
        updateMap[fieldName] = value;
      }
    }

    addIfNonNull('polygonToAdd', _serializePolygonSet(_polygonToAdd));
    addIfNonNull('polygonToChange', _serializePolygonSet(_polygonToChange));
    addIfNonNull(
      'polygonToRemove',
      _idToRemove!.map((e) => e).toList(),
    );
    return updateMap;
  }

  @override
  String toString() {
    return '_PolygonOverlayUpdates{polygonToAdd: $_polygonToAdd, '
        'polygonIdsToRemove: $_idToRemove, '
        'polygonToChange: $_polygonToChange}';
  }

  @override
  List<Object?> get props => [_polygonToAdd, _polygonToChange, _idToRemove];
}
