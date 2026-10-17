import 'dart:io';

class UpdateProfileEntity {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final File? profilePhoto;

  const UpdateProfileEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.profilePhoto,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
    };
  }
}
