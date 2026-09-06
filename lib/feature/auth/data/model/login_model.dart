import 'dart:convert';

import 'package:core_hr/core/common_model/common_user_model.dart';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    String? message;
    String? token;
    CommonUserModel? user;

    LoginModel({
        this.message,
        this.token,
        this.user,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        message: json["message"],
        token: json["token"],
        user: json["user"] == null ? null : CommonUserModel.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "user": user?.toJson(),
    };
}

