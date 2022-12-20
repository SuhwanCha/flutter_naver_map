import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class PathExample extends StatefulWidget {
  const PathExample({super.key});

  @override
  State<PathExample> createState() => _PathExampleState();
}

class _PathExampleState extends State<PathExample> {
  List<PolygonOverlay> polygon = <PolygonOverlay>[];

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('assets/TL_SCCO_SIG.json')
        .then((data) {
      final jsonResult = jsonDecode(data) as Map<String, dynamic>;
      final features = jsonResult['features'] as List<dynamic>;
      for (final element in features) {
        polygon.add(
          PolygonOverlay(
            ((element as Map<String, dynamic>)['properties']
                as Map<String, dynamic>)['SIG_CD'] as String,
            (((element['geometry'] as Map<String, dynamic>)['coordinates']
                    as List<dynamic>)[0] as List<dynamic>)
                .map(
                  (e) =>
                      LatLng((e as List<dynamic>)[1] as double, e[0] as double),
                )
                .toList(),
            outlineColor: Colors.indigoAccent,
            outlineWidth: 6,
            color: Colors.black54,
          ),
        );
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = NaverMapController();
    return NaverMap(
      controller: controller,
      options: const NaverMapOptions(
        layers: [],
        initialCameraPosition: CameraPosition(
          target: LatLng(37.56823358823172, 126.9838688358965),
          zoom: 16,
        ),
        // mapType: MapType.navi,
        // nightModeEnabled: true,
      ),
      polygons: polygon,
    );
  }
}
