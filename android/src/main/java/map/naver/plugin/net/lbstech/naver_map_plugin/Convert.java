package map.naver.plugin.net.lbstech.naver_map_plugin;

import android.annotation.SuppressLint;
import android.graphics.Color;
import android.graphics.PointF;

import com.naver.maps.geometry.LatLng;
import com.naver.maps.geometry.LatLngBounds;
import com.naver.maps.map.CameraAnimation;
import com.naver.maps.map.CameraPosition;
import com.naver.maps.map.CameraUpdate;
import com.naver.maps.map.overlay.OverlayImage;
import com.naver.maps.map.CameraUpdateParams;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.view.FlutterMain;

@SuppressWarnings("rawtypes")
class Convert {

    @SuppressWarnings("ConstantConditions")
    static void carveMapOptions(NaverMapOptionSink sink, Map<String, Object> options) {
        if (options.containsKey("mapType"))
            sink.setMapType((Integer) options.get("mapType"));
        if (options.containsKey("liteModeEnable"))
            sink.setLiteModeEnable((Boolean) options.get("liteModeEnabled"));
        if (options.containsKey("nightModeEnable"))
            sink.setNightModeEnable((Boolean) options.get("nightModeEnabled"));
        if (options.containsKey("indoorEnable"))
            sink.setIndoorEnable((Boolean) options.get("indoorEnabled"));
        if (options.containsKey("buildingHeight"))
            sink.setBuildingHeight((Double) options.get("buildingHeight"));
        if (options.containsKey("symbolScale"))
            sink.setSymbolScale((Double) options.get("symbolScale"));
        if (options.containsKey("symbolPerspectiveRatio"))
            sink.setSymbolPerspectiveRatio((Double) options.get("symbolPerspectiveRatio"));
        if (options.containsKey("activeLayers"))
            sink.setActiveLayers((List) options.get("layers"));
        if (options.containsKey("locationButtonEnable"))
            sink.setLocationButtonEnable((Boolean) options.get("locationButtonEnabled"));
        if (options.containsKey("scrollGestureEnable"))
            sink.setScrollGestureEnable((Boolean) options.get("scrollGestureEnabled"));
        if (options.containsKey("zoomGestureEnable"))
            sink.setZoomGestureEnable((Boolean) options.get("zoomGestureEnabled"));
        if (options.containsKey("rotationGestureEnable"))
            sink.setRotationGestureEnable((Boolean) options.get("rotationGestureEnabled"));
        if (options.containsKey("tiltGestureEnable"))
            sink.setTiltGestureEnable((Boolean) options.get("tiltGestureEnabled"));
        if (options.containsKey("locationButtonEnable"))
            sink.setLocationButtonEnable((Boolean) options.get("locationButtonEnabled"));
        if (options.containsKey("locationTrackingMode"))
            sink.setLocationTrackingMode((Integer) options.get("locationTrackingMode"));
        if (options.containsKey("contentPadding"))
            sink.setContentPadding(toDoubleList(options.get("contentPadding")));
        if (options.containsKey("maxZoom"))
            sink.setMaxZoom((Double) options.get("maxZoom"));
        if (options.containsKey("minZoom"))
            sink.setMinZoom((Double) options.get("minZoom"));
        if(options.containsKey("logoClickEnabled"))
            sink.setLogoClickEnabled((Boolean) options.get("logoClickEnabled"));
        if(options.containsKey("logoMargin"))
            sink.setLogoMargin(toDoubleList(options.get("logoMargin")));
        if(options.containsKey("logoAlign"))
            sink.setLogoGravity((Integer) options.get("logoAlign"));
        if(options.containsKey("scaleBarEnabled"))
            sink.setScaleBarEnabled((Boolean) options.get("scaleBarEnabled"));
    }

    @SuppressWarnings("unchecked")
    static LatLng toLatLng(Object o) {
        final List<Double> data = (List<Double>) o;
        return new LatLng(data.get(0), data.get(1));
    }

