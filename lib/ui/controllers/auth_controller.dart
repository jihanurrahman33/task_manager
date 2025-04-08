import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/models/user_model.dart';

class AuthController {
  static String? token;
  static UserModel? userModel;

  static final String _tokenKey = 'token';
  static final String _userDataKey = 'token';
  //save user information
  static Future<void> saveUserInformation(
    String accessToken,
    UserModel userModel,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_tokenKey, accessToken);
    sharedPreferences.setString(_userDataKey, jsonEncode(userModel.toJson()));
    token = accessToken;
    userModel = userModel;
  }

  //get user information
  static Future<void> getUserInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString(_tokenKey);
    String? savedUserModelString = (sharedPreferences.getString(_userDataKey));
    if (savedUserModelString != null) {
      UserModel savedUserModel = UserModel.fromJson(
        jsonDecode(savedUserModelString),
      );
      userModel = savedUserModel;
    }
    token = accessToken;
  }
}
