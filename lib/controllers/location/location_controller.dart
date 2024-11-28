import 'package:flutter/material.dart';
import 'package:flutter_config_plus/flutter_config_plus.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationController {
  // lat and lng for New Delhi
  double lat = 28.6139;
  double lng = 77.2088;

  Location location = Location();

  LatLng get getUserLocation => LatLng(lat, lng);

  Future<bool> isServiceEnabled() async {
    bool enabled = await location.serviceEnabled();
    if (enabled) {
      await location.requestService();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> requestPermission() async {
    PermissionStatus status = await location.hasPermission();
    if (status == PermissionStatus.denied) {
      status = await location.requestPermission();
      if (status == PermissionStatus.denied) {
        return false;
      }
    }
    return true;
  }

  Future<void> setCameraTo(LatLng pos, GoogleMapController controller) async {
    CameraPosition position = CameraPosition(target: pos, zoom: 16);
    await controller.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  Future<List<LatLng>> getPolyPoints(
      {required LatLng origin, required LatLng dest}) async {
    List<LatLng> polyPoints = [];
    PolylinePoints polylinePoints = PolylinePoints();
    String key = FlutterConfigPlus.get('GOOGLE_MAPS_API_KEY');
    try {
      PolylineResult polylineResult =
          await polylinePoints.getRouteBetweenCoordinates(
              request: PolylineRequest(
                  origin: PointLatLng(origin.latitude, origin.longitude),
                  destination: PointLatLng(dest.latitude, dest.longitude),
                  mode: TravelMode.driving),
              googleApiKey: key);
      if (polylineResult.points.isNotEmpty) {
        for (var point in polylineResult.points) {
          polyPoints.add(LatLng(point.latitude, point.longitude));
        }
      }
    } catch (e) {
      debugPrint("Oops an error occured");
    }
    return polyPoints;
  }
}
