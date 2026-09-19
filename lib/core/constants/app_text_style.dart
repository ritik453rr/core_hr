import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Centralized text styles used across the application for consistent typography.
class AppTextStyle {
  AppTextStyle._();

  // --- Primary Dark Styles (c111827 / c0F172A) ---

  static const TextStyle bold32 = TextStyle(
    color: AppColors.c111827,
    fontSize: 32,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
  );

  static const TextStyle bold18 = TextStyle(
    color: AppColors.c0F172A,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bold17 = TextStyle(
    color: AppColors.c0F172A,
    fontSize: 17,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bold16 = TextStyle(
    color: AppColors.c111827,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bold14 = TextStyle(
    color: AppColors.c0F172A,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle semiBold14 = TextStyle(
    color: AppColors.c111827,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle regular14 = TextStyle(
    color: AppColors.c111827,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  // --- Grey Styles (c4B5563 / c64748B) ---

  static const TextStyle regular16Grey = TextStyle(
    color: AppColors.c4B5563,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle semiBold14Grey = TextStyle(
    color: AppColors.c6B7280,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  static const TextStyle regular14Grey = TextStyle(
    color: AppColors.c64748B,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle regular13Grey = TextStyle(
    color: AppColors.c64748B,
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle regular12Grey = TextStyle(
    color: AppColors.c64748B,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle semiBold11Grey = TextStyle(
    color: AppColors.c64748B,
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );

  // --- White Styles ---

  static const TextStyle bold32White = TextStyle(
    color: AppColors.cFFFFFF,
    fontSize: 32,
    fontWeight: FontWeight.w900,
    letterSpacing: 3.0,
  );

  static const TextStyle bold18White = TextStyle(
    color: AppColors.cFFFFFF,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bold15White = TextStyle(
    color: AppColors.cFFFFFF,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle semiBold14White = TextStyle(
    color: AppColors.cFFFFFF,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bold11White = TextStyle(
    color: AppColors.cFFFFFF,
    fontSize: 11,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle regular11White60 = TextStyle(
    color: Color(0x99FFFFFF),
    fontSize: 11,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  // --- Blue / Accent Styles ---

  static const TextStyle semiBold12Blue = TextStyle(
    color: AppColors.c2563EB,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle medium13Blue = TextStyle(
    color: AppColors.cBAE6FD,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static const TextStyle bold11LightBlue = TextStyle(
    color: AppColors.c93C5FD,
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.0,
  );
}
