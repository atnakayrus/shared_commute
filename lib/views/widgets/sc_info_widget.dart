import 'package:flutter/material.dart';
import 'package:shared_commute/consts/appstyle.dart';

class ScInfoWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  const ScInfoWidget({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: Colors.grey,
            ),
            Text(
              text,
              style: Appstyle().titleText.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
