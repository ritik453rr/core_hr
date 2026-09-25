import 'dart:convert';
import 'package:core_hr/core/common_model/user_profile_model.dart';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(jsonDecode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? message;
  String? token;
  UserProfileData? userProfileData;

  LoginModel({this.message, this.token, this.userProfileData});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    message: json["message"],
    token: json["token"],
    userProfileData: json["user"] == null
        ? null
        : UserProfileData.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "token": token,
    "user": userProfileData?.toJson(),
  };
}
