// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class BasicExmaple extends StatelessWidget {
  const BasicExmaple({super.key});

  @override
  Widget build(BuildContext context) {
    final mapController = NaverMapController();
    return Stack(
      children: [
        NaverMap(
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
        ),
        Positioned(
          child: ElevatedButton(
            onPressed: () async {
              await mapController.update(
                NaverMapOptions(
                  layers: [],
                  mapType: MapType.navi,
                  nightModeEnabled: true,
                ),
              );
              // await mapController
              //     .moveCamera(
              //       CameraUpdate(
              //         options: const CameraUpdateOptions(
              //           scrollBy: Offset(500, 500),
              //         ),
              //         curve: CameraAnimation.easing,
              //         duration: const Duration(seconds: 3),
              //       ),
              //     )
              //     .then((value) => print('moveCamera completed'));
            },
            child: const Icon(Icons.ac_unit_sharp),
          ),
        )
      ],
    );
  }
}
