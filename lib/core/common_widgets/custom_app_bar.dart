import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core_hr/core/constants/app_colors.dart';
import 'package:core_hr/core/constants/app_text_style.dart';
import 'package:core_hr/core/common_widgets/app_text.dart';

/// Reusable custom app bar supporting dynamic title and optional back button.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.onBackPressed,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 18,
              ),
              onPressed: onBackPressed ?? () => Get.back(),
            )
          : null,
      titleSpacing: showBackButton ? 0 : 16,
      title: AppText(
        title,
        style: AppTextStyle.bold18White,
      ),
      backgroundColor: AppColors.c0F172A,
      elevation: 0,
      actions: actions,
    );
  }
}
