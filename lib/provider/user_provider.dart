import 'package:flutter/material.dart';
import 'package:shared_commute/controllers/user_data/user_data_controller.dart';
import 'package:shared_commute/models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel _userModel = UserModel();

  UserModel get user => _userModel;

  void resetUser() {
    _userModel = UserModel();
    notifyListeners();
  }

  void updateUserFromModel(UserModel newUser) {
    _userModel = newUser;
    notifyListeners();
  }

  Future<void> updateUserFromUid(String uid) async {
    _userModel = await UserDataController().getUserById(uid);
  }
}
