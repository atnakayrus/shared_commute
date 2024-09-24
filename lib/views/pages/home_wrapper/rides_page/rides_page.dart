import 'package:flutter/material.dart';
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
      body: Container(
        color: Colors.yellow,
      ),
    );
  }
}
