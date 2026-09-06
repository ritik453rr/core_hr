class CommonUserModel {
    int? id;
    String? firstName;
    String? lastName;
    String? fullName;
    String? email;
    String? phoneCode;
    String? phone;
    String? status;
    String? role;

    CommonUserModel({
        this.id,
        this.firstName,
        this.lastName,
        this.fullName,
        this.email,
        this.phoneCode,
        this.phone,
        this.status,
        this.role,
    });

    factory CommonUserModel.fromJson(Map<String, dynamic> json) => CommonUserModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        fullName: json["full_name"],
        email: json["email"],
        phoneCode: json["phone_code"],
        phone: json["phone"],
        status: json["status"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "full_name": fullName,
        "email": email,
        "phone_code": phoneCode,
        "phone": phone,
        "status": status,
        "role": role,
    };
}
