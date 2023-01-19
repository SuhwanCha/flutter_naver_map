import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class PathExample extends StatelessWidget {
  const PathExample({super.key});

  @override
  Widget build(BuildContext context) {
    final naverMapController = NaverMapController();
    return Column(
      children: [
        Expanded(
          child: NaverMap(
            controller: naverMapController,
            options: const NaverMapOptions(
              initialCameraPosition: CameraPosition(
                target: LatLng(37.5666102, 126.9753881),
              ),
            ),
            pathOverlays: <PathOverlay>{
              PathOverlay(
                const PathOverlayId('1'),
                const <LatLng>[
                  LatLng(37.5656102, 126.9783881),
                  LatLng(37.5666102, 126.9783881),
                  LatLng(37.5676102, 126.9793881),
                  LatLng(37.5686102, 126.9793881),
                ],
                color: Colors.red,
                outlineColor: Colors.red,
                outlineWidth: 3,
              ),
              PathOverlay(
                const PathOverlayId('2'),
                const <LatLng>[
                  LatLng(37.5666102, 126.9753881),
                  LatLng(37.5656102, 126.9763881),
                  LatLng(37.5656102, 126.9773881),
                  LatLng(37.5666102, 126.9783881),
                ],
                color: Colors.blue,
                outlineColor: Colors.blue,
                outlineWidth: 3,
              ),
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            naverMapController.updatePaths([
              PathOverlay(
                const PathOverlayId('2'),
                const <LatLng>[
                  LatLng(37.5766102, 126.9753881),
                  LatLng(37.5756102, 126.9763881),
                  LatLng(37.5756102, 126.9773881),
                  LatLng(37.5766102, 126.9783881),
                ],
                color: Colors.amber,
                outlineColor: Colors.amber,
                outlineWidth: 3,
              )
            ]);
          },
          child: const Text('Add Path'),
        ),
      ],
    );
  }
}
