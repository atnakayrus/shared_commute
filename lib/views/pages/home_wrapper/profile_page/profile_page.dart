import 'package:flutter/material.dart';
import 'package:shared_commute/controllers/user_auth/user_auth_controller.dart';
import 'package:shared_commute/views/pages/home_wrapper/profile_page/widgets/user_tile.dart';
import 'package:shared_commute/views/widgets/sc_text_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const UserTile(),
              ScTextButton(
                onTap: () {
                  // TODO: open the edit page here
                },
                text: "Edit Profile",
                icon: Icons.person,
              ),
              ScTextButton(
                onTap: () {
                  // TODO: open the edit page here
                },
                text: "General Settings",
                icon: Icons.settings,
              ),
              ScTextButton(
                onTap: () {
                  // TODO: open the edit page here
                },
                text: "Security Settings",
                icon: Icons.security,
              ),
              ScTextButton(
                onTap: () {
                  UserAuthController().userSignout();
                },
                text: "Logout",
                icon: Icons.logout,
              ),
              ScTextButton(
                onTap: () {
                  // TODO: open the edit page here
                },
                text: "Delete Account",
                icon: Icons.delete,
                showBottomBorder: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
