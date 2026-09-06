import 'package:core_hr/core/constants/shared_imports.dart';

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
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: const Text(
        StringConstants.kLogoutConfirmationMessage,
      ),
      actions: [
        AppTextButton(
          onPressed: onCancel ?? () => Get.back(),
          title: StringConstants.kCancel,
          style: const TextStyle(color: Colors.grey),
        ),
        AppButton(
          backgroundColor: const Color(0xFFEF4444),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          text: StringConstants.kLogout,
          onPressed: onConfirm,
        ),
      ],
    );
  }
}
