import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_commute/models/user_model.dart';

class UserDataController {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static final firestore = FirebaseFirestore.instance;

  Future<int> updateAuthUserProfile({
    String? displayName,
    String? photoUrl,
  }) async {
    User? user = _auth.currentUser;

    if (user != null) {
      try {
        if (displayName != null) {
          await user.updateDisplayName(displayName);
        }
        if (photoUrl != null) {
          await user.updatePhotoURL(photoUrl);
        }
        await user.reload(); // Reload the user to get the updated profile

        user = _auth.currentUser!; // Reload the updated user info

        return (1);
      } catch (e) {
        debugPrint('Error updating user profile: $e');
        return (0);
      }
    }
    return (0);
  }

  Future<UserModel> getUserById(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    UserModel user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    return user;
  }

  Future<int> uploadUserToFirestore(User user) async {
    try {
      firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'display_name': user.displayName
      }, SetOptions(merge: true));

      return (1);
    } catch (e) {
      debugPrint(e.toString());
      return (0);
    }
  }
}
