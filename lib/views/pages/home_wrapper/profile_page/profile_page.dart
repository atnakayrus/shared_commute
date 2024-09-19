import 'package:flutter/material.dart';
import 'package:shared_commute/consts/appstyle.dart';
import 'package:shared_commute/controllers/user_auth/user_controller.dart';
import 'package:shared_commute/views/widgets/sc_text_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'P R O F I L E',
          style: Appstyle().mainText,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ScTextButton(
              onTap: () {
                UserController().userSignout();
              },
              text: "Logout",
              icon: Icons.logout,
              showBottomBorder: true,
            )
          ],
        ),
      ),
    );
  }
}
