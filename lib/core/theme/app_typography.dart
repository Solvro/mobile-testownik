import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract final class AppTypography {
  static TextStyle _base({
    required double fontSize,
    required double height,
    required FontWeight fontWeight,
    Color color = AppColors.foreground,
    double? letterSpacing,
  }) {
    return GoogleFonts.hankenGrotesk(
      fontSize: fontSize,
      height: height / fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle get headingLg => _base(
    fontSize: 30,
    height: 36,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.75,
  );

  static TextStyle get heading => _base(
    fontSize: 24,
    height: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.6,
  );

  static TextStyle get headingSm => _base(
    fontSize: 20,
    height: 28,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get titleSm => _base(
    fontSize: 18,
    height: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.popoverForeground,
  );

  static TextStyle get label => _base(
    fontSize: 16,
    height: 22,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get labelSemiBold => _base(
    fontSize: 16,
    height: 22,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get body => _base(
    fontSize: 16,
    height: 24,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get bodyMd => _base(
    fontSize: 15,
    height: 21,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get labelMd => _base(
    fontSize: 15,
    height: 20,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get labelSm => _base(
    fontSize: 14,
    height: 20,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get sectionTitle => _base(
    fontSize: 14,
    height: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.mutedForeground,
  );

  static TextStyle get bodySm => _base(
    fontSize: 14,
    height: 20,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get caption => _base(
    fontSize: 12,
    height: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.mutedForeground,
  );

  static TextStyle get captionRegular => _base(
    fontSize: 12,
    height: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.mutedForeground,
  );
}
