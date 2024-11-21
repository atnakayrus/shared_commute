import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_commute/consts/appstyle.dart';

class ScLoadingPage extends StatefulWidget {
  const ScLoadingPage({super.key});

  @override
  State<ScLoadingPage> createState() => _ScLoadingPageState();
}

class _ScLoadingPageState extends State<ScLoadingPage> {
  String text = 'Loading';
  int num = 1;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      num = (num) % 3 + 1;
      setState(() {
        text = "Loading${"." * num}";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text,
          style: Appstyle()
              .mainText
              .copyWith(color: Theme.of(context).primaryColor)),
    );
  }
}
