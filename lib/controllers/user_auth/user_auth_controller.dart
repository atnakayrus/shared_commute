import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_commute/controllers/user_auth/firebase_auth_service.dart';

class UserAuthController {
  static final FirebaseAuthService _auth = FirebaseAuthService();

  Future<int> userSignup(String email, String password) async {
    User? user = await _auth.signUpWithEmail(email, password);

    if (user != null) {
      debugPrint("User Created");
      debugPrint(user.toString());
      return (1);
    }
    return (0);
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

  User? get getUser => FirebaseAuth.instance.currentUser;

  void updateUser({String? displayName}) {}
}
