import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDataController {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

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
}
