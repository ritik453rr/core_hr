import 'package:core_hr/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:core_hr/core/app_theme/app_colors.dart';

/// A reusable custom text field widget with label, validation, custom borders, icons, and styling options.
class AppTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final int? maxLines;
  final int? maxLength;
  final String? counterText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final TextAlign textAlign;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  const AppTextField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.autovalidateMode,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.maxLines = 1,
    this.maxLength,
    this.counterText,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.textAlign = TextAlign.start,
    this.style,
    this.hintStyle,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              color: AppColors.c4B5563,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          autovalidateMode: autovalidateMode,
          keyboardType: keyboardType,
          maxLines: maxLines,
          maxLength: maxLength,
          onChanged: onChanged,
          onTap: onTap,
          onTapOutside: (e) {
            AppConstants.hideKeyboard();
          },
          readOnly: readOnly,
          textAlign: textAlign,
          textInputAction: textInputAction,
          onFieldSubmitted:
              onFieldSubmitted ??
              (textInputAction == TextInputAction.next
                  ? (_) => FocusScope.of(context).nextFocus()
                  : null),
          style: style ??
              TextStyle(
                color: AppColors.c111827,
                fontSize: 15,
                letterSpacing: obscureText ? 2 : null,
              ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: hintStyle ??
                TextStyle(
                  color: AppColors.c6B7280,
                  fontWeight: FontWeight.w400,
                  letterSpacing: obscureText ? 2 : null,
                ),
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: AppColors.c6B7280,
                    size: 22,
                  )
                : null,
            suffixIcon: suffixIcon != null
                ? (onSuffixTap != null
                    ? IconButton(
                        icon: Icon(
                          suffixIcon,
                          color: AppColors.c6B7280,
                          size: 22,
                        ),
                        onPressed: onSuffixTap,
                      )
                    : Icon(
                        suffixIcon,
                        color: AppColors.c6B7280,
                        size: 22,
                      ))
                : null,
            counterText: counterText,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.cCBD5E1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.c003E99, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.cDC2626),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.cDC2626, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
