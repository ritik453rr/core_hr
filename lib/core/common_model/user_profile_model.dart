import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class UserProfileModel {
  String? message;
  UserProfileData? userProfileData;

  UserProfileModel({
    this.message,
    this.userProfileData,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
    message: json["message"],
    userProfileData: json["profile"] == null ? null : UserProfileData.fromJson(json["profile"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "profile": userProfileData?.toJson(),
  };
}

class UserProfileData {
  int? id;
  String? employeeCode;
  String? firstName;
  String? lastName;
  String? fullName;
  String? email;
  String? phoneCode;
  String? phone;
  dynamic profilePhoto;
  String? role;
  String? status;
  String? department;
  dynamic designation;
  String? branch;
  String? manager;
  Shift? shift;

  UserProfileData({
    this.id,
    this.employeeCode,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.phoneCode,
    this.phone,
    this.profilePhoto,
    this.role,
    this.status,
    this.department,
    this.designation,
    this.branch,
    this.manager,
    this.shift,
  });

  factory UserProfileData.fromJson(Map<String, dynamic> json) => UserProfileData(
    id: json["id"],
    employeeCode: json["employee_code"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    fullName: json["full_name"],
    email: json["email"],
    phoneCode: json["phone_code"],
    phone: json["phone"],
    profilePhoto: json["profile_photo"],
    role: json["role"],
    status: json["status"],
    department: json["department"],
    designation: json["designation"],
    branch: json["branch"],
    manager: json["manager"],
    shift: json["shift"] == null ? null : Shift.fromJson(json["shift"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_code": employeeCode,
    "first_name": firstName,
    "last_name": lastName,
    "full_name": fullName,
    "email": email,
    "phone_code": phoneCode,
    "phone": phone,
    "profile_photo": profilePhoto,
    "role": role,
    "status": status,
    "department": department,
    "designation": designation,
    "branch": branch,
    "manager": manager,
    "shift": shift?.toJson(),
  };
}

class Shift {
  String? name;
  String? startTime;
  String? endTime;

  Shift({
    this.name,
    this.startTime,
    this.endTime,
  });

  factory Shift.fromJson(Map<String, dynamic> json) => Shift(
    name: json["name"],
    startTime: json["start_time"],
    endTime: json["end_time"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "start_time": startTime,
    "end_time": endTime,
  };
}
