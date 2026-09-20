import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_font_size.dart';

/// Centralized text styles used across the application for consistent typography.
class AppTextStyle {
  AppTextStyle._();



  static const TextStyle bold32 = TextStyle(
    color: AppColors.c111827,
    fontSize: AppFontSize.font32,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
  );

  static const TextStyle bold18 = TextStyle(
    color: AppColors.c0F172A,
    fontSize: AppFontSize.font18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bold17 = TextStyle(
    color: AppColors.c0F172A,
    fontSize: AppFontSize.font17,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bold16 = TextStyle(
    color: AppColors.c111827,
    fontSize: AppFontSize.font16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bold14 = TextStyle(
    color: AppColors.c0F172A,
    fontSize: AppFontSize.font14,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle semiBold14 = TextStyle(
    color: AppColors.c111827,
    fontSize: AppFontSize.font14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle regular14 = TextStyle(
    color: AppColors.c111827,
    fontSize: AppFontSize.font14,
    fontWeight: FontWeight.w400,
  );

  // --- Grey Styles (c4B5563 / c64748B) ---

  static const TextStyle regular16Grey = TextStyle(
    color: AppColors.c4B5563,
    fontSize: AppFontSize.font16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle semiBold14Grey = TextStyle(
    color: AppColors.c6B7280,
    fontWeight: FontWeight.w600,
    fontSize: AppFontSize.font14,
  );

  static const TextStyle regular14Grey = TextStyle(
    color: AppColors.c64748B,
    fontSize: AppFontSize.font14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle regular13Grey = TextStyle(
    color: AppColors.c64748B,
    fontSize: AppFontSize.font13,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle regular12Grey = TextStyle(
    color: AppColors.c64748B,
    fontSize: AppFontSize.font12,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle semiBold11Grey = TextStyle(
    color: AppColors.c64748B,
    fontSize: AppFontSize.font11,
    fontWeight: FontWeight.w600,
  );

  // --- White Styles ---

  static const TextStyle bold32White = TextStyle(
    color: AppColors.cFFFFFF,
    fontSize: AppFontSize.font32,
    fontWeight: FontWeight.w900,
    letterSpacing: 3.0,
  );

  static const TextStyle bold18White = TextStyle(
    color: AppColors.cFFFFFF,
    fontSize: AppFontSize.font18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bold15White = TextStyle(
    color: AppColors.cFFFFFF,
    fontSize: AppFontSize.font15,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle semiBold14White = TextStyle(
    color: AppColors.cFFFFFF,
    fontSize: AppFontSize.font14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bold11White = TextStyle(
    color: AppColors.cFFFFFF,
    fontSize: AppFontSize.font11,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle regular11White60 = TextStyle(
    color: Color(0x99FFFFFF),
    fontSize: AppFontSize.font11,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  // --- Blue / Accent Styles ---

  static const TextStyle semiBold12Blue = TextStyle(
    color: AppColors.c2563EB,
    fontSize: AppFontSize.font12,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle medium13Blue = TextStyle(
    color: AppColors.cBAE6FD,
    fontSize: AppFontSize.font13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static const TextStyle bold11LightBlue = TextStyle(
    color: AppColors.c93C5FD,
    fontSize: AppFontSize.font11,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.0,
  );
}
