part of flutter_naver_map;

/// 지도의 유형을 지정하는 enum.
/// 네이버 SDK가 지원하는 지도 유형은 5가지 입니다. [MapType.basic], [MapType.navi],
/// [MapType.satellite], [MapType.hybrid], [MapType.terrain]
enum MapType {
  /// 일반 지도입니다. 하천, 녹지, 도로, 심벌 등 다양한 정보를 노출합니다.
  basic,

  /// 차량용 내비게이션에 특화된 지도입니다.
  navi,

  /// 위성 지도입니다. 심벌, 도로 등 위성 사진을 제외한 요소는 노출되지 않습니다.
  satellite,

  /// 위성 사진과 도로, 심벌을 함께 노출하는 하이브리드 지도입니다.
  hybrid,

  /// 지형도입니다. 산악 지형을 실제 지형과 유사하게 입체적으로 표현합니다.
  terrain,
}

/// 레이어 그룹은 지도 유형과 달리 동시에 두 개 이상을 활성화할 수 있습니다.
/// 단, 지도 유형에 따라 표현 가능한 레이어 그룹이 정해져 있습니다.
/// 지도 유형이 특정 레이어 그룹을 지원하지 않으면 활성화하더라도 해당하는
/// 요소가 노출되지 않습니다. 지도 유형별로 표현할 수 있는 레이어 그룹은 다음과 같습니다.
///
/// -
///
/// 실시간 교통정보 - BASIC, NAVI, SATELLITE, HYBRID, TERRAIN
///
/// 건물 - BASIC, NAVI, HYBRID, TERRAIN
///
/// 대중교통 - BASIC, SATELLITE, HYBRID, TERRAIN
///
/// 자전거 - BASIC, SATELLITE, HYBRID, TERRAIN
///
/// 등산로 - BASIC, SATELLITE, HYBRID, TERRAIN
///
/// 지적편집도 - BASIC, SATELLITE, HYBRID, TERRAIN
enum MapLayer {
  /// Displays buildings
  ///
  /// ![building](https://navermaps.github.io/android-map-sdk/assets/2-3-building.png)
  @JsonValue(0)
  building,

  /// Displays live traffic
  ///
  /// ![traffic](https://navermaps.github.io/android-map-sdk/assets/2-3-traffic.png)
  @JsonValue(1)
  traffic,

  /// Displays public transit elements including trains, subway line maps, and
  /// bus stops
  ///
  /// ![transit](https://navermaps.github.io/android-map-sdk/assets/2-3-transit.png)
  @JsonValue(2)
  transit,

  /// Displays elements associated with bicycles, including bicycle lanes and
  /// bicycle parking spaces
  ///
  /// ![bike](https://navermaps.github.io/android-map-sdk/assets/2-3-bicycle.png)
  @JsonValue(3)
  bicycle,

  /// Displays elements associated with mountain climbing, including trails and
  /// contours
  ///
  /// ![hiking](https://navermaps.github.io/android-map-sdk/assets/2-3-hiking.png)
  @JsonValue(4)
  mountain,

  /// Displays cadastral map
  ///
  /// ![cadastral](https://navermaps.github.io/android-map-sdk/assets/2-3-cadastral.png)
  @JsonValue(5)
  cadastral,
}

/// Alignment of the Naver logo.
enum LogoAlign {
  /// Aligns the logo to the bottom left corner.
  @JsonValue(0)
  bottomLeft,

  /// Aligns the logo to the bottom right corner.
  @JsonValue(1)
  bottomRight,

  /// Aligns the logo to the top left corner.
  @JsonValue(2)
  topLeft,

  /// Aligns the logo to the top right corner.
  @JsonValue(3)
  topRight,
}

/// 카메라 이동 애니메이션 유형을 정의하는 열거형 클래스. CameraUpdate에서 사용합니다.
enum CameraAnimation {
  /// 애니메이션 없이 이동합니다. 기본값입니다.
  none,

  /// 일정한 속도로 이동합니다.
  linear,

  /// 부드럽게 가속하며 이동합니다. 가까운 거리를 이동할 때 적합합니다.
  /// iOS에서만 지원됩니다.
  easeIn,

  /// 부드럽게 가감속하며 이동합니다. 가까운 거리를 이동할 때 적합합니다.
  easing,

  /// 부드럽게 축소됐다가 확대되며 이동합니다. 먼 거리를 이동할 때 적합합니다.
  fly,
}
