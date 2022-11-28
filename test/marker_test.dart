import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('marker to json', () {
    final markerMap = <String, dynamic>{
      'markerId': '1',
      'alpha': 0.5,
      'flat': true,
      'position': [37.52504866440145, 127.03169168035947],
      'captionText': 'caption Text',
      'infoWindow': 'info Window',
      'captionTextSize': 30.0,
      'captionHaloColor': 4294198070,
      'width': 50,
      'height': 50,
      'maxZoom': 16.0,
      'minZoom': 5.0,
      'angle': 30.0,
      'captionRequestedWidth': 5,
      'captionMaxZoom': 16.0,
      'captionMinZoom': 5.0,
      'captionOffset': 30,
      'captionColor': 4294198070,
      'captionPerspectiveEnabled': true,
      'zIndex': 5,
      'globalZIndex': 5,
      'iconTintColor': 4280391411,
      'subCaptionText': 'sub Caption Text',
      'subCaptionTextSize': 30.0,
      'subCaptionColor': 4294961979,
      'subCaptionHaloColor': 4278190080,
      'subCaptionRequestedWidth': 5,
      'anchor': [0.1, 0.1]
    };

    final marker = Marker(
      id: '1',
      position: const LatLng(37.52504866440145, 127.03169168035946),
      iconTintColor: Colors.blue,
      opacity: 0.5,
      flatten: true,
      size: const Size(50, 50),
      onTap: (marker, iconSize) => print('marker tapped'),
      captionText: 'caption Text',
      captionTextSize: 30,
      captionStrokeColor: Colors.red,
      captionColor: Colors.red,
      maxZoom: 16,
      minZoom: 5,
      angle: 30,
      anchor: const AnchorPoint(0.1, 0.1),
      captionMaxWidth: 5,
      captionMaxZoom: 16,
      captionMinZoom: 5,
      infoWindow: 'info Window',
      captionOffset: 30,
      captionPerspectiveEnabled: true,
      zIndex: 5,
      globalZIndex: 5,
      subCaptionText: 'sub Caption Text',
      subCaptionTextSize: 30,
      subCaptionColor: Colors.yellow,
      subCaptionStrokeColor: Colors.black,
      subCaptionMaxWidth: 5,
    );

    expect(marker.toJson(), markerMap);
  });
}
