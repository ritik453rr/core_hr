import '../language/string_constants.dart';

/// Centralized validator utility for form field validations across the app.
class AppValidator {
  AppValidator._();

  /// Form field validator for email.
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return StringConstants.kEmailIsRequired;
    }
    final bool isValid = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z][a-zA-Z0-9.-]*\.[a-zA-Z]{2,}$',
    ).hasMatch(value.trim());

    if (!isValid) {
      return StringConstants.kEnterAValidEmail;
    }
    return null;
  }

  /// Form field validator for generic required fields.
  static String? validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return StringConstants.kFieldRequired;
    }
    return null;
  }
}
