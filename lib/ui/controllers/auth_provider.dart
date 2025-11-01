import 'package:flutter/material.dart';
import 'package:task_managenent/data/models/user-models.dart';
import 'package:task_managenent/ui/controllers/auth-controller.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _user = AuthController.userModel;

  UserModel? get user => _user;

  void updateUser (UserModel updateUser) {
     _user = updateUser;
     AuthController.updateUserdata(updateUser);
     notifyListeners();
  }

  Future<void> clearUser() async {
    await AuthController.clearUserData();
    _user = null;
    notifyListeners();
  }
}