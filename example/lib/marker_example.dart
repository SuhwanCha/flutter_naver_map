import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class MarkerExample extends StatelessWidget {
  const MarkerExample({super.key});

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
      ),
      markers: [
        Marker(
          id: '1',
          position: const LatLng(37.52504866440145, 127.03169168035946),
          iconTintColor: Colors.blue,
          opacity: 0.5,
          flatten: true,
          onTap: (marker, iconSize) => print('marker tapped'),
          captionText: 'caption Text',
          captionTextSize: 30,
          captionStrokeColor: Colors.red,
          size: const Size(50, 50),
          maxZoom: 16,
          minZoom: 5,
          angle: 30,
          anchor: const AnchorPoint(0.1, 0.1),
          captionMaxWidth: 5,
          captionMaxZoom: 16,
          captionMinZoom: 5,
          captionOffset: 30,
          captionPerspectiveEnabled: true,
          zIndex: 5,
          globalZIndex: 5,
          subCaptionText: 'sub Caption Text',
          subCaptionTextSize: 30,
          subCaptionColor: Colors.yellow,
          subCaptionStrokeColor: Colors.black,
          subCaptionMaxWidth: 5,
        ),
      ],
    );
  }
}
