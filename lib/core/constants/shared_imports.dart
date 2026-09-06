/// Shared imports barrel file.
/// Import this single file to get access to the most commonly used
/// packages, theme helpers, constants, widgets, and utilities across the app.
library;

// Flutter SDK
export 'package:flutter/material.dart';

// State management
export 'package:get/get.dart';

// App theme
export 'package:core_hr/core/app_theme/app_colors.dart';

// Constants
export 'package:core_hr/core/constants/app_constants.dart';

// Localisation / strings
export 'package:core_hr/core/language/string_constants.dart';

// Routing
export 'package:core_hr/core/routing/app_routes.dart';

// Common widgets
export 'package:core_hr/core/common_widgets/common_widgets.dart';

// UI Helpers & Toasts
export 'package:toastification/toastification.dart';

// Dialogs
export 'package:core_hr/core/dialogs/logout_dialog.dart';
