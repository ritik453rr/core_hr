import 'package:core_hr/core/constants/shared_imports.dart';

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
        ? const AppLoadingIndicator(color: Colors.white, radius: 12)
        : Text(title, style: AppTextStyle.bold16.copyWith(color: Colors.white));

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.c003E99,
        disabledBackgroundColor: AppColors.c003E99,
        foregroundColor: Colors.white,
        minimumSize: Size(Get.width, 50),
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
