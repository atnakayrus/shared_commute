import 'package:flutter/material.dart';
import 'package:shared_commute/views/pages/home_wrapper/home_page/widgets/home_map.dart';
import 'package:shared_commute/views/pages/home_wrapper/home_page/widgets/map_layover.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController origin = TextEditingController();
  TextEditingController dest = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          HomeMap(),
          MapLayover(
            originController: origin,
            destController: dest,
          )
        ],
      ),
    );
  }
}
