import 'package:flutter/material.dart';
import 'package:shared_commute/consts/appstyle.dart';

class ScIconButton extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  final bool isOutlined;
  const ScIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isOutlined
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(Appstyle().scIconSize),
              border: Border.all(color: Colors.black45, width: 1),
            )
          : null,
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: onPressed,
        child: Icon(
          icon,
          size: Appstyle().scIconSize,
        ),
      ),
    );
  }
}
