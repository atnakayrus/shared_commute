import 'package:flutter/material.dart';
import 'package:shared_commute/views/widgets/widget_builders.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: scAppBar('home'),
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
