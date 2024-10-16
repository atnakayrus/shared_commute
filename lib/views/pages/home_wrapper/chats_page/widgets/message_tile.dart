import 'package:flutter/material.dart';
import 'package:shared_commute/consts/appstyle.dart';
import 'package:shared_commute/models/message.dart';

class MessageTile extends StatelessWidget {
  final Message message;
  final String sender;
  final bool self;
  const MessageTile(
      {super.key,
      required this.message,
      required this.sender,
      required this.self});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      alignment: self ? Alignment.centerRight : Alignment.bottomLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            self ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (!self)
            Text(
              sender,
              style: Appstyle().helperText,
            ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: self ? Theme.of(context).primaryColor : Colors.white,
              border: Border.all(color: Colors.black45, width: 1),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              message.text!,
              style: Appstyle().contentText,
            ),
          )
        ],
      ),
    );
  }
}
