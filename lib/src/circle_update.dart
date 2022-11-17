part of flutter_naver_map;

// TODO(suhwancha): make this class not immutable.
// ignore: must_be_immutable
class _CircleOverlayUpdate extends Equatable {
  _CircleOverlayUpdate.from(
    Set<CircleOverlay>? previous,
    Set<CircleOverlay>? current,
  ) {
    previous ??= Set<CircleOverlay>.identity();
    current ??= Set<CircleOverlay>.identity();

    final previousCircles = _keyByCircleId(previous);
    final currentCircles = _keyByCircleId(current);

    final prevCircleIds = previousCircles.keys.toSet();
    final currentCirclesIds = currentCircles.keys.toSet();

    CircleOverlay? idToCurrentCircle(String id) => currentCircles[id];

    final circleIdsToRemove = prevCircleIds.difference(currentCirclesIds);

    final circlesToAdd = currentCirclesIds
        .difference(prevCircleIds)
        .map(idToCurrentCircle)
        .toSet();

    bool hasChanged(CircleOverlay? current) =>
        current != previousCircles[current!.overlayId];

    final circlesToChange = currentCirclesIds
        .intersection(prevCircleIds)
        .map(idToCurrentCircle)
        .where(hasChanged)
        .toSet();

    _circlesToAdd = circlesToAdd;
    _circleIdsToRemove = circleIdsToRemove;
    _circlesToChange = circlesToChange;
  }
  Set<CircleOverlay?>? _circlesToAdd;
  Set<String>? _circleIdsToRemove;
  Set<CircleOverlay?>? _circlesToChange;

  Map<String, dynamic> _toMap() {
    final updateMap = <String, dynamic>{};

    void addIfNonNull(String fieldName, dynamic value) {
      if (value != null) {
        updateMap[fieldName] = value;
      }
    }

    addIfNonNull('circlesToAdd', _serializeCircleSet(_circlesToAdd));
    addIfNonNull('circlesToChange', _serializeCircleSet(_circlesToChange));
    addIfNonNull(
      'circleIdsToRemove',
      _circleIdsToRemove!.map((e) => e).toList(),
    );
    return updateMap;
  }

  @override
  String toString() {
    return '_CircleOverlayUpdates{circlesToAdd: $_circlesToAdd, '
        'circleIdsToRemove: $_circleIdsToRemove, '
        'circlesToChange: $_circlesToChange}';
  }

  @override
  List<Object?> get props => [
        _circlesToAdd,
        _circleIdsToRemove,
        _circlesToChange,
      ];
}
