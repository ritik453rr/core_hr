import 'package:core_hr/core/constants/shared_imports.dart';

/// A confirmation dialog shown when a user attempts to log out.
class LogoutDialog extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;

  const LogoutDialog({
    super.key,
    this.onCancel,
    this.onConfirm,
  });

  static Future<T?> show<T>({
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
  }) {
    return Get.dialog<T>(
      LogoutDialog(
        onCancel: onCancel,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        StringConstants.kConfirmLogout,
        style: AppTextStyle.bold18,
      ),
      content: const Text(
        StringConstants.kLogoutConfirmationMessage,
        style: AppTextStyle.regular14,
      ),
      actions: [
        AppTextButton(
          onPressed: onCancel ?? () => Get.back(),
          title: StringConstants.kCancel,
          style: AppTextStyle.regular14Grey,
        ),
        AppButton(
          backgroundColor: AppColors.cF87171,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          text: StringConstants.kLogout,
          onPressed: onConfirm,
        ),
      ],
    );
  }
}
