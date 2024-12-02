import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_commute/common/toast.dart';
import 'package:shared_commute/consts/appstyle.dart';
import 'package:shared_commute/controllers/ride_controller/ride_service.dart';
import 'package:shared_commute/models/address.dart';
import 'package:shared_commute/models/ride.dart';
import 'package:shared_commute/views/pages/new_rides/widgets/nearby_tile.dart';
import 'package:shared_commute/views/widgets/sc_button.dart';

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
  TimeOfDay selectedTime = TimeOfDay.now();
  bool hasVehicle = false;

  Future<TimeOfDay?> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime, // Set the initial time
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      return pickedTime;
    }
    return null;
  }

  Future<bool> onTap() async {
    bool check = await RideService().hasActiveRide();
    if (check) {
      showToast('Oops! Looks like you have an active ride');
      return false;
    } else {
      if (context.mounted) {
        await showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(builder: (context, setStateInDialog) {
                return AlertDialog(
                  title: Text(
                    'Create a Ride?',
                    style: Appstyle().titleText,
                  ),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        width: double.infinity,
                        height: 2,
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Time : ',
                            style: Appstyle().subtitleText,
                          ),
                          GestureDetector(
                            onTap: () async {
                              TimeOfDay? newTime = await _selectTime(context);
                              if (newTime != null && context.mounted) {
                                setState(() {
                                  selectedTime = newTime;
                                });
                                setStateInDialog(() {});
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: Text(
                                "${selectedTime.hour ~/ 10}${selectedTime.hour % 10} : ${selectedTime.minute ~/ 10}${selectedTime.minute % 10} ",
                                style: Appstyle().subtitleText,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'I have a Vehicle: ',
                            style: Appstyle().subtitleText,
                          ),
                          Switch(
                              value: hasVehicle,
                              onChanged: (val) {
                                setState(() {
                                  hasVehicle = val;
                                });
                                setStateInDialog(() {});
                              })
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        width: double.infinity,
                        height: 2,
                        color: Colors.grey,
                      ),
                      Text(
                        'From',
                        style: Appstyle().subtitleText,
                      ),
                      Text(
                        widget.origin.formattedAddress!,
                        style: Appstyle().helperText,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'To',
                        style: Appstyle().subtitleText,
                      ),
                      Text(
                        widget.dest.formattedAddress!,
                        style: Appstyle().helperText,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        width: double.infinity,
                        height: 2,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  actions: [
                    ScButton(
                      onTap: () async {
                        final now = DateTime.now(); // Use today's date
                        final combinedDateTime = DateTime(
                          now.year,
                          now.month,
                          now.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );

                        if (combinedDateTime.difference(now).isNegative) {
                          showToast('Please select a future time');
                        } else {
                          Timestamp time = Timestamp.fromDate(combinedDateTime);
                          Ride ride = await RideService().createRide(
                              origin: widget.origin,
                              destination: widget.dest,
                              startTime: time,
                              hasVehicle: hasVehicle);
                          if (ride.uid == null) {
                            showToast('Oops Something went wrong');
                          }
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        }
                      },
                      text: 'Confirm',
                    )
                  ],
                );
              });
            });
      }

      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final now = DateTime.now(); // Use today's date
    final combinedDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
    );
    List<Ride> rides = await RideService().getNearbyRides(
        origin: widget.origin,
        dest: widget.dest,
        selectedTime: combinedDateTime);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Time : ',
                    style: Appstyle().mainText,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Text(
                      "${selectedTime.hour ~/ 10}${selectedTime.hour % 10} : ${selectedTime.minute ~/ 10}${selectedTime.minute % 10}",
                      style: Appstyle().mainText,
                    ),
                  ),
                  IconButton.filled(
                      onPressed: () async {
                        TimeOfDay? newTime = await _selectTime(context);
                        if (newTime != null && context.mounted) {
                          setState(() {
                            selectedTime = newTime;
                          });
                        }
                      },
                      icon: const Icon(Icons.edit)),
                ],
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
