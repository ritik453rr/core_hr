import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Stores environment keys used in the application.
class AppKeys {
  /// Production base URL key
  static String get apiBaseUrl => dotenv.env["DEV_API_BASE_URL"] ?? "";
}
