import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_commute/consts/appstyle.dart';
import 'package:shared_commute/consts/global_consts.dart';
import 'package:shared_commute/controllers/user_auth/user_auth_controller.dart';
import 'package:shared_commute/models/user_model.dart';
import 'package:shared_commute/provider/user_provider.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = context.read<UserProvider>().user;

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
              child: Image.network(user.displayPic ?? GlobalConsts.altPfp),
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
                Text(
                  UserAuthController().getUser!.emailVerified
                      ? "Email Verified"
                      : "Email Not Verified",
                  style: Appstyle()
                      .helperText
                      .copyWith(fontWeight: FontWeight.bold),
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
