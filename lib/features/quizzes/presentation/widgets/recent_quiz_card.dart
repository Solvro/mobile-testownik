import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/surface_card.dart';
import '../../data/quizzes_mock_data.dart';

class RecentQuizCard extends StatelessWidget {
  const RecentQuizCard({
    super.key,
    required this.quiz,
    required this.onTap,
    this.onLongPress,
  });

  final MockRecentQuiz quiz;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final Color buttonBg = quiz.isPrimaryFeatured
        ? AppColors.primary
        : AppColors.secondary;
    final Color buttonFg = quiz.isPrimaryFeatured
        ? AppColors.primaryForeground
        : AppColors.secondaryForeground;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: SizedBox(
        width: 236,
        child: SurfaceCard(
          useGradient: quiz.isPrimaryFeatured,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quiz.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.labelSemiBold.copyWith(
                      color: AppColors.cardForeground,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    quiz.subtitle,
                    style: AppTypography.captionRegular,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Opanowane',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.foreground,
                        ),
                      ),
                      Text(
                        '${quiz.masteredPercent}%',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.foreground,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadii.full),
                    child: LinearProgressIndicator(
                      value: quiz.masteredPercent / 100,
                      minHeight: 6,
                      backgroundColor: AppColors.muted,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                height: 32,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: buttonBg,
                  borderRadius: BorderRadius.circular(AppRadii.md),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      LucideIcons.play,
                      size: 14,
                      color: buttonFg,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Kontynuuj',
                      style: AppTypography.labelSm.copyWith(color: buttonFg),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
