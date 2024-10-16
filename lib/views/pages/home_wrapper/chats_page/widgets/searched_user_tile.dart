import 'package:flutter/material.dart';
import 'package:shared_commute/consts/appstyle.dart';
import 'package:shared_commute/models/user_model.dart';
import 'package:shared_commute/views/pages/home_wrapper/chats_page/chat_page/chat_page.dart';

class SearchedUserTile extends StatelessWidget {
  final UserModel user;
  const SearchedUserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(
                      user: user,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
            user.displayName ?? 'Display name',
            style: Appstyle().subtitleText,
          ),
          subtitle: Text(
            user.email ?? 'Email id',
            style: Appstyle().contentText,
          ),
        ),
      ),
    );
  }
}
