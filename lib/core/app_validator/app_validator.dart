/// Centralized validator utility for form field validations across the app.
class AppValidator {
  AppValidator._();

  /// Form field validator for email.
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }
    final bool isValid = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z][a-zA-Z0-9.-]*\.[a-zA-Z]{2,}$',
    ).hasMatch(value.trim());

    if (!isValid) {
      return "Please enter a valid email address";
    }
    return null;
  }

  /// Form field validator for generic required fields.
  static String? validateRequired(String? value, [String fieldName = 'Field']) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }
}
