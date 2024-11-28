import 'package:flutter/material.dart';
import 'package:shared_commute/controllers/ride_controller/ride_service.dart';
import 'package:shared_commute/models/ride.dart';
import 'package:shared_commute/views/pages/home_wrapper/rides_page/ride_tile.dart';
import 'package:shared_commute/views/widgets/sc_info_widget.dart';
import 'package:shared_commute/views/widgets/sc_loading_page.dart';
import 'package:shared_commute/views/widgets/widget_builders.dart';

class RidesPage extends StatefulWidget {
  const RidesPage({super.key});

  @override
  State<RidesPage> createState() => _RidesPageState();
}

class _RidesPageState extends State<RidesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: scAppBar('rides'),
      body: StreamBuilder(
          stream: RideService().getRidesStream(),
          builder: (context, stream) {
            RideService().updateRideStatus();
            if (stream.connectionState == ConnectionState.waiting) {
              return const ScLoadingPage();
            } else {
              if (stream.data == null || stream.data!.docs.isEmpty) {
                return const ScInfoWidget(
                    icon: Icons.pedal_bike,
                    text: "Start Riding by clicking the + icon");
              } else {
                return SingleChildScrollView(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: stream.data!.size,
                        itemBuilder: (context, index) {
                          RideLog ride = RideLog.fromJson(
                              stream.data!.docs[index].data()
                                  as Map<String, dynamic>);
                          return RideTile(
                            ride: ride,
                          );
                        }));
              }
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/newRide');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
