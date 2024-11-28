import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_commute/common/toast.dart';
import 'package:shared_commute/consts/appstyle.dart';
import 'package:shared_commute/controllers/ride_controller/ride_service.dart';
import 'package:shared_commute/models/address.dart';
import 'package:shared_commute/models/ride.dart';
import 'package:shared_commute/views/pages/new_rides/widgets/nearby_tile.dart';

class FindRidePage extends StatefulWidget {
  static const pageId = '/findRide';
  final Address origin;
  final Address dest;

  const FindRidePage({super.key, required this.origin, required this.dest});

  @override
  State<FindRidePage> createState() => _FindRidePageState();
}

class _FindRidePageState extends State<FindRidePage> {
  List<Ride>? nearbyRides;

  Future<bool> onTap() async {
    bool check = await RideService().hasActiveRide();
    if (check) {
      showToast('Oops! Looks like you have an active ride');
      return false;
    }
    Ride ride = await RideService()
        .createRide(origin: widget.origin, destination: widget.dest);
    if (ride.uid != null) {
      return true;
    } else {
      showToast('Oops Something went wrong');
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    List<Ride> rides = await RideService()
        .getNearbyRides(origin: widget.origin, dest: widget.dest);
    setState(() {
      nearbyRides = rides;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'F I N D   R I D E S',
          style: Appstyle().titleText,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  bool check = await onTap();
                  if (check && context.mounted) {
                    showToast('Ride Created Successfully');
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: Text(
                    'Create Ride',
                    style: Appstyle().buttonText,
                  ),
                ),
              ),
              nearbyRides == null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 100, horizontal: 20),
                      child: Text(
                        'Please wait while we search for suitable rides...',
                        style: Appstyle().mainText,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : nearbyRides!.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 100, horizontal: 20),
                          child: Text(
                            'No Suitable Rides Found',
                            style: Appstyle().mainText,
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: nearbyRides!.length,
                          itemBuilder: (context, index) {
                            return NearbyTile(
                              ride: nearbyRides![index],
                            );
                          })
            ],
          ),
        ),
      ),
    );
  }
}
