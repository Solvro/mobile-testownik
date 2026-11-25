import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/gradient_scaffold_background.dart';
import '../../../../core/widgets/surface_card.dart';
import '../../data/study_mock_data.dart';
import '../widgets/connection_status_pill.dart';
import '../widgets/quiz_ai_chat_sheet.dart';
import '../widgets/quiz_answer_option.dart';
import 'flashcards_screen.dart';

class QuizQuestionScreen extends StatefulWidget {
  const QuizQuestionScreen({
    super.key,
    this.title,
  });

  final String? title;

  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  String? _selectedId;
  bool _checked = false;

  void _selectAnswer(String id) {
    if (_checked) return;
    setState(() {
      _selectedId = id;
    });
  }

  void _checkAnswer() {
    if (_selectedId == null) return;
    setState(() {
      _checked = true;
    });
  }

  void _nextQuestion() {
    setState(() {
      _selectedId = null;
      _checked = false;
    });
  }

  QuizAnswerVisualState _visualStateFor(String id) {
    final bool isChosen = _selectedId == id;
    // MOCK DATA
    final bool isCorrect = id == StudyMockData.correctAnswerId;

    if (!_checked) {
      return isChosen
          ? QuizAnswerVisualState.selected
          : QuizAnswerVisualState.idle;
    }

    if (isCorrect && isChosen) return QuizAnswerVisualState.correctChosen;
    if (isCorrect) return QuizAnswerVisualState.correctMissed;
    if (isChosen) return QuizAnswerVisualState.wrongChosen;
    return QuizAnswerVisualState.faded;
  }

  @override
  Widget build(BuildContext context) {
    // MOCK DATA
    final String quizTitle = widget.title ?? StudyMockData.defaultQuizTitle;
    // MOCK DATA
    final bool isCorrect = _selectedId == StudyMockData.correctAnswerId;
    final double safeBottom = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      body: GradientScaffoldBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
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
                                  borderRadius: BorderRadius.circular(
                                    AppRadii.md,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  quizTitle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.labelSm.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const ConnectionStatusPill(),
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
                                    builder: (_) => FlashcardsScreen(
                                      title: quizTitle,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                LucideIcons.layers,
                                size: 20,
                                color: AppColors.foreground,
                              ),
                              padding: EdgeInsets.zero,
                              style: IconButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppRadii.md,
                                  ),
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
                                    StudyMockData.questionProgressLabel,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.labelSm,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    // MOCK DATA
                                    StudyMockData.masteredLabel,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.labelSm.copyWith(
                                      color: AppColors.mutedForeground,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                AppRadii.full,
                              ),
                              child: const LinearProgressIndicator(
                                // MOCK DATA
                                value: StudyMockData.quizProgress,
                                minHeight: 8,
                                backgroundColor: AppColors.muted,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SurfaceCard(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              // MOCK DATA
                              StudyMockData.questionText,
                              style: AppTypography.headingSm.copyWith(
                                fontSize: 19,
                                height: 27 / 19,
                                letterSpacing: -0.19,
                              ),
                            ),
                            const SizedBox(height: 16),
                            // MOCK DATA
                            for (
                              int i = 0;
                              i < StudyMockData.answers.length;
                              i++
                            ) ...[
                              if (i > 0) const SizedBox(height: 8),
                              QuizAnswerOption(
                                letter: StudyMockData.answers[i].letter,
                                text: StudyMockData.answers[i].text,
                                visualState: _visualStateFor(
                                  StudyMockData.answers[i].id,
                                ),
                                onTap: () => _selectAnswer(
                                  StudyMockData.answers[i].id,
                                ),
                              ),
                            ],
                            if (_checked) ...[
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: isCorrect
                                      ? AppColors.green500.withValues(
                                          alpha: 0.12,
                                        )
                                      : AppColors.destructive.withValues(
                                          alpha: 0.1,
                                        ),
                                  borderRadius: BorderRadius.circular(
                                    AppRadii.lg,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isCorrect
                                          ? 'Poprawna odpowiedź!'
                                          : 'Niepoprawna odpowiedź.',
                                      style: AppTypography.labelMd.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: isCorrect
                                            ? AppColors.greenText
                                            : AppColors.redText,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      // MOCK DATA
                                      isCorrect
                                          ? StudyMockData.correctVerdictSub
                                          : StudyMockData.wrongVerdictSub,
                                      style: AppTypography.bodySm,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  _AiPromptChip(
                                    label: 'Wyjaśnij odpowiedź',
                                    showSparkles: true,
                                    onTap: () => showQuizAiChatSheet(context),
                                  ),
                                  _AiPromptChip(
                                    // MOCK DATA
                                    label: StudyMockData.followUpPromptLabel,
                                    showSparkles: false,
                                    onTap: () => showQuizAiChatSheet(context),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                  16,
                  12,
                  16,
                  safeBottom > 0 ? safeBottom + 12 : 20,
                ),
                decoration: BoxDecoration(
                  color: AppColors.background.withValues(alpha: 0.95),
                  border: Border(
                    top: BorderSide(color: AppColors.navBorder),
                  ),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => showQuizAiChatSheet(context),
                      child: Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(AppRadii.md),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.35),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              LucideIcons.sparkles,
                              size: 18,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Zapytaj AI',
                              style: AppTypography.labelSemiBold.copyWith(
                                color: AppColors.secondaryForeground,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _checked
                          ? GestureDetector(
                              onTap: _nextQuestion,
                              child: Container(
                                height: 48,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(
                                    AppRadii.md,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        'Następne pytanie',
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTypography.labelSemiBold
                                            .copyWith(
                                              color:
                                                  AppColors.primaryForeground,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    const Icon(
                                      LucideIcons.chevronRight,
                                      size: 18,
                                      color: AppColors.primaryForeground,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Opacity(
                              opacity: _selectedId != null ? 1 : 0.5,
                              child: GestureDetector(
                                onTap: _selectedId != null
                                    ? _checkAnswer
                                    : null,
                                child: Container(
                                  height: 48,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(
                                      AppRadii.md,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Sprawdź odpowiedź',
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.labelSemiBold.copyWith(
                                      color: AppColors.primaryForeground,
                                    ),
                                  ),
                                ),
                              ),
                            ),
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

class _AiPromptChip extends StatelessWidget {
  const _AiPromptChip({
    required this.label,
    required this.showSparkles,
    required this.onTap,
  });

  final String label;
  final bool showSparkles;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadii.full),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showSparkles) ...[
              const Icon(
                LucideIcons.sparkles,
                size: 14,
                color: AppColors.primary,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: AppTypography.caption.copyWith(
                fontSize: 13,
                color: AppColors.accentForeground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
