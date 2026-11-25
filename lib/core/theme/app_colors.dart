import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color background = Color(0xFFFFFFFF);
  static const Color foreground = Color(0xFF121721);
  static const Color card = Color(0xFFFCFCFC);
  static const Color cardForeground = Color(0xFF1B2232);
  static const Color popover = Color(0xFFFFFFFF);
  static const Color popoverForeground = Color(0xFF242E42);
  static const Color primary = Color(0xFF3B7FE7);
  static const Color primaryForeground = Color(0xFFF3F5F8);
  static const Color secondary = Color(0xFFE6EBEF);
  static const Color secondaryForeground = Color(0xFF242D42);
  static const Color muted = Color(0xFFD9E5F2);
  static const Color mutedForeground = Color(0xFF3D5275);
  static const Color accent = Color(0xFFE7EFF7);
  static const Color accentForeground = Color(0xFF354664);
  static const Color destructive = Color(0xFFE7000B);
  static const Color border = Color(0xFFC6D5EC);
  static const Color input = Color(0xFFEFF2F5);
  static const Color ring = Color(0xFF799DD2);

  static const Color cardGradientFrom = Color(0xFFFFFFFF);
  static const Color cardGradientTo = Color(0xFFE5F0FF);
  static const Color ctaGradientFrom = Color(0xFF408CFF);
  static const Color ctaGradientTo = Color(0xFF1D5BB9);
  static const Color backgroundGradientFrom = Color(0xFFA9C4EB);
  static const Color backgroundGradientTo = Color(0xFFD2DAE5);

  static const Color green500 = Color(0xFF00C950);
  static const Color green600 = Color(0xFF00A63E);
  static const Color greenText = Color(0xFF00682A);

  static const Color yellow500 = Color(0xFFF0B100);
  static const Color yellow600 = Color(0xFFD08700);
  static const Color yellowText = Color(0xFF8A5700);

  static const Color red500 = Color(0xFFFB2C36);
  static const Color red600 = Color(0xFFE7000B);
  static const Color redText = Color(0xFFC10007);

  static const Color emerald500 = Color(0xFF00BC7D);
  static const Color emerald600 = Color(0xFF009966);
  static const Color emeraldText = Color(0xFF006743);

  static const Color blue500 = Color(0xFF2B7FFF);
  static const Color blue600 = Color(0xFF155DFC);

  static const Color fuchsia500 = Color(0xFFE12AFB);
  static const Color fuchsia600 = Color(0xFFC800DE);

  static const Color gray500 = Color(0xFF6A7282);
  static const Color gray600 = Color(0xFF4A5565);

  static const Color navActiveIcon = Color(0xFF1A5EC2);
  static const Color flashcardBackTagText = Color(0xFF1851A6);

  static Color get cardRing => foreground.withValues(alpha: 0.1);
  static Color get subtleRing => foreground.withValues(alpha: 0.08);
  static Color get divider => border.withValues(alpha: 0.6);
  static Color get navBorder => border.withValues(alpha: 0.7);
}
