import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_commute/controllers/user_auth/firebase_auth_service.dart';

class UserController {
  static final FirebaseAuthService _auth = FirebaseAuthService();

  void userSignup(String email, String password) async {
    User? user = await _auth.signUpWithEmail(email, password);

    if (user != null) {
      debugPrint("User Created");
      debugPrint(user.toString());
    }
  }

  void userLogin(String email, String password) async {
    User? user = await _auth.signInWithEmail(email, password);
    if (user != null) {
      debugPrint("Login Successful");
      debugPrint(user.toString());
    }
  }

  void userSignout() {
    _auth.signOut();
  }
}
