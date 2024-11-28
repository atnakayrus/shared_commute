import 'package:flutter/material.dart';
import 'package:shared_commute/models/ride_model.dart';

class MatchedRidesScreen extends StatelessWidget {
  final List<Ride> rides;

  const MatchedRidesScreen({Key? key, required this.rides}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Matched Rides')),
      body: rides.isEmpty
          ? Center(child: Text('No matching rides found'))
          : ListView.builder(
              itemCount: rides.length,
              itemBuilder: (context, index) {
                final ride = rides[index];
                return ListTile(
                  title: Text('From: ${ride.originAddress}'),
                  subtitle: Text('To: ${ride.destinationAddress}'),
                  trailing: Text('${ride.availableSeats} seats'),
                  onTap: () {
                    // TODO: Here we need to implment the ride matching logic:
                  },
                );
              },
            ),
    );
  }
}
