import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class PolygomExample extends StatefulWidget {
  const PolygomExample({super.key});

  @override
  State<PolygomExample> createState() => _PolygomExampleState();
}

class _PolygomExampleState extends State<PolygomExample> {
  List<PolygonOverlay> polygon = <PolygonOverlay>[];

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('assets/TL_SCCO_SIG.json')
        .then((data) {
      var i = 0;
      final jsonResult = jsonDecode(data) as Map<String, dynamic>;
      final features = jsonResult['features'] as List<dynamic>;
      for (final element in features) {
        element as Map<String, dynamic>;

        final geometry = element['geometry'] as Map<String, dynamic>;

        final coords = geometry['coordinates'] as List<dynamic>;

        for (final elem in coords) {
          polygon.add(
            PolygonOverlay(
              // (element['properties'] as Map<String, dynamic>)['SIG_ENG_NM']
              //     as String,
              '${i++}',
              (elem as List<dynamic>)
                  .map(
                    (e) => LatLng(
                      (e as List<dynamic>)[1] as double,
                      e[0] as double,
                    ),
                  )
                  .toList(),
              outlineColor: Colors.indigoAccent,
              outlineWidth: 3,
              color: Colors.white.withOpacity(0.2),
            ),
          );
        }
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = NaverMapController();
    return NaverMap(
      controller: controller,
      options: NaverMapOptions(
        layers: [],
        initialCameraPosition: const CameraPosition(
          target: LatLng(37.56823358823172, 126.9838688358965),
          zoom: 6,
        ),
        mapType: MapType.navi,
        nightModeEnabled: true,
      ),
      polygons: polygon,
    );
  }
}
