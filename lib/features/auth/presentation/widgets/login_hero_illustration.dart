import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_typography.dart';
import '../../data/auth_mock_data.dart';

class LoginHeroIllustration extends StatelessWidget {
  const LoginHeroIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 26,
            top: 6,
            child: Transform.rotate(
              angle: -6 * math.pi / 180,
              child: Container(
                width: 248,
                height: 250,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(AppRadii.xl),
                  border: Border.all(color: AppColors.subtleRing),
                ),
              ),
            ),
          ),
          Positioned(
            left: 14,
            top: 22,
            child: Container(
              width: 272,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(AppRadii.xl),
                border: Border.all(color: AppColors.cardRing),
                boxShadow: AppShadows.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    // MOCK DATA
                    AuthMockData.previewQuestionCounter,
                    style: AppTypography.caption,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    // MOCK DATA
                    AuthMockData.previewQuestionText,
                    style: AppTypography.bodyMd.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // MOCK DATA
                  for (int i = 0; i < AuthMockData.previewAnswers.length; i++) ...[
                    if (i > 0) const SizedBox(height: 6),
                    _PreviewAnswerTile(
                      text: AuthMockData.previewAnswers[i].text,
                      isCorrect: AuthMockData.previewAnswers[i].isCorrect,
                    ),
                  ],
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppRadii.pill),
                border: Border.all(color: AppColors.cardRing),
                boxShadow: AppShadows.md,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    LucideIcons.sparkles,
                    size: 14,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Zapytaj AI',
                    style: AppTypography.caption.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.foreground,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewAnswerTile extends StatelessWidget {
  const _PreviewAnswerTile({
    required this.text,
    required this.isCorrect,
  });

  final String text;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isCorrect
            ? AppColors.green500.withValues(alpha: 0.15)
            : AppColors.input,
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(
          color: isCorrect ? AppColors.green500 : AppColors.input,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.bodySm.copyWith(fontSize: 13),
            ),
          ),
          if (isCorrect) ...[
            const SizedBox(width: 8),
            Text(
              'Poprawna!',
              style: AppTypography.caption.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.greenText,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
