import 'package:core_hr/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core_hr/core/constants/app_text_style.dart';
import 'package:core_hr/core/constants/app_colors.dart';
import 'app_loading_indicator.dart';
import 'app_text.dart';

/// A custom button widget that follows the app's primary theme.
class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isLoading;

  /// Creates an [AppButton] with a required [title] and optional [onPressed] and [isLoading].
  const AppButton({
    super.key,
    required this.title,
    this.onPressed,
    this.isLoading = false,
  });

  /// Builds the button with a loading indicator or title text.
  @override
  Widget build(BuildContext context) {
    final Widget buttonContent = isLoading
        ? const AppLoadingIndicator(color: Colors.white)
        : AppText(
            title,
            style: AppTextStyle.bold16.copyWith(color: Colors.white),
          );

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.c003E99,
        foregroundColor: Colors.white,
        minimumSize: Size(Get.width, 55),
        padding: const EdgeInsets.symmetric(vertical: 16),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: isLoading
          ? null
          : () {
              AppConstants.hapticFeedBack();
              onPressed?.call();
            },
      child: buttonContent,
    );
  }
}
