import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/gradient_scaffold_background.dart';
import '../../../../core/widgets/surface_card.dart';
import '../../../study/presentation/screens/quiz_question_screen.dart';
import '../../data/quizzes_mock_data.dart';
import '../widgets/archive_banner_tile.dart';
import '../widgets/folder_list_tile.dart';
import '../widgets/quiz_list_tile.dart';
import '../widgets/quiz_mode_sheet.dart';
import '../widgets/recent_quiz_card.dart';

class QuizzesScreen extends StatelessWidget {
  const QuizzesScreen({
    super.key,
    required this.onOpenFolder,
  });

  final ValueChanged<MockFolderItem> onOpenFolder;

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
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Quizy', style: AppTypography.headingLg),
                    Row(
                      children: [
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
                            LucideIcons.search,
                            size: 18,
                            color: AppColors.foreground,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(AppRadii.md),
                          ),
                          child: const Icon(
                            LucideIcons.plus,
                            size: 18,
                            color: AppColors.primaryForeground,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Ostatnio uczone',
                  style: AppTypography.sectionTitle,
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(20, 2, 20, 6),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // MOCK DATA
                      for (
                        int i = 0;
                        i < QuizzesMockData.recentQuizzes.length;
                        i++
                      ) ...[
                        if (i > 0) const SizedBox(width: 12),
                        RecentQuizCard(
                          quiz: QuizzesMockData.recentQuizzes[i],
                          onTap: () => _openQuiz(
                            context,
                            QuizzesMockData.recentQuizzes[i].title,
                          ),
                          onLongPress: () => showQuizModeSheet(
                            context,
                            quizTitle: QuizzesMockData.recentQuizzes[i].title,
                            quizMeta:
                                '${QuizzesMockData.recentQuizzes[i].subtitle} · ${QuizzesMockData.recentQuizzes[i].masteredPercent}% opanowane',
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Foldery', style: AppTypography.sectionTitle),
                    const SizedBox(height: 12),
                    SurfaceCard(
                      child: Column(
                        children: [
                          // MOCK DATA
                          for (
                            int i = 0;
                            i < QuizzesMockData.folders.length;
                            i++
                          )
                            FolderListTile(
                              folder: QuizzesMockData.folders[i],
                              showDivider:
                                  i < QuizzesMockData.folders.length - 1,
                              onTap: () =>
                                  onOpenFolder(QuizzesMockData.folders[i]),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Pozostałe quizy',
                          style: AppTypography.sectionTitle,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                LucideIcons.layers,
                                size: 12,
                                color: AppColors.mutedForeground,
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  'Przytrzymaj, by uczyć się fiszkami',
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.captionRegular,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // MOCK DATA
                    for (
                      int i = 0;
                      i < QuizzesMockData.otherQuizzes.length;
                      i++
                    ) ...[
                      if (i > 0) const SizedBox(height: 8),
                      QuizListTile(
                        quiz: QuizzesMockData.otherQuizzes[i],
                        onTap: () => showQuizModeSheet(
                          context,
                          quizTitle: QuizzesMockData.otherQuizzes[i].title,
                          quizMeta: QuizzesMockData.otherQuizzes[i].sheetMeta,
                        ),
                        onMenuTap: () => showQuizModeSheet(
                          context,
                          quizTitle: QuizzesMockData.otherQuizzes[i].title,
                          quizMeta: QuizzesMockData.otherQuizzes[i].sheetMeta,
                        ),
                      ),
                    ],
                    const SizedBox(height: 28),
                    const ArchiveBannerTile(
                      // MOCK DATA
                      subtitle: QuizzesMockData.archiveSubtitle,
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
