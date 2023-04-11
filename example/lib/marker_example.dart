import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class MarkerExample extends StatefulWidget {
  const MarkerExample({super.key});

  @override
  State<MarkerExample> createState() => _MarkerExampleState();
}

class _MarkerExampleState extends State<MarkerExample> {
  final _markers = <Marker>[
    Marker(
      id: '1',
      position: const LatLng(37.52504866440145, 127.03169168035946),
      iconTintColor: Colors.blue,
      onTap: (marker, iconSize) => print('marker tapped'),
      captionText: 'caption Text',
      captionStrokeColor: Colors.red,
      captionMaxWidth: 5,
      captionMaxZoom: 16,
      captionMinZoom: 5,
      captionPerspectiveEnabled: true,
      iconPerspectiveEnabled: true,
      zIndex: 5,
      globalZIndex: 5,
      subCaptionText: 'sub Caption Text',
      subCaptionColor: Colors.yellow,
      subCaptionStrokeColor: Colors.black,
      subCaptionMaxWidth: 5,
    ),
  ];
  @override
  void initState() {
    super.initState();

    OverlayImage.fromAssetImage(assetName: 'assets/marker.png').then(
      (value) {
        _markers.add(
          Marker(
            id: '2',
            position: const LatLng(37.51432959113593, 127.03196850678351),
            iconTintColor: Colors.blue,
            onTap: (marker, iconSize) => print('marker tapped'),
            captionText: 'caption Text',
            captionStrokeColor: Colors.red,
            captionMaxWidth: 5,
            captionMaxZoom: 16,
            captionMinZoom: 5,
            captionPerspectiveEnabled: true,
            iconPerspectiveEnabled: true,
            zIndex: 5,
            globalZIndex: 5,
            subCaptionText: 'sub Caption Text',
            subCaptionColor: Colors.yellow,
            subCaptionStrokeColor: Colors.black,
            subCaptionMaxWidth: 5,
          ),
        );
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mapController = NaverMapController();

    return Column(
      children: [
        Expanded(
          child: NaverMap(
            controller: mapController,
            options: const NaverMapOptions(
              initialCameraPosition: CameraPosition(
                target: LatLng(37.52504866440145, 127.03169168035946),
                zoom: 14,
                tilt: 60,
              ),
            ),
            markers: _markers,
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            // remove last marker
            final position = await mapController.getCameraPosition();
            print(position);
          },
          child: const Icon(Icons.ac_unit_sharp),
        )
      ],
    );
  }
}
