import 'package:flutter/material.dart';
import 'package:shared_commute/consts/appstyle.dart';

class ScErrorPage extends StatelessWidget {
  final String? errorText;
  const ScErrorPage({super.key, this.errorText});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 36,
              color: Theme.of(context).primaryColor,
            ),
            Text(
              errorText ?? "Oops! Something Went Wrong",
              style: Appstyle().mainText,
            ),
          ],
        ),
      ),
    );
  }
}
