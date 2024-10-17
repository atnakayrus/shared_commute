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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            margin: self
                ? const EdgeInsets.only(left: 30)
                : const EdgeInsets.only(right: 30),
            decoration: BoxDecoration(
              color: self ? Theme.of(context).primaryColor : Colors.white,
              border: Border.all(color: Colors.black45, width: 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              message.text!,
              style: Appstyle().contentText,
            ),
          ),
          Text(
            ("${message.timestamp!.toDate().day}/${message.timestamp!.toDate().month}  ${message.timestamp!.toDate().hour}:${message.timestamp!.toDate().minute}"),
            style: Appstyle().helperText,
          )
        ],
      ),
    );
  }
}
