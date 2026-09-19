class ChangePasswordEntity {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  ChangePasswordEntity({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      "current_password": currentPassword,
      "new_password": newPassword,
      "new_password_confirmation": confirmPassword,
    };
  }
}
