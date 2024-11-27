import 'package:flutter/material.dart';
import 'package:shared_commute/views/pages/home_wrapper/rides_page/ride_tile.dart';
import 'package:shared_commute/views/widgets/sc_info_widget.dart';
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
      body:
          // ScInfoWidget(
          //     icon: Icons.pedal_bike, text: 'Your rides will appear here')
          SingleChildScrollView(
        child: Column(
          children: [
            RideTile(),
            RideTile(),
            RideTile(),
            RideTile(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/newRide');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
