import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_commute/common/toast.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredentials = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredentials.user;
    } on FirebaseAuthException catch (e) {
      debugPrint("Error occured in Signup");

      if (e.code == "email-already-in-use") {
        showToast("Email already in use");
      } else {
        showToast('Something went wrong');
      }
    }
    return null;
  }

  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredentials.user;
    } on FirebaseAuthException {
      debugPrint("Error occured in login");
      showToast('Incorrect Username or Password');
    }
    return null;
  }

  void signOut() {
    _auth.signOut();
    showToast('Signout successful');
  }
}
