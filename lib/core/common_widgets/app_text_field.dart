import 'package:flutter/material.dart';
import 'package:core_hr/core/constants/app_colors.dart';
import 'package:core_hr/core/constants/app_font_size.dart';
import 'package:core_hr/core/constants/app_constants.dart';
import 'package:core_hr/core/extension/sized_box_extension.dart';
import 'package:core_hr/core/common_widgets/app_text.dart';

/// A reusable custom text field widget with label, validation, and styling options.
class AppTextField extends StatelessWidget {
  final String? title;
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autoValidateMode;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final TextInputAction? textInputAction;

  /// Creates an [AppTextField] with various configuration options for input handling.
  const AppTextField({
    super.key,
    this.title,
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.autoValidateMode,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.textInputAction,
  });

  /// Helper method to create a consistent [OutlineInputBorder].
  OutlineInputBorder _buildBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  /// Builds the text field with a labeled container and styled decoration.
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) ...[
          AppText(
            title!,
            style: const TextStyle(
              color: AppColors.c4B5563,
              fontWeight: FontWeight.w600,
              fontSize: AppFontSize.font14,
            ),
          ),
          8.h,
        ],
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          autovalidateMode: autoValidateMode,
          keyboardType: keyboardType,
          onTapOutside: (e) {
            AppConstants.hideKeyboard();
          },
          textInputAction: textInputAction,
          onFieldSubmitted: (textInputAction == TextInputAction.next
              ? (_) => FocusScope.of(context).nextFocus()
              : null),
          style: TextStyle(
            color: AppColors.c111827,
            fontSize: AppFontSize.font15,
            letterSpacing: obscureText ? 2 : null,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: AppColors.c6B7280,
              fontWeight: FontWeight.w400,
              letterSpacing: obscureText ? 2 : null,
            ),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: AppColors.c6B7280, size: 22)
                : null,
            suffixIcon: suffixIcon != null
                ? (onSuffixTap != null
                    ? GestureDetector(
                        onTap: onSuffixTap,
                        child: Icon(
                          suffixIcon,
                          color: AppColors.c6B7280,
                          size: 22,
                        ),
                      )
                    : Icon(suffixIcon, color: AppColors.c6B7280, size: 22))
                : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            enabledBorder: _buildBorder(AppColors.cCBD5E1),
            focusedBorder: _buildBorder(AppColors.c003E99, width: 2),
            errorBorder: _buildBorder(AppColors.cDC2626),
            focusedErrorBorder: _buildBorder(AppColors.cDC2626, width: 2),
          ),
        ),
      ],
    );
  }
}