    static PointF toPoint(Object o) {
        final List data = (List) o;
        return new PointF(toFloat(data.get(0)), toFloat(data.get(1)));
    }

    static List<Double> toDoubleList(Object o) {
        final List data = (List) o;
        ArrayList<Double> result = new ArrayList<>();
        for (Object element : data) {
            if (element instanceof Double) {
                result.add((Double) element);
            }
        }
        return result;
    }

    private static LatLngBounds toLatLngBounds(Object o) {
        if (o == null) {
            return null;
        }
        final List data = (List) o;
        return new LatLngBounds(toLatLng(data.get(0)), toLatLng(data.get(1)));
    }

    @SuppressLint("Assert")
    static CameraPosition toCameraPosition(Map<String, Object> cameraPositionMap) {
        double bearing, tilt, zoom;
        bearing = (double) cameraPositionMap.get("bearing");
        tilt = (double) cameraPositionMap.get("tilt");
        zoom = (double) cameraPositionMap.get("zoom");

        List target = (List) cameraPositionMap.get("target");
        assert target != null && target.size() == 2;
        double lat = (double) target.get(0);
        double lng = (double) target.get(1);
        return new CameraPosition(new LatLng(lat, lng), zoom, tilt, bearing);
    }

    static CameraUpdateParams withParams(Map<String, Object> options) {
        CameraUpdateParams cameraUpdateParams = new CameraUpdateParams();

        if(options.containsKey("scrollTo") && options.get("scrollTo") != null) {
            cameraUpdateParams.scrollTo(toLatLng(options.get("scrollTo")));
        }

        if(options.containsKey("scrollBy") && options.get("scrollBy") != null) {
            cameraUpdateParams.scrollBy(toPoint(options.get("scrollBy")));
        }
        // if options contains zoomTo and zoomTo is not null
        if(options.containsKey("zoomTo") && options.get("zoomTo") != null) {
            cameraUpdateParams.zoomTo((double) options.get("zoomTo"));
        }

        if(options.containsKey("zoomBy") && options.get("zoomBy") != null) {
            cameraUpdateParams.zoomBy((double) options.get("zoomBy"));
        }

        if(options.containsKey("zoomIn") && options.get("zoomIn") != null) {
            cameraUpdateParams.zoomIn();
        }

        if(options.containsKey("zoomOut") && options.get("zoomOut") != null) {
            cameraUpdateParams.zoomOut();
        }

        if(options.containsKey("tiltBy") && options.get("tiltBy") != null) {
            cameraUpdateParams.tiltBy((double) options.get("tiltBy"));
        }

        if(options.containsKey("tiltTo") && options.get("tiltTo") != null) {
            cameraUpdateParams.tiltTo((double) options.get("tiltTo"));
        }

        if(options.containsKey("rotateBy") && options.get("rotateBy") != null) {
            cameraUpdateParams.rotateBy((double) options.get("rotateBy"));
        }

        if(options.containsKey("rotateTo") && options.get("rotateTo") != null) {
            cameraUpdateParams.rotateTo((double) options.get("rotateTo"));
        }

        return cameraUpdateParams;
    }

