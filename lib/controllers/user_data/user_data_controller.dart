import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_commute/common/toast.dart';
import 'package:shared_commute/consts/enums.dart';
import 'package:shared_commute/models/user_model.dart';
import 'package:shared_commute/provider/user_provider.dart';

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

  Future<ResponseCode> uploadProfilePicture(File imageFile) async {
    User? _user = _auth.currentUser;
    try {
      if (_user == null) {
        showToast('User Not Logged In');
        return ResponseCode.failure;
      } else {
        String filePath = 'profile_pictures/${_user.uid}.jpg';
        FirebaseStorage storage = FirebaseStorage.instance;
        UploadTask uploadTask = storage.ref(filePath).putFile(imageFile);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        await updateUserProfilePhoto(downloadUrl);
        return ResponseCode.success;
      }
    } catch (e) {
      showToast('Oops! Something went wrong');
      return ResponseCode.serverError;
    }
  }

  Future<void> updateUserProfilePhoto(String newUrl) async {
    firestore.collection('users').doc(_auth.currentUser!.uid).set({
      'display_pic': newUrl,
    }, SetOptions(merge: true));
  }

  Future<void> updateUserDetails(
      {required BuildContext context,
      String? newName,
      String? newPNo,
      String? newDob}) async {
    UserModel user = context.read<UserProvider>().user;
    firestore.collection('users').doc(_auth.currentUser!.uid).set({
      'display_name': newName ?? user.displayName,
      'p_no': newPNo ?? user.pNo,
      'dob': newDob ?? user.dob,
    }, SetOptions(merge: true));
  }
}
