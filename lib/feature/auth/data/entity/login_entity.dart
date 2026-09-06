/// Represents login credentials.
class LoginEntity {
  /// Creates a login entity.
  const LoginEntity({
    required this.email,
    required this.password,
  });

  /// User email address.
  final String email;

  /// User password.
  final String password;

  /// Converts the login entity to JSON.
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}