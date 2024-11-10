import 'package:flutter/material.dart';
import 'package:shared_commute/views/widgets/sc_icon_button.dart';
import 'package:shared_commute/views/widgets/sc_text_input.dart';

class MapLayover extends StatefulWidget {
  final TextEditingController originController;
  final TextEditingController destController;
  const MapLayover(
      {super.key,
      required this.originController,
      required this.destController});

  @override
  State<MapLayover> createState() => _MapLayoverState();
}

class _MapLayoverState extends State<MapLayover> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                ScIconButton(
                    onPressed: () {}, icon: Icons.person_pin_circle_rounded),
                Expanded(
                  child: ScTextInput(
                    controller: widget.originController,
                    width: double.infinity,
                    height: 50,
                    bgColor: Colors.white,
                    hintText: 'Your location',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
              child: Text('--- TO ---'),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                ScIconButton(onPressed: () {}, icon: Icons.location_on),
                Expanded(
                  child: ScTextInput(
                    controller: widget.destController,
                    width: double.infinity,
                    height: 50,
                    bgColor: Colors.white,
                    hintText: 'Select Destination',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
