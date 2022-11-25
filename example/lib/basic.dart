import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class BasicExmaple extends StatelessWidget {
  const BasicExmaple({super.key});

  @override
  Widget build(BuildContext context) {
    final mapController = NaverMapController();
    return NaverMap(
      controller: mapController,
      options: const NaverMapOptions(
        initialCameraPosition: CameraPosition(
          target: LatLng(37.52504866440145, 127.03169168035946),
          zoom: 14,
        ),
        layers: [
          MapLayer.building,
          MapLayer.traffic,
        ],
      ),
    );
  }
}
