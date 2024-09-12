import 'package:flutter/material.dart';

class ScTextInput extends StatefulWidget {
  final TextEditingController controller;
  final bool isDisabled;
  final bool isExpandable;
  final bool isPassword;
  double width;
  double height;
  String? hintText;
  TextInputType? keyboardType;
  ScTextInput({
    super.key,
    required this.controller,
    this.keyboardType,
    this.hintText,
    this.width = 240,
    this.height = 50,
    this.isDisabled = false,
    this.isExpandable = false,
    this.isPassword = false,
  });

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
      padding: EdgeInsets.fromLTRB(20, 0, (widget.isPassword ? 5 : 20), 0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: widget.isPassword ? 150 : 198,
            height: 30,
            child: TextField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              readOnly: widget.isDisabled,
              maxLines: widget.isExpandable ? 999 : 1,
              expands: widget.isExpandable,
              obscureText: !(show || !widget.isPassword),
              decoration: InputDecoration(
                  hintText: widget.hintText,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(
                    bottom: 20 / 2, // HERE THE IMPORTANT PART
                  )),
            ),
          ),
          widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      show = !show;
                    });
                  },
                  icon: Icon(show
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
