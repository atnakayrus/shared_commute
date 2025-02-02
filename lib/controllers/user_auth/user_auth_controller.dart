import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_commute/common/toast.dart';
import 'package:shared_commute/controllers/user_auth/firebase_auth_service.dart';
import 'package:shared_commute/controllers/user_data/user_data_controller.dart';

class UserAuthController {
  static final FirebaseAuthService _auth = FirebaseAuthService();
  static final _userDataController = UserDataController();

  Future<int> userSignup({
    required String email,
    required String password,
    required String displayName,
  }) async {
    User? user = await _auth.signUpWithEmail(email, password);

    if (user != null) {
      debugPrint("User Created");
      debugPrint(user.toString());
      await UserDataController().updateAuthUserProfile(
        displayName: displayName,
      );
      _userDataController.uploadUserToFirestore(UserAuthController().getUser!);
      return (1);
    }
    return (0);
  }

  void userLogin(String email, String password) async {
    User? user = await _auth.signInWithEmail(email, password);
    if (user != null) {
      _userDataController.uploadUserToFirestore(user);
      debugPrint("Login Successful");
      debugPrint(user.toString());
    }
  }

  void userSignout() {
    _auth.signOut();
  }

  User? get getUser => FirebaseAuth.instance.currentUser;

  Future<void> sendVerificationEmail() async {
    User? user = getUser;
    await user?.reload();
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      showToast('Verification Email Sent');
    } else if (user!.emailVerified) {
      showToast('Email already verified , please refresh app');
    }
  }

  void updateUser({String? displayName}) {}
}
