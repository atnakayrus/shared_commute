import 'package:flutter/material.dart';
import 'package:shared_commute/views/widgets/sc_icon_button.dart';

class ScTextBox extends StatelessWidget {
  final TextEditingController controller;
  final Function() onSubmit;
  const ScTextBox(
      {super.key, required this.controller, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(48),
            ),
            hintText: 'Enter message...',
          ),
        )),
        const SizedBox(
          width: 10,
        ),
        ScIconButton(
          onPressed: onSubmit,
          icon: Icons.send,
          isOutlined: true,
          buttonColor: Theme.of(context).primaryColor,
        )
      ],
    );
  }
}
