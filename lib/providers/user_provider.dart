import 'package:flutter/material.dart';
import 'package:flutter_ecom_app_customer/database/auth/auth_service.dart';
import 'package:flutter_ecom_app_customer/database/firebase_db_helper.dart';
import 'package:flutter_ecom_app_customer/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? userModel;

  Future<void> addUser(UserModel userModel) {
    return FirebaseDbHelper.addUser(userModel);
  }

  Future<bool> doesUserExist(String uid) async {
    return FirebaseDbHelper.doesUserExist(uid);
  }

  void getUserInfo() {
    FirebaseDbHelper.getUserInfoById(AuthService.currentUser!.uid)
        .listen((snapshot) {
      if (snapshot.exists) {
        userModel = UserModel.fromMap(snapshot.data()!);
        notifyListeners();
      }
    });
  }

  Future<void> updateUserProfileField(String field, dynamic value) =>
      FirebaseDbHelper.updateUserProfileField(
          AuthService.currentUser!.uid, {field: value});

}
