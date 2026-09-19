import 'package:flutter/material.dart';

const Color _defaultPrimaryBlue = Color(0xFF003E99);

/// A reusable custom button widget supporting enable status, loading indicators, icons, and custom styling.
class AppButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback? onPressed;
  final bool enable;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? progressIndicatorColor;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double elevation;
  final double? width;
  final double? height;
  final TextStyle? textStyle;

  const AppButton({
    super.key,
    this.text,
    this.child,
    this.onPressed,
    this.enable = true,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
    this.progressIndicatorColor,
    this.padding,
    this.borderRadius = 8.0,
    this.elevation = 0,
    this.width,
    this.height,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final bool isButtonEnabled = enable && !isLoading && onPressed != null;

    final Widget buttonContent = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: progressIndicatorColor ?? Colors.white,
              strokeWidth: 2,
            ),
          )
        : (child ??
            (text != null
                ? Text(
                    text!,
                    style: textStyle ??
                        const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                  )
                : const SizedBox.shrink()));

    final Widget elevatedButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? _defaultPrimaryBlue,
        foregroundColor: foregroundColor ?? Colors.white,
        padding: padding ?? const EdgeInsets.symmetric(vertical: 16),
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: isButtonEnabled ? onPressed : null,
      child: buttonContent,
    );

    if (width != null || height != null) {
      return SizedBox(
        width: width,
        height: height,
        child: elevatedButton,
      );
    }

    return elevatedButton;
  }
}

/// Alias for AppButton to allow CommonButton & CustomButton usage.
typedef CommonButton = AppButton;
typedef CustomButton = AppButton;
