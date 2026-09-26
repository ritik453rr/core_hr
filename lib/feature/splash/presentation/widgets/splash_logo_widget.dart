import 'package:flutter/material.dart';
import 'package:core_hr/core/constants/app_assets.dart';
import 'package:core_hr/core/constants/app_colors.dart';

/// Reusable animated logo widget used in the Splash screen.
class SplashLogoWidget extends StatelessWidget {
  const SplashLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.c2563EB.withValues(alpha: 0.05),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.cE2E8F0, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Image.asset(
            AppAssets.appIcon,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
