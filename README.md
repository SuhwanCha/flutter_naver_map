# flutter_naver_map

This package is a Flutter plugin for Naver Map.

Original project is [here](<https://github.com/LBSTECH/naver_map_plugin>), but it is not maintained anymore.
So I forked and fully rewrote it to support latest Flutter and Naver Map SDK and **dart friendly**.

## Getting Started

You need Naver Cloud Platform account to use Naver Map API.

### Common Setup

1. Add `flutter_naver_map` to your `pubspec.yaml` file.

```yaml
dependencies:
  flutter_naver_map: ^1.0.0
```

1. Sign up for a Naver Cloud Platform account and create a new project.

<https://auth.ncloud.com/login/>

1. Issue a new client ID and secret key in [AI/Naver API]

<https://console.ncloud.com/naver-service/application>

- You should enable `Mobile Dynamic Map` API
- Enter your package ID in `Android Package Name` field
- Enter your bundle ID in `iOS Bundle ID` field

You can find your package ID in `build.gradle` file.

```groovy
android {
    compileSdkVersion 28

    defaultConfig {
        applicationId "com.example.naver_map_plugin_example" // <- this
        minSdkVersion 16
        targetSdkVersion 28
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }
}
```

You can find your bundle ID in `Info.plist` file.

```xml
<key>CFBundleIdentifier</key>
<string>com.example.naver_map_plugin_example</string> <!-- <- this -->
```

1. Copy `Client ID`

### Android

1. Add copied `Client ID` to `AndroidManifest.xml` file.

```xml
<manifest>
    <application>
        <meta-data
            android:name="com.naver.maps.map.CLIENT_ID"
            android:value="YOUR_CLIENT_ID" /> <!-- <- this -->
    </application>
</manifest>
```

### iOS

1. Insall git-lfs

If you haven't installed git-lfs, you should install it first.

If you are using Homebrew, you can install it with the following command.

```bash
brew install git-lfs
git lfs install
```

1. Add copied `Client ID` to `Info.plist` file.

```xml
 <key>NMFClientId</key>
 <string>YOUR_CLIENT_KEY</string>
```

## Usage

### Import

```dart
import 'package:flutter_naver_map/flutter_naver_map.dart';
```

### MapView

```dart
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
```

## Known Issues

- Tracking bearing isn't working properly.
