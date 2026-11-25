import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/surface_card.dart';
import '../../data/quizzes_mock_data.dart';

class QuizListTile extends StatelessWidget {
  const QuizListTile({
    super.key,
    required this.quiz,
    required this.onTap,
    required this.onMenuTap,
    this.onLongPress,
  });

  final MockQuizRow quiz;
  final VoidCallback onTap;
  final VoidCallback onMenuTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress ?? onMenuTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 6, 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quiz.title,
                      style: AppTypography.label,
                    ),
                    SizedBox(height: quiz.progressPercent != null ? 6 : 2),
                    if (quiz.progressPercent != null)
                      Row(
                        children: [
                          SizedBox(
                            width: 72,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                AppRadii.full,
                              ),
                              child: LinearProgressIndicator(
                                value: quiz.progressPercent! / 100,
                                minHeight: 4,
                                backgroundColor: AppColors.muted,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              quiz.meta,
                              style: AppTypography.captionRegular,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      )
                    else
                      Text(
                        quiz.meta,
                        style: AppTypography.captionRegular,
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              SizedBox(
                width: 40,
                height: 40,
                child: IconButton(
                  onPressed: onMenuTap,
                  icon: const Icon(
                    LucideIcons.ellipsisVertical,
                    size: 18,
                    color: AppColors.mutedForeground,
                  ),
                  padding: EdgeInsets.zero,
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadii.md),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
