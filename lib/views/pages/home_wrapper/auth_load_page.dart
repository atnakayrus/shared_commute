import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_commute/controllers/user_auth/user_auth_controller.dart';
import 'package:shared_commute/provider/user_provider.dart';
import 'package:shared_commute/views/pages/home_wrapper/home_wrapper.dart';
import 'package:shared_commute/views/pages/login_signup_routes/login_page.dart';

class AuthLoadPage extends StatefulWidget {
  static const pageId = '/';
  const AuthLoadPage({super.key});

  @override
  State<AuthLoadPage> createState() => _AuthLoadPageState();
}

class _AuthLoadPageState extends State<AuthLoadPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          debugPrint("Auth Changes");
          if (snapshot.hasData) {
            context
                .read<UserProvider>()
                .updateUserFromUid(UserAuthController().getUser!.uid);
            return const HomeWrapper();
          } else {
            return const LoginPage();
          }
        });
  }
}
