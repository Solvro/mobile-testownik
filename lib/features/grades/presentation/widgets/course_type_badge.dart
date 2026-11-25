import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_typography.dart';

class CourseTypeBadge extends StatelessWidget {
  const CourseTypeBadge({
    super.key,
    required this.letter,
  });

  final String letter;

  @override
  Widget build(BuildContext context) {
    final (Color accent, Color textColor) = switch (letter) {
      'W' => (AppColors.red500, AppColors.red600),
      'C' => (AppColors.green500, AppColors.green600),
      'L' => (AppColors.blue500, AppColors.blue600),
      'P' => (AppColors.fuchsia500, AppColors.fuchsia600),
      _ => (AppColors.gray500, AppColors.gray600),
    };

    return Container(
      constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: accent),
      ),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: AppTypography.caption.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