    @SuppressWarnings("unchecked")
    static CameraUpdate toCameraUpdate(Object o, float density) {

        Map<String, Object> map = (HashMap<String, Object>) o;
        CameraUpdate cameraUpdate = null;

        if (map.isEmpty())
            throw new IllegalArgumentException("Cannot interpret " + o + " as CameraUpdate");

        String type = (String) map.get("type");
        if (type.equals("CameraUpdateWithParams")) {
            Map<String, Object> options = (Map<String, Object>) map.get("options");
            cameraUpdate = CameraUpdate.withParams(Convert.withParams(options));
        } else if (type.equals("CameraUpdateWithFitBounds")) {
            Map<String, Object> options = (Map<String, Object>) map.get("options");
            List fitBounds = (List) options.get("bounds");
            if (fitBounds != null) {
                cameraUpdate = CameraUpdate.fitBounds(toLatLngBounds(fitBounds));
            }

            List padding = (List) options.get("padding");
            if (padding != null) {
                int left = Math.round(Convert.toFloat(padding.get(0)) * density);
                int top = Math.round(Convert.toFloat(padding.get(1)) * density);
                int right = Math.round(Convert.toFloat(padding.get(2)) * density);
                int bottom = Math.round(Convert.toFloat(padding.get(3)) * density);
                cameraUpdate = CameraUpdate.fitBounds(toLatLngBounds(fitBounds), left, top, right, bottom);
            }
        } else {
            throw new IllegalArgumentException("Cannot interpret " + type + " as CameraUpdate");
        }


        // Object scrollTo = map.get("scrollTo");
        // if (scrollTo != null) {
        //     LatLng latLng = toLatLng(scrollTo);
        //     if (map.containsKey("zoomTo")) {
        //         double zoomTo = (double) map.get("zoomTo");
        //         if (zoomTo == 0.0)
        //             cameraUpdate = CameraUpdate.scrollTo(latLng);
        //         else
        //             cameraUpdate = CameraUpdate.scrollAndZoomTo(latLng, zoomTo);
        //     } else {
        //         cameraUpdate = CameraUpdate.scrollTo(latLng);
        //     }
        // }

        int curve = (int) map.get("curve");
        CameraAnimation animation;
        if(curve == 0) {
            animation = CameraAnimation.None;
        } else if(curve == 1) {
            animation = CameraAnimation.Linear;
        } else if(curve == 3) {
            animation = CameraAnimation.Easing;
        } else if(curve == 4) {
            animation = CameraAnimation.Fly;
        } else {
            animation = CameraAnimation.None;
        }
        // convert int duration to long
        long duration = (long) (int) map.get("duration");

        cameraUpdate.animate(animation, duration);

        return cameraUpdate;

    }

    static Object cameraPositionToJson(CameraPosition position) {
        if (position == null) {
            return null;
        }
        final Map<String, Object> data = new HashMap<>();
        data.put("bearing", position.bearing);
        data.put("target", latLngToJson(position.target));
        data.put("tilt", position.tilt);
        data.put("zoom", position.zoom);
        return data;
    }

    static Object latlngBoundsToJson(LatLngBounds latLngBounds) {
        final Map<String, Object> arguments = new HashMap<>(2);
        arguments.put("southwest", latLngToJson(latLngBounds.getSouthWest()));
        arguments.put("northeast", latLngToJson(latLngBounds.getNorthEast()));
        return arguments;
    }

    static Object latLngToJson(LatLng latLng) {
        return Arrays.asList(latLng.latitude, latLng.longitude);
    }

    static float toFloat(Object o) {
        return ((Number) o).floatValue();
    }

    static OverlayImage toOverlayImage(Object o) {
        String assetName = (String) o;
        String key = FlutterMain.getLookupKeyForAsset(assetName);
        return OverlayImage.fromAsset(key);
    }

    static List<LatLng> toCoords(Object o) {
        final List<?> data = (List) o;
        final List<LatLng> points = new ArrayList<>(data.size());

        for (Object ob : data) {
            final List<?> point = (List) ob;
            points.add(new LatLng(toFloat(point.get(0)), toFloat(point.get(1))));
        }
        return points;
    }

    static List<List<LatLng>> toHoles(Object o) {
        final List<?> data = (List) o;
        final List<List<LatLng>> holes = new ArrayList<>(data.size());

        for (Object ob : data) {
            List<LatLng> hole = toCoords(ob);
            holes.add(hole);
        }
        return holes;
    }

    @SuppressWarnings("MalformedFormatString")
    static int toColorInt(Object value) {
        if (value instanceof Long || value instanceof Integer) {
            String formed = String.format("#%08x", value);
            return Color.parseColor(formed);
        } else {
            return 0;
        }
    }

}
