import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_typography.dart';

enum QuizAnswerVisualState {
  idle,
  selected,
  correctChosen,
  correctMissed,
  wrongChosen,
  faded,
}

class QuizAnswerOption extends StatelessWidget {
  const QuizAnswerOption({
    super.key,
    required this.letter,
    required this.text,
    required this.visualState,
    required this.onTap,
  });

  final String letter;
  final String text;
  final QuizAnswerVisualState visualState;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor;
    final Color borderColor;
    final List<BoxShadow> boxShadow;
    final String? tag;
    final Color? tagColor;
    final double opacity;

    switch (visualState) {
      case QuizAnswerVisualState.idle:
        backgroundColor = AppColors.input;
        borderColor = AppColors.input;
        boxShadow = const [];
        tag = null;
        tagColor = null;
        opacity = 1;
      case QuizAnswerVisualState.selected:
        backgroundColor = AppColors.accent;
        borderColor = AppColors.primary;
        boxShadow = [
          BoxShadow(
            color: AppColors.ring.withValues(alpha: 0.5),
            spreadRadius: 3,
          ),
        ];
        tag = null;
        tagColor = null;
        opacity = 1;
      case QuizAnswerVisualState.correctChosen:
        backgroundColor = AppColors.green500.withValues(alpha: 0.15);
        borderColor = AppColors.green500;
        boxShadow = const [];
        tag = 'Twoja – poprawna';
        tagColor = AppColors.greenText;
        opacity = 1;
      case QuizAnswerVisualState.correctMissed:
        backgroundColor = AppColors.yellow500.withValues(alpha: 0.15);
        borderColor = AppColors.yellow500;
        boxShadow = const [];
        tag = 'Poprawna';
        tagColor = AppColors.yellowText;
        opacity = 1;
      case QuizAnswerVisualState.wrongChosen:
        backgroundColor = AppColors.red500.withValues(alpha: 0.15);
        borderColor = AppColors.red500;
        boxShadow = const [];
        tag = 'Twoja';
        tagColor = AppColors.redText;
        opacity = 1;
      case QuizAnswerVisualState.faded:
        backgroundColor = AppColors.input;
        borderColor = AppColors.input;
        boxShadow = const [];
        tag = null;
        tagColor = null;
        opacity = 0.6;
    }

    return Opacity(
      opacity: opacity,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          constraints: const BoxConstraints(minHeight: 52),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppRadii.md),
            border: Border.all(color: borderColor),
            boxShadow: boxShadow,
          ),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.subtleRing),
                ),
                alignment: Alignment.center,
                child: Text(
                  letter,
                  style: AppTypography.caption.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accentForeground,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: AppTypography.bodyMd,
                ),
              ),
              if (tag != null) ...[
                const SizedBox(width: 8),
                Text(
                  tag,
                  style: AppTypography.caption.copyWith(
                    fontWeight: FontWeight.w600,
                    color: tagColor,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
