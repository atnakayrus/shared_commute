import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_commute/common/toast.dart';
import 'package:shared_commute/consts/appstyle.dart';
import 'package:shared_commute/controllers/location/location_controller.dart';
import 'package:shared_commute/models/address.dart';
import 'package:shared_commute/models/google_route.dart';
import 'package:shared_commute/services/geocoding_service.dart';
import 'package:shared_commute/views/pages/new_rides/find_ride_page.dart';
import 'package:shared_commute/views/pages/new_rides/widgets/home_bottom_tab.dart';
import 'package:shared_commute/views/pages/new_rides/widgets/home_map.dart';
import 'package:shared_commute/views/pages/new_rides/widgets/map_layover.dart';
import 'package:shared_commute/views/widgets/sc_error_page.dart';

class NewRidePage extends StatefulWidget {
  const NewRidePage({super.key});

  @override
  State<NewRidePage> createState() => _NewRidePageState();
}

class _NewRidePageState extends State<NewRidePage> {
  TextEditingController originController = TextEditingController();
  TextEditingController destController = TextEditingController();
  LatLng? origin;
  Address? originAddress;
  LatLng? self;
  bool showOrigin = false;
  bool isAllowed = false;
  List<LatLng> dest = [];
  Address? destinationAddress;
  GoogleRoute? gRoute;

  LocationController locationController = LocationController();

  StreamSubscription<LocationData>? _locationSubscription;

  void search() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FindRidePage(
                  origin: originAddress!,
                  dest: destinationAddress!,
                )));
  }

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  void setSource(Address newOrigin) async {
    setState(() {
      origin = LatLng(newOrigin.geometry!.location!.lat!,
          newOrigin.geometry!.location!.lng!);
      showOrigin = true;
      originAddress = newOrigin;
    });
    getPath();
  }

  void setDest(Address newDest) async {
    setState(() {
      dest = [];
      dest.add(LatLng(
          newDest.geometry!.location!.lat!, newDest.geometry!.location!.lng!));
      destinationAddress = newDest;
    });
    getPath();
  }

  void getPath() async {
    if (origin != null && dest.isNotEmpty) {
      final route = await GeocodingService().getPathDistance(origin!, dest[0]);
      if (context.mounted) {
        setState(() {
          gRoute = route;
        });
      }
    }
  }

  Future<void> getLocationUpdates() async {
    if (!await locationController.isServiceEnabled()) {
      showToast("Oops! Something went Wrong");
      return;
    } else if (!await locationController.requestPermission()) {
      showToast("Permission not granted");
    } else {
      if (context.mounted) {
        setState(() {
          isAllowed = true;
        });
      }
      _locationSubscription = locationController.location.onLocationChanged
          .listen((LocationData current) {
        locationController.lat = current.latitude ?? locationController.lat;
        locationController.lng = current.longitude ?? locationController.lng;
        if (context.mounted) {
          setState(() {
            self = LatLng(locationController.lat, locationController.lng);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        title: Text(
          'C R E A T E   R I D E',
          style: Appstyle().mainText,
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: !isAllowed
          ? const ScErrorPage(
              errorText: "Location Permission Not Granted",
            )
          : Stack(
              children: [
                HomeMap(
                  origin: origin ?? self,
                  destinations: dest,
                  showOrigin: showOrigin,
                ),
                MapLayover(
                  originController: originController,
                  destController: destController,
                  setDest: setDest,
                  setSource: setSource,
                ),
                if (gRoute != null)
                  HomeBottomTab(gRoute: gRoute!, onTap: search)
              ],
            ),
    );
  }
}
