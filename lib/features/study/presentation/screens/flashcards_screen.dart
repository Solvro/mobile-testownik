import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/gradient_scaffold_background.dart';
import '../../data/study_mock_data.dart';
import '../widgets/flashcard_view.dart';
import '../widgets/quiz_ai_chat_sheet.dart';
import 'quiz_question_screen.dart';

class FlashcardsScreen extends StatefulWidget {
  const FlashcardsScreen({
    super.key,
    this.title,
  });

  final String? title;

  @override
  State<FlashcardsScreen> createState() => _FlashcardsScreenState();
}

class _FlashcardsScreenState extends State<FlashcardsScreen> {
  int _index = 0;
  bool _flipped = false;
  // MOCK DATA
  int _known = StudyMockData.initialKnownCount;
  // MOCK DATA
  int _again = StudyMockData.initialAgainCount;

  void _flip() {
    setState(() {
      _flipped = !_flipped;
    });
  }

  void _markKnown() {
    setState(() {
      _index++;
      _flipped = false;
      _known++;
    });
  }

  void _markAgain() {
    setState(() {
      _index++;
      _flipped = false;
      _again++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // MOCK DATA
    final String deckTitle =
        widget.title ?? StudyMockData.defaultFlashcardsTitle;
    // MOCK DATA
    final MockFlashcardItem card =
        StudyMockData.flashcards[_index % StudyMockData.flashcards.length];
    final int pos = _known + _again + 1;
    // MOCK DATA
    final double progress = (pos / StudyMockData.flashcardsTotal).clamp(0, 1);

    return Scaffold(
      body: GradientScaffoldBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          LucideIcons.x,
                          size: 20,
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
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            deckTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.labelSm.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            height: 22,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(
                                AppRadii.pill,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  LucideIcons.layers,
                                  size: 12,
                                  color: AppColors.accentForeground,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Tryb fiszek',
                                  style: AppTypography.caption.copyWith(
                                    color: AppColors.accentForeground,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute<void>(
                              builder: (_) => QuizQuestionScreen(
                                title: deckTitle,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          LucideIcons.bookOpen,
                          size: 20,
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
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              // MOCK DATA
                              'Karta $pos z ${StudyMockData.flashcardsTotal}',
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.labelSm,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    'Umiem: $_known',
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.labelSm.copyWith(
                                      color: AppColors.greenText,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Flexible(
                                  child: Text(
                                    'Powtórka: $_again',
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.labelSm.copyWith(
                                      color: AppColors.yellowText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadii.full),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 8,
                          backgroundColor: AppColors.muted,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: FlashcardView(
                    flipped: _flipped,
                    text: _flipped ? card.answer : card.question,
                    note: card.note,
                    onTap: _flip,
                  ),
                ),
                const SizedBox(height: 26),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: _markAgain,
                        child: Container(
                          height: 52,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(AppRadii.md),
                            border: Border.all(color: AppColors.border),
                            boxShadow: AppShadows.xs,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                LucideIcons.rotateCcw,
                                size: 18,
                                color: AppColors.foreground,
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  'Jeszcze nie',
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.labelSemiBold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: _markKnown,
                        child: Container(
                          height: 52,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(AppRadii.md),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                LucideIcons.check,
                                size: 18,
                                color: AppColors.primaryForeground,
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  'Umiem',
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.labelSemiBold.copyWith(
                                    color: AppColors.primaryForeground,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Center(
                  child: GestureDetector(
                    onTap: () => showQuizAiChatSheet(context),
                    child: Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppRadii.md),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            LucideIcons.sparkles,
                            size: 16,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Zapytaj AI o tę kartę',
                            style: AppTypography.labelSm.copyWith(
                              color: AppColors.accentForeground,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
