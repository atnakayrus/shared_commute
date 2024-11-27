import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_commute/controllers/location/location_controller.dart';
import 'package:shared_commute/views/widgets/sc_loading_page.dart';

class HomeMap extends StatefulWidget {
  final LatLng? origin;
  final List<LatLng>? destinations;
  final bool showOrigin;
  const HomeMap({
    super.key,
    this.origin,
    this.destinations,
    required this.showOrigin,
  });

  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  LocationController locationController = LocationController();
  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    updateMarkers();
  }

  @override
  void didUpdateWidget(covariant HomeMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.origin != widget.origin ||
        oldWidget.destinations != widget.destinations) {
      if (context.mounted) {
        setState(() {
          updateMarkers();
        });
      }
    }
  }

  void updateMarkers() {
    setState(() {
      if (widget.origin != null) {
        setState(() {
          setCameraTo(widget.origin!);
        });
        if (widget.destinations != null && widget.destinations!.isNotEmpty) {
          locationController
              .getPolyPoints(
                  origin: widget.origin!, dest: widget.destinations![0])
              .then((coordinates) {
            PolylineId id = const PolylineId('poly');
            Polyline polyline = Polyline(
                polylineId: id,
                color: Colors.blue,
                points: coordinates,
                width: 8);
            setState(() {
              polylines[id] = polyline;
              setCameraTo(widget.destinations![0]);
            });
          });
        }
      }
    });
  }

  Future<void> setCameraTo(LatLng pos) async {
    final GoogleMapController controller = await mapController.future;
    CameraPosition position = CameraPosition(target: pos, zoom: 15);
    await controller.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  @override
  Widget build(BuildContext context) {
    return widget.origin == null
        ? const ScLoadingPage()
        : GoogleMap(
            onMapCreated: ((GoogleMapController controller) =>
                mapController.complete(controller)),
            initialCameraPosition: CameraPosition(
              target: widget.origin!,
              zoom: 16,
            ),
            markers: {
              if (widget.showOrigin)
                Marker(
                  markerId: const MarkerId("origin"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: widget.origin!,
                ),
              if (widget.destinations != null &&
                  widget.destinations!.isNotEmpty)
                Marker(
                  markerId: const MarkerId('destination'),
                  icon: BitmapDescriptor.defaultMarker,
                  position: widget.destinations![0],
                )
            },
            polylines: Set<Polyline>.of(polylines.values),
          );
  }
}
