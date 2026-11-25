import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_typography.dart';

class FlashcardView extends StatelessWidget {
  const FlashcardView({
    super.key,
    required this.flipped,
    required this.text,
    required this.note,
    required this.onTap,
  });

  final bool flipped;
  final String text;
  final String note;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: 14,
          right: 14,
          top: 14,
          bottom: -10,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(AppRadii.xxl),
              border: Border.all(
                color: AppColors.foreground.withValues(alpha: 0.06),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: flipped ? null : AppColors.card,
                gradient: flipped
                    ? const RadialGradient(
                        center: Alignment.topLeft,
                        radius: 1.4,
                        colors: [
                          AppColors.cardGradientFrom,
                          AppColors.cardGradientTo,
                        ],
                      )
                    : null,
                borderRadius: BorderRadius.circular(AppRadii.xxl),
                border: Border.all(color: AppColors.cardRing),
                boxShadow: AppShadows.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 22,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: flipped
                            ? AppColors.primary.withValues(alpha: 0.14)
                            : AppColors.muted,
                        borderRadius: BorderRadius.circular(AppRadii.pill),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            flipped ? 'Odpowiedź' : 'Pytanie',
                            style: AppTypography.caption.copyWith(
                              color: flipped
                                  ? AppColors.flashcardBackTagText
                                  : AppColors.accentForeground,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: AppTypography.heading.copyWith(
                            fontWeight: flipped
                                ? FontWeight.w700
                                : FontWeight.w600,
                            letterSpacing: -0.48,
                          ),
                        ),
                        if (flipped) ...[
                          const SizedBox(height: 12),
                          Text(
                            note,
                            style: AppTypography.bodyMd.copyWith(
                              height: 22 / 15,
                              color: AppColors.mutedForeground,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        LucideIcons.rotateCcw,
                        size: 14,
                        color: AppColors.mutedForeground,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Dotknij, aby odwrócić',
                        style: AppTypography.caption,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
