import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/data/service/network_client.dart';
import 'package:task_manager/data/utils/urls.dart';

class AuthController {
  static String? token;
  static UserModel? userModel;

  static final String _tokenKey = 'token';
  static final String _userDataKey = 'token';
  //save user information
  static Future<void> saveUserInformation(
    String accessToken,
    UserModel user,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_tokenKey, accessToken);
    sharedPreferences.setString(_userDataKey, jsonEncode(user.toJson()));
    token = accessToken;
    userModel = user;
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

  //check if user already logged in
  static Future<bool> checkIfUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userAccessToken = sharedPreferences.getString(_tokenKey);
    if (userAccessToken != null) {
      await getUserInformation();
      return true;
    } else {
      return false;
    }
  }

  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    token = null;
    userModel = null;
  }

  static Future<void> recoverVerifyEmail(String email) async {
    await NetworkClient.getRequest(url: Urls.recoverVerifyEmail(email));
  }
}
