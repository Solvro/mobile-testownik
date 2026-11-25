import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/gradient_scaffold_background.dart';
import '../../data/grades_mock_data.dart';
import '../widgets/grades_summary_card.dart';
import '../widgets/semester_grades_card.dart';

class GradesScreen extends StatefulWidget {
  const GradesScreen({super.key});

  @override
  State<GradesScreen> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
  // MOCK DATA
  late Set<int> _selectedIds = {...GradesMockData.initialSelectedSemesters};

  void _toggleSemester(int id) {
    final Set<int> next = {..._selectedIds};
    if (next.contains(id)) {
      if (next.length == 1) return;
      next.remove(id);
    } else {
      next.add(id);
    }
    setState(() {
      _selectedIds = next;
    });
  }

  String _formatAverage(List<MockSubjectGrade> subjects) {
    double weightedSum = 0;
    int ectsSum = 0;
    for (final s in subjects) {
      if (s.grade != null) {
        weightedSum += s.grade! * s.ects;
        ectsSum += s.ects;
      }
    }
    if (ectsSum == 0) return '—';
    return (weightedSum / ectsSum).toStringAsFixed(2).replaceAll('.', ',');
  }

  @override
  Widget build(BuildContext context) {
    // MOCK DATA
    final List<MockSemesterGrades> selectedSemesters = GradesMockData.semesters
        .where((s) => _selectedIds.contains(s.id))
        .toList();

    final List<MockSubjectGrade> allSubjects = [
      for (final sem in selectedSemesters) ...sem.subjects,
    ];

    int ectsTotal = 0;
    int gradedCount = 0;
    for (final s in allSubjects) {
      if (s.grade != null) {
        ectsTotal += s.ects;
        gradedCount++;
      }
    }

    final String semestersCaption = selectedSemesters.length == 1
        ? selectedSemesters.first.title
        : 'Semestry: ${selectedSemesters.map((s) => s.id).join(', ')}';

    return GradientScaffoldBackground(
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Oceny', style: AppTypography.headingLg),
                        const SizedBox(height: 2),
                        Text(
                          // MOCK DATA
                          GradesMockData.syncCaption,
                          style: AppTypography.captionRegular,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(AppRadii.md),
                      border: Border.all(color: AppColors.border),
                      boxShadow: AppShadows.xs,
                    ),
                    child: const Icon(
                      LucideIcons.rotateCcw,
                      size: 18,
                      color: AppColors.foreground,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  // MOCK DATA
                  for (final sem in GradesMockData.semesters)
                    _SemesterFilterChip(
                      label: sem.title,
                      selected: _selectedIds.contains(sem.id),
                      onTap: () => _toggleSemester(sem.id),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              GradesSummaryCard(
                averageText: _formatAverage(allSubjects),
                semestersCaption: semestersCaption,
                ectsText: '$ectsTotal',
                gradedText: '$gradedCount z ${allSubjects.length}',
              ),
              for (final sem in selectedSemesters) ...[
                const SizedBox(height: 20),
                SemesterGradesCard(
                  semester: sem,
                  averageText: _formatAverage(sem.subjects),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SemesterFilterChip extends StatelessWidget {
  const _SemesterFilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.background,
          borderRadius: BorderRadius.circular(AppRadii.full),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
          ),
          boxShadow: selected ? const [] : AppShadows.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected) ...[
              const Icon(
                LucideIcons.check,
                size: 14,
                color: AppColors.primaryForeground,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: AppTypography.labelSm.copyWith(
                color: selected
                    ? AppColors.primaryForeground
                    : AppColors.foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
