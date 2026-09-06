import 'dart:convert';

import 'package:core_hr/core/common_model/common_user_model.dart';
import 'package:core_hr/core/routing/app_routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// Handles local storage operations for authentication, tokens, and user session management.
class AppStorage {
  static final _storage = GetStorage();

  //Keys
  static const String authToken = "authToken";
  static const String userProfile = "userProfile";
  static const String loginStatus = "loginStatus";

  static void saveLoginStatus(bool value) {
    _storage.write(loginStatus, value);
  }

  static bool getLoginStatus() {
    return _storage.read(loginStatus) ?? false;
  }

  static void saveAuthToken(String value) {
    _storage.write(authToken, value);
  }

  /// Returns auth token
  static String getAuthToken() {
    return _storage.read(authToken) ?? "";
  }

  static void saveUserProfile(CommonUserModel? user) {
    if (user == null) return;
    final userDataString = jsonEncode(user.toJson());
    _storage.write(userProfile, userDataString);
  }

  /// Returns the user profile from local storage
  static CommonUserModel? getUserProfile() {
    final userDataString = _storage.read(userProfile) ?? "";
    if (userDataString.isEmpty) return null;
    return CommonUserModel.fromJson(jsonDecode(userDataString));
  }

  /// Clears user session / logout
  static void logOut() {
    _storage.erase();
    Get.offAllNamed(AppRoutes.login);  
  }
}
