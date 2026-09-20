import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import 'app_text.dart';

/// A customizable TextButton with left alignment, compact sizing, and built-in haptic feedback.
class AppTextButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final TextStyle? style;

  const AppTextButton({
    super.key,
    required this.title,
    this.onPressed,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, 0),
      ),
      onPressed: () {
        AppConstants.hapticFeedBack();
        onPressed?.call();
      },
      child: AppText(title, style: style),
    );
  }
}
