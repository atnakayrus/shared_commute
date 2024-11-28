import 'package:flutter/material.dart';
import 'package:shared_commute/consts/appstyle.dart';

class ScButton extends StatelessWidget {
  final Function() onTap;
  String? text;
  IconData? icon;
  final bool isDisabled;
  final bool isLarge;
  final bool isIconButton;
  ScButton({
    super.key,
    required this.onTap,
    this.text,
    this.icon,
    this.isDisabled = false,
    this.isLarge = true,
    this.isIconButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isDisabled ? () {} : onTap,
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            isDisabled
                ? Appstyle().buttonDisabledColor
                : Appstyle().buttonActiveColor,
          ),
          padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 15, horizontal: 20))),
      child: isIconButton
          ? Icon(icon)
          : Text(
              text!,
              style: Appstyle().buttonText,
            ),
    );
  }
}
