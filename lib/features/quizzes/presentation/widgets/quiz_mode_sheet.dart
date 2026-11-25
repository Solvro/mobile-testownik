import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../study/presentation/screens/flashcards_screen.dart';
import '../../../study/presentation/screens/quiz_question_screen.dart';

Future<void> showQuizModeSheet(
  BuildContext context, {
  required String quizTitle,
  required String quizMeta,
}) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Zamknij menu',
    barrierColor: Colors.black.withValues(alpha: 0.18),
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (dialogContext, _, _) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: _QuizModeOverlay(
          quizTitle: quizTitle,
          quizMeta: quizMeta,
        ),
      );
    },
    transitionBuilder: (_, animation, _, child) {
      final slide = Tween<Offset>(
        begin: const Offset(0, 0.08),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));
      return FadeTransition(
        opacity: animation,
        child: SlideTransition(position: slide, child: child),
      );
    },
  );
}

enum _StudyMode { quiz, cards }

class _QuizModeOverlay extends StatefulWidget {
  const _QuizModeOverlay({
    required this.quizTitle,
    required this.quizMeta,
  });

  final String quizTitle;
  final String quizMeta;

  @override
  State<_QuizModeOverlay> createState() => _QuizModeOverlayState();
}

class _QuizModeOverlayState extends State<_QuizModeOverlay> {
  _StudyMode _mode = _StudyMode.cards;

  void _startSelectedMode() {
    final NavigatorState navigator = Navigator.of(context);
    navigator.pop();
    navigator.push(
      MaterialPageRoute<void>(
        builder: (_) => _mode == _StudyMode.cards
            ? FlashcardsScreen(title: widget.quizTitle)
            : QuizQuestionScreen(title: widget.quizTitle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double safeBottom = MediaQuery.paddingOf(context).bottom;

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).pop(),
              child: const SizedBox.expand(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Transform.scale(
                    scale: 1.02,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(AppRadii.xl),
                        border: Border.all(color: AppColors.cardRing),
                        boxShadow: AppShadows.lg,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.quizTitle,
                            style: AppTypography.labelSemiBold,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.quizMeta,
                            style: AppTypography.captionRegular,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    8,
                    16,
                    safeBottom > 0 ? safeBottom + 12 : 24,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppRadii.xxxl),
                    ),
                    border: Border.all(color: AppColors.cardRing),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            color: AppColors.border,
                            borderRadius: BorderRadius.circular(AppRadii.full),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Jak chcesz się uczyć?',
                        style: AppTypography.titleSm,
                      ),
                      const SizedBox(height: 14),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: _ModeOptionCard(
                                icon: LucideIcons.bookOpen,
                                title: 'Quiz',
                                description:
                                    '4 odpowiedzi, sprawdzanie i czat AI',
                                selected: _mode == _StudyMode.quiz,
                                onTap: () => setState(
                                  () => _mode = _StudyMode.quiz,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _ModeOptionCard(
                                icon: LucideIcons.layers,
                                title: 'Fiszki',
                                description:
                                    'Odwracaj karty i oceniaj, co już umiesz',
                                selected: _mode == _StudyMode.cards,
                                onTap: () => setState(
                                  () => _mode = _StudyMode.cards,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      GestureDetector(
                        onTap: _startSelectedMode,
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(AppRadii.md),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                LucideIcons.play,
                                size: 16,
                                color: AppColors.primaryForeground,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _mode == _StudyMode.cards
                                    ? 'Ucz się fiszkami'
                                    : 'Rozwiąż quiz',
                                style: AppTypography.labelSemiBold.copyWith(
                                  color: AppColors.primaryForeground,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.only(top: 6),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: AppColors.divider),
                          ),
                        ),
                        child: Column(
                          children: [
                            _SheetActionRow(
                              icon: LucideIcons.share2,
                              label: 'Udostępnij quiz',
                              onTap: () => Navigator.of(context).pop(),
                            ),
                            _SheetActionRow(
                              icon: LucideIcons.folder,
                              label: 'Przenieś do folderu',
                              onTap: () => Navigator.of(context).pop(),
                            ),
                            _SheetActionRow(
                              icon: LucideIcons.archive,
                              label: 'Przenieś do archiwum',
                              onTap: () => Navigator.of(context).pop(),
                            ),
                            _SheetActionRow(
                              icon: LucideIcons.trash2,
                              label: 'Usuń quiz',
                              isDestructive: true,
                              onTap: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ModeOptionCard extends StatelessWidget {
  const _ModeOptionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : AppColors.background,
          borderRadius: BorderRadius.circular(AppRadii.xl),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppColors.ring.withValues(alpha: 0.5),
                    spreadRadius: 3,
                  ),
                ]
              : const [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : AppColors.accent,
                borderRadius: BorderRadius.circular(AppRadii.md),
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: 18,
                color: selected
                    ? AppColors.primaryForeground
                    : AppColors.accentForeground,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: AppTypography.labelSemiBold,
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: AppTypography.captionRegular,
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetActionRow extends StatelessWidget {
  const _SheetActionRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final Color iconColor = isDestructive
        ? AppColors.destructive
        : AppColors.mutedForeground;
    final Color textColor = isDestructive
        ? AppColors.destructive
        : AppColors.foreground;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.md),
      child: SizedBox(
        height: 44,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              Icon(icon, size: 18, color: iconColor),
              const SizedBox(width: 12),
              Text(
                label,
                style: AppTypography.labelMd.copyWith(color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
