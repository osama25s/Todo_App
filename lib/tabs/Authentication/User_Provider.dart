import 'package:flutter/material.dart';
import 'package:todo_app/models/User_Model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? currentUser;

  void updateuser(UserModel user) {
    currentUser = user;
    notifyListeners();
  }
}
