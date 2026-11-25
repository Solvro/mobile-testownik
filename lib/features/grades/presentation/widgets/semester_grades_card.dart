import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/dashed_border_container.dart';
import '../../../../core/widgets/surface_card.dart';
import '../../data/grades_mock_data.dart';
import 'course_type_badge.dart';

class SemesterGradesCard extends StatelessWidget {
  const SemesterGradesCard({
    super.key,
    required this.semester,
    required this.averageText,
  });

  final MockSemesterGrades semester;
  final String averageText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(
                  text: semester.title,
                  style: AppTypography.labelSemiBold.copyWith(height: 24 / 16),
                  children: [
                    TextSpan(
                      text: ' · ${semester.period}',
                      style: AppTypography.bodySm.copyWith(
                        color: AppColors.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'śr. $averageText',
              style: AppTypography.labelSm.copyWith(
                color: AppColors.mutedForeground,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SurfaceCard(
          child: Column(
            children: [
              for (int i = 0; i < semester.subjects.length; i++)
                _SubjectGradeRow(
                  subject: semester.subjects[i],
                  showDivider: i < semester.subjects.length - 1,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SubjectGradeRow extends StatelessWidget {
  const _SubjectGradeRow({
    required this.subject,
    required this.showDivider,
  });

  final MockSubjectGrade subject;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final double? grade = subject.grade;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        border: showDivider
            ? Border(bottom: BorderSide(color: AppColors.divider))
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subject.name,
                  style: AppTypography.labelMd,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    for (int i = 0; i < subject.types.length; i++) ...[
                      if (i > 0) const SizedBox(width: 4),
                      CourseTypeBadge(letter: subject.types[i]),
                    ],
                    const SizedBox(width: 8),
                    Text(
                      '${subject.ects} ECTS',
                      style: AppTypography.captionRegular,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          if (grade != null)
            Container(
              constraints: const BoxConstraints(minWidth: 48),
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(AppRadii.md),
              ),
              alignment: Alignment.center,
              child: Text(
                grade.toStringAsFixed(1).replaceAll('.', ','),
                style: AppTypography.label.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.secondaryForeground,
                ),
              ),
            )
          else
            DashedBorderContainer(
              borderRadius: AppRadii.md,
              dashWidth: 4,
              dashGap: 3,
              child: Container(
                constraints: const BoxConstraints(minWidth: 48),
                height: 32,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                child: Text(
                  'Brak',
                  style: AppTypography.caption,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
