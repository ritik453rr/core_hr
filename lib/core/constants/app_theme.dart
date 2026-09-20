import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Centralized application theme configuration (light theme only).
class AppTheme {
  AppTheme._();

  /// Defines the light theme for the application, setting scaffoldBackgroundColor and app-wide colors.
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.cF8FAFC,
    );
  }
}
