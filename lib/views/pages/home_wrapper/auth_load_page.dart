import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_commute/views/pages/home_wrapper/home_wrapper.dart';
import 'package:shared_commute/views/pages/login_signup_routes/login_page.dart';

class AuthLoadPage extends StatefulWidget {
  const AuthLoadPage({super.key});

  @override
  State<AuthLoadPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<AuthLoadPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          debugPrint("Auth Changes");
          if (snapshot.hasData) {
            return const HomeWrapper();
          } else {
            return const LoginPage();
          }
        });
  }
}
