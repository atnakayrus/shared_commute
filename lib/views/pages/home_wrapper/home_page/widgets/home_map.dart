import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_commute/common/toast.dart';
import 'package:shared_commute/controllers/location/location_controller.dart';

class HomeMap extends StatefulWidget {
  const HomeMap({super.key});

  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  LatLng? curr;
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  LatLng newDelhi = const LatLng(28.6139, 77.2088);
  LocationController locationController = LocationController();
  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }

  Future<void> getLocationUpdates() async {
    if (!await locationController.isServiceEnabled()) {
      showToast("Oops! Something went Wrong");
      return;
    } else if (!await locationController.requestPermission()) {
      showToast("Permission not granted");
    } else {
      locationController.location.onLocationChanged
          .listen((LocationData current) {
        locationController.lat = current.latitude ?? locationController.lat;
        locationController.lng = current.longitude ?? locationController.lng;
        setState(() {
          if (curr == null) {
            setCameraTo(newDelhi);
            // setCameraTo(locationController.getUserLocation);
          }
          // curr = locationController.getUserLocation;
          curr = newDelhi;
          locationController
              .getPolyPoints(
                  origin: const LatLng(28.6139, 77.2088), //delhi
                  dest: const LatLng(26.8467, 80.9462)) //lucknow
              .then((coordinates) {
            PolylineId id = const PolylineId('poly');
            Polyline polyline = Polyline(
                polylineId: id,
                color: Colors.blue,
                points: coordinates,
                width: 8);
            setState(() {
              polylines[id] = polyline;
            });
          });
        });
      });
    }
  }

  Future<void> setCameraTo(LatLng pos) async {
    final GoogleMapController controller = await mapController.future;
    CameraPosition position = CameraPosition(target: pos, zoom: 16);
    await controller.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  @override
  Widget build(BuildContext context) {
    return curr == null
        ? const Center(
            child: Text('Loading'),
          )
        : GoogleMap(
            onMapCreated: ((GoogleMapController controller) =>
                mapController.complete(controller)),
            initialCameraPosition: CameraPosition(
              target: curr!,
              zoom: 16,
            ),
            markers: {
              Marker(
                markerId: const MarkerId("currentLocation"),
                icon: BitmapDescriptor.defaultMarker,
                position: curr!,
              ),
            },
            polylines: Set<Polyline>.of(polylines.values),
          );
  }
}
