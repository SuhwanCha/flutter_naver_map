import Flutter
import UIKit

public class SwiftFlutterNaverMap: NSObject, FlutterPlugin {
    var registrar: FlutterPluginRegistrar?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let naverMapFactory = NaverMapFactory(registrar: registrar)
        registrar.register(naverMapFactory,
                           withId: "flutter_naver_map",
                           gestureRecognizersBlockingPolicy: FlutterPlatformViewGestureRecognizersBlockingPolicyWaitUntilTouchesEnded)
    }
    
}

