# flutter_naver_map

## Please Note

**This project is not published yet.**

This package is a Flutter plugin for Naver Map.

Original project is [here](<https://github.com/LBSTECH/naver_map_plugin>), but it is not maintained anymore. There are a lot of bugs, typo, and deprecated code.

So I forked and **fully rewrote** it to support latest Flutter and Naver Map SDK and **dart friendly**.

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
![Screenshot 2022-11-25 at 6 12 29 PM](https://user-images.githubusercontent.com/16171447/203960360-0003da6f-185b-4931-b642-4dd07e29a75b.png)

1. Issue a new client ID and secret key in [AI/Naver API]

<https://console.ncloud.com/naver-service/application>
![Screenshot 2022-11-25 at 6 14 10 PM](https://user-images.githubusercontent.com/16171447/203960450-75c17cec-204e-4bf2-aff6-96b2b623c502.png)

- You should enable `Mobile Dynamic Map` API
- Enter your package ID in `Android Package Name` field
- Enter your bundle ID in `iOS Bundle ID` field

![Screenshot 2022-11-25 at 6 15 18 PM](https://user-images.githubusercontent.com/16171447/203960543-b28abc7a-edd9-4a6e-ba44-1aed2553321e.png)

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

or you can find it in XCode

![Screenshot 2022-11-25 at 6 43 51 PM](https://user-images.githubusercontent.com/16171447/203960991-8df1ee9d-1f77-4cc2-a968-9c45f5550966.png)

1. Copy `Client ID`

![Screenshot 2022-11-25 at 6 22 13 PM](https://user-images.githubusercontent.com/16171447/203961030-ca512112-2179-4633-b4c1-9239b095c9d4.png)

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

1. compileSdkVersion should be 33 or higher.

```groovy
android {
    compileSdkVersion 33
}
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
