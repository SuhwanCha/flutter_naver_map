//
//  JsonConversion.swift
//  naver_map_plugin
//
//  Created by Maximilian on 2020/08/20.
//

import Foundation
import NMapsMap
import Flutter

public func toLatLng(json: Any) -> NMGLatLng{
    let data = json as! Array<Double>
    return NMGLatLng(lat: data[0], lng: data[1])
}

public func toLatLngBounds(json: Any) -> NMGLatLngBounds{
    let data = json as! Array<Any>
    return NMGLatLngBounds(southWest: toLatLng(json: data[0]), northEast: toLatLng(json: data[1]))
}

public func toCameraPosition(json: Any) -> NMFCameraPosition{
    let data = json as! NSDictionary
    return NMFCameraPosition(toLatLng(json: data["target"]!),
                             zoom: data["zoom"] as! Double,
                             tilt: data["tilt"] as! Double,
                             heading: data["bearing"] as! Double)
}

public func withParams(json: Any) -> NMFCameraUpdate{
    let data = json as! NSDictionary
    var cameraUpdate: NMFCameraUpdate?
    var cameraUpdateParams: NMFCameraUpdateParams

    cameraUpdateParams = .init()


    if let scrollTo = data["scrollTo"] as? Array<Double>{
        cameraUpdateParams.scroll(to: toLatLng(json: scrollTo));
    }

    if let scrollBy = data["scrollBy"] as? Array<Double> {
        cameraUpdateParams.scroll(by: CGPoint(x: scrollBy[0], y: scrollBy[1]));
        // cameraUpdateParams?.scrollBy = CGPoint(x: scrollBy[0], y: scrollBy[1])
    }

    if let zoomTo = data["zoomTo"] as? Double {
        cameraUpdateParams.zoom(to: zoomTo as! Double);
    }

    if let zoomBy = data["zoomBy"] as? Double {
        cameraUpdateParams.zoom(by: zoomBy as! Double);
    }

    if let zoomIn = data["zoomIn"] as? Bool{
        cameraUpdateParams.zoomIn();
    }

    if let zoomOut = data["zoomOut"] as? Bool{
        cameraUpdateParams.zoomOut();
    }

    if let tiltTo = data["tiltTo"] as? Double {
        cameraUpdateParams.tilt(to: tiltTo as! Double);
    }

    if let tiltBy = data["tiltBy"] as? Double {
        cameraUpdateParams.tilt(by: tiltBy as! Double);
    }

    if let rotateTo = data["rotateTo"] as? Double {
        cameraUpdateParams.rotate(to: rotateTo as! Double);
    }

    if let rotateBy = data["rotateBy"] as? Double {
        cameraUpdateParams.rotate(by: rotateBy as! Double);
    }

    return NMFCameraUpdate(params: cameraUpdateParams)
}

public func toCameraUpdate(json: Any) -> NMFCameraUpdate{
    let data = json as! NSDictionary
    print(data)
    var cameraUpdate: NMFCameraUpdate?

    if let type = data["type"] as? String {
        let options = data["options"] as! NSDictionary

        if(type == "CameraUpdateWithParams"){
            cameraUpdate = withParams(json: options)
        } else if (type == "CameraUpdateWithFitBounds"){
            let bounds = options["bounds"] as! Array<Any>
            if let padding = options["padding"] as? Array<CGFloat> {
                cameraUpdate = NMFCameraUpdate(fit: toLatLngBounds(json: bounds), 
                    paddingInsets: UIEdgeInsets(top: padding[1], left: padding[0], bottom: padding[3], right: padding[2]))
            } else {
                cameraUpdate = NMFCameraUpdate(fit: toLatLngBounds(json: bounds))
            }

        }
    }

    
    // if let fitBounds = data["fitBounds"] as? Array<Any>{
    //     let pt = fitBounds[1] as! Int
    //     cameraUpdate = .init(fit: toLatLngBounds(json: fitBounds[0] as Any), padding: CGFloat(pt))
    // }

    if let animation = data["curve"] as? UInt {
        cameraUpdate?.animation = NMFCameraUpdateAnimation(rawValue: animation)!
    }

    if let duration = data["duration"] as? Double {
        cameraUpdate?.animationDuration = duration / 1000
    }

    // cameraUpdate?.animation = .easeOut
    // cameraUpdate?.animationDuration = data["duration"] as? Double ?? 0.0

    return cameraUpdate ?? NMFCameraUpdate()
}

public func toColor(colorNumber: NSNumber) -> UIColor {
    let value = colorNumber.uint64Value
    let red = CGFloat(exactly: (value & 0xFF0000) >> 16)! / 255.0
    let green = CGFloat(exactly: (value & 0xFF00) >> 8)! / 255.0
    let blue = CGFloat(exactly: (value & 0xFF))! / 255.0
    let alpha = CGFloat(exactly: (value & 0xFF000000) >> 24)! / 255.0
    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
}

public func ptFromPx(_ px: NSNumber) -> CGFloat {
    let resolutionFactor = UIScreen.main.nativeBounds.width / UIScreen.main.bounds.width
    return CGFloat(truncating: px) / resolutionFactor
}

public func pxFromPt(_ pt: CGFloat) -> Int {
    let resolutionFactor = UIScreen.main.nativeBounds.width / UIScreen.main.bounds.width
    return Int(pt * resolutionFactor)
}

public func toOverlayImage(assetName: String, registrar: FlutterPluginRegistrar) -> NMFOverlayImage? {
    let assetPath = registrar.lookupKey(forAsset: assetName)
    return NMFOverlayImage(name: assetPath)
}

// ============================= 객체를 json 으로 =================================


public func cameraPositionToJson(position: NMFCameraPosition) -> Dictionary<String, Any>{
    return [
        "tilt" : position.tilt,
        "target" : latlngToJson(latlng: position.target),
        "bearing" : position.heading,
        "zoom" : position.zoom
    ]
}

public func latlngToJson(latlng: NMGLatLng) -> Array<Double> {
    return [latlng.lat, latlng.lng]
}

public func latlngBoundToJson(bound: NMGLatLngBounds) -> Dictionary<String, Any>{
    return [
        "southwest" : latlngToJson(latlng: bound.southWest),
        "northeast" : latlngToJson(latlng: bound.northEast)
    ]
}

