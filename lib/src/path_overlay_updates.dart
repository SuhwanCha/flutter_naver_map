part of flutter_naver_map;

/// [PathOverlay] update events to be applied to the [NaverMap].
///
/// Used in [NaverMapController] when the map is updated.
class _PathOverlayUpdates extends Equatable {
  _PathOverlayUpdates.from(
    Set<PathOverlay>? previous,
    Set<PathOverlay>? current,
  ) {
    previous ??= Set<PathOverlay>.identity();
    current ??= Set<PathOverlay>.identity();

    final previousPathOverlays = _keyByPathOverlayId(previous);
    final currentPathOverlays = _keyByPathOverlayId(current);

    final prevPathOverlayIds = previousPathOverlays.keys.toSet();
    final currentPathOverlayIds = currentPathOverlays.keys.toSet();

    PathOverlay? idToCurrentPolylineOverlay(PathOverlayId id) {
      return currentPathOverlays[id];
    }

    final pathOverlayIdsToRemove =
        prevPathOverlayIds.difference(currentPathOverlayIds);

    final pathOverlaysToAddOrModify =
        currentPathOverlayIds.map(idToCurrentPolylineOverlay).toSet();

    _pathOverlaysToAddOrUpdate = pathOverlaysToAddOrModify;
    _pathOverlayIdsToRemove = pathOverlayIdsToRemove;
  }
  late final Set<PathOverlay?>? _pathOverlaysToAddOrUpdate;
  late final Set<PathOverlayId>? _pathOverlayIdsToRemove;

  Map<String, dynamic> _toMap() {
    final updateMap = <String, dynamic>{};

    void addIfNonNull(String fieldName, dynamic value) {
      if (value != null) {
        updateMap[fieldName] = value;
      }
    }

    addIfNonNull(
      'pathToAddOrUpdate',
      _serializePathOverlaySet(_pathOverlaysToAddOrUpdate),
    );
    addIfNonNull(
      'pathIdsToRemove',
      _pathOverlayIdsToRemove!
          .map<dynamic>((PathOverlayId m) => m.value)
          .toList(),
    );

    return updateMap;
  }

  @override
  String toString() {
    return '_PolylineUpdates{pathToAddOrUpdate: $_pathOverlaysToAddOrUpdate, '
        'pathIdsToRemove: $_pathOverlayIdsToRemove';
  }

  @override
  List<Object?> get props => [
        _pathOverlaysToAddOrUpdate,
        _pathOverlayIdsToRemove,
      ];
}
