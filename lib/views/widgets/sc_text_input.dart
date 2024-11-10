import 'package:flutter/material.dart';

class ScTextInput extends StatefulWidget {
  final TextEditingController controller;
  final bool isDisabled;
  final bool isExpandable;
  final bool isPassword;
  double width;
  double height;
  String? hintText;
  String? labelText;
  String? helperText;
  Color bgColor;
  TextInputType? keyboardType;
  ScTextInput({
    super.key,
    required this.controller,
    required this.width,
    required this.height,
    this.keyboardType,
    this.hintText,
    this.helperText,
    this.labelText,
    this.isDisabled = false,
    this.isExpandable = false,
    this.isPassword = false,
    this.bgColor = Colors.transparent,
  });
  ScTextInput.fullWidth(
      {super.key,
      required this.controller,
      this.keyboardType,
      this.hintText,
      this.helperText,
      this.labelText,
      this.isDisabled = false,
      this.isExpandable = false,
      this.bgColor = Colors.transparent,
      this.isPassword = false})
      : height = 50,
        width = double.infinity;
  ScTextInput.halfWidth(
      {super.key,
      required this.controller,
      this.keyboardType,
      this.hintText,
      this.helperText,
      this.labelText,
      this.isDisabled = false,
      this.isExpandable = false,
      this.bgColor = Colors.transparent,
      this.isPassword = false})
      : height = 50,
        width = 240;

  @override
  State<ScTextInput> createState() => _ScTextInputState();
}

class _ScTextInputState extends State<ScTextInput> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: widget.bgColor,
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        readOnly: widget.isDisabled,
        maxLines: widget.isExpandable ? 999 : 1,
        expands: widget.isExpandable,
        obscureText: !(show || !widget.isPassword),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 2,
            ),
          ),
          hintText: widget.hintText,
          labelText: widget.labelText,
          helperText: widget.helperText,
          contentPadding: const EdgeInsets.fromLTRB(15, 10, 10, 15),
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      show = !show;
                    });
                  },
                  child: Icon(show
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                )
              : null,
        ),
      ),
    );
  }
}
