import 'package:flutter/material.dart';
import 'package:shared_commute/consts/appstyle.dart';
import 'package:shared_commute/controllers/user_auth/user_auth_controller.dart';
import 'package:shared_commute/controllers/user_data/user_data_controller.dart';
import 'package:shared_commute/models/chat_room.dart';
import 'package:shared_commute/models/user_model.dart';
import 'package:shared_commute/views/pages/home_wrapper/chats_page/chat_page/chat_page.dart';

class ChatTile extends StatelessWidget {
  final ChatRoom chat;
  const ChatTile({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    bool viewed = false;
    if (chat.lastMessageSender == UserAuthController().getUser!.uid) {
      viewed = true;
    } else if (chat.lastMessageViewed ?? false) {
      viewed = true;
    }

    return GestureDetector(
      onTap: () async {
        UserModel user = await UserDataController().getUserById(
            chat.person1 == UserAuthController().getUser!.uid
                ? chat.person2!
                : chat.person1!);
        if (context.mounted) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ChatPage(user: user)));
        }
      },
      child: Container(
        padding: const EdgeInsets.only(top: 20),
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
            chat.person1 == UserAuthController().getUser!.uid
                ? chat.person2Name ?? ""
                : chat.person1Name ?? "",
            style: Appstyle().subtitleText.copyWith(
                fontWeight: viewed ? FontWeight.normal : FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: Text(
            chat.lastMessage ?? "",
            style: Appstyle().helperText.copyWith(
                fontWeight: viewed ? FontWeight.normal : FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          trailing:
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ),
      ),
    );
  }
}
