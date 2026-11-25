import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/surface_card.dart';

class GradesSummaryCard extends StatelessWidget {
  const GradesSummaryCard({
    super.key,
    required this.averageText,
    required this.semestersCaption,
    required this.ectsText,
    required this.gradedText,
  });

  final String averageText;
  final String semestersCaption;
  final String ectsText;
  final String gradedText;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      useGradient: true,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Średnia ważona',
                    style: AppTypography.labelSm.copyWith(
                      color: AppColors.mutedForeground,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    averageText,
                    style: AppTypography.headingLg.copyWith(
                      fontSize: 44,
                      height: 48 / 44,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1.1,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    'ważona punktami ECTS\n$semestersCaption',
                    textAlign: TextAlign.right,
                    style: AppTypography.captionRegular,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  label: 'Punkty ECTS',
                  value: ectsText,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _StatTile(
                  label: 'Przedmioty z oceną',
                  value: gradedText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: AppColors.subtleRing),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTypography.captionRegular),
          Text(
            value,
            style: AppTypography.titleSm.copyWith(
              height: 26 / 18,
              fontWeight: FontWeight.w700,
              color: AppColors.foreground,
            ),
          ),
        ],
      ),
    );
  }
}
