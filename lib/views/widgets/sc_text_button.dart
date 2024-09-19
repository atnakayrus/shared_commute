import 'package:flutter/material.dart';
import 'package:shared_commute/consts/appstyle.dart';

class ScTextButton extends StatelessWidget {
  final Function() onTap;
  String text;
  IconData? icon;
  bool showBottomBorder;
  final bool isDisabled;
  ScTextButton({
    super.key,
    required this.onTap,
    required this.text,
    this.icon,
    this.isDisabled = false,
    this.showBottomBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        top: const BorderSide(color: Colors.black45, width: 1),
        bottom: showBottomBorder
            ? const BorderSide(color: Colors.black45, width: 1)
            : const BorderSide(width: 0, color: Colors.transparent),
      )),
      child: ListTile(
        enabled: !isDisabled,
        title: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            text,
            style: Appstyle().subtitleText,
          ),
        ),
        leading: icon != null
            ? Icon(
                icon,
                size: 24,
              )
            : null,
        onTap: onTap,
        minTileHeight: 50,
      ),
    );
  }
}
