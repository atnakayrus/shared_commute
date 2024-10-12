import 'package:flutter/material.dart';
import 'package:shared_commute/consts/appstyle.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
      child: ListTile(
        leading: SizedBox(
          height: Appstyle().scChatIconSize,
          width: Appstyle().scChatIconSize,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Appstyle().scChatIconSize),
            child: Image.network(
                height: Appstyle().scChatIconSize,
                width: Appstyle().scChatIconSize,
                "https://uxwing.com/wp-content/themes/uxwing/download/peoples-avatars/corporate-user-icon.png"),
          ),
        ),
        title: Text(
          'Surya Kanta Ghosh',
          style: Appstyle().subtitleText,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Text(
          'Hello , How are you?',
          style: Appstyle().helperText,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
      ),
    );
  }
}
