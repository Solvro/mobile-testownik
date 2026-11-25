import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/gradient_scaffold_background.dart';
import '../../../study/presentation/screens/quiz_question_screen.dart';
import '../../data/quizzes_mock_data.dart';
import '../widgets/quiz_list_tile.dart';
import '../widgets/quiz_mode_sheet.dart';

class FolderScreen extends StatelessWidget {
  const FolderScreen({
    super.key,
    required this.folder,
    required this.onBack,
  });

  final MockFolderItem folder;
  final VoidCallback onBack;

  void _openQuiz(BuildContext context, String title) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => QuizQuestionScreen(title: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffoldBackground(
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: onBack,
                    behavior: HitTestBehavior.opaque,
                    child: SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            LucideIcons.chevronLeft,
                            size: 20,
                            color: AppColors.accentForeground,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            'Quizy',
                            style: AppTypography.label.copyWith(
                              color: AppColors.accentForeground,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        LucideIcons.ellipsisVertical,
                        size: 18,
                        color: AppColors.foreground,
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
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(AppRadii.xl),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      LucideIcons.folder,
                      size: 24,
                      color: AppColors.accentForeground,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          folder.name,
                          style: AppTypography.heading,
                        ),
                        Text(
                          folder.detailsMeta,
                          style: AppTypography.bodySm.copyWith(
                            color: AppColors.mutedForeground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(AppRadii.md),
                  border: Border.all(color: AppColors.border),
                  boxShadow: AppShadows.xs,
                ),
                child: TextField(
                  style: AppTypography.body,
                  decoration: InputDecoration(
                    hintText: 'Szukaj w folderze',
                    hintStyle: AppTypography.body.copyWith(
                      color: AppColors.mutedForeground.withValues(alpha: 0.7),
                    ),
                    prefixIcon: const Icon(
                      LucideIcons.search,
                      size: 16,
                      color: AppColors.mutedForeground,
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 38,
                      minHeight: 40,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // MOCK DATA
              for (
                int i = 0;
                i < QuizzesMockData.folderQuizzes.length;
                i++
              ) ...[
                if (i > 0) const SizedBox(height: 8),
                QuizListTile(
                  quiz: QuizzesMockData.folderQuizzes[i],
                  onTap: () => _openQuiz(
                    context,
                    QuizzesMockData.folderQuizzes[i].title,
                  ),
                  onMenuTap: () => showQuizModeSheet(
                    context,
                    quizTitle: QuizzesMockData.folderQuizzes[i].title,
                    quizMeta: QuizzesMockData.folderQuizzes[i].sheetMeta,
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
