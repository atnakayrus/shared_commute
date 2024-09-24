import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_commute/consts/appstyle.dart';
import 'package:shared_commute/controllers/user_auth/user_auth_controller.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key});

  @override
  Widget build(BuildContext context) {
    User user = UserAuthController().getUser!;

    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: Appstyle().scUserIconSize,
            height: Appstyle().scUserIconSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black54,
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Appstyle().scUserIconSize),
              child: Image.network(user.photoURL ??
                  "https://uxwing.com/wp-content/themes/uxwing/download/peoples-avatars/corporate-user-icon.png"),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.displayName ?? "Display Name",
                  style: Appstyle().contentText,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  user.email ?? "Display Name",
                  style: Appstyle().contentText,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
