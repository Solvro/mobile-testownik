import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/presentation/screens/main_shell_screen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/gradient_scaffold_background.dart';
import '../widgets/login_hero_illustration.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _openMainShell(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => const MainShellScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientScaffoldBackground(
        isRadialHero: true,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(AppRadii.md),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        LucideIcons.check,
                        size: 20,
                        color: AppColors.primaryForeground,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Testownik',
                          style: AppTypography.headingSm.copyWith(
                            height: 24 / 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                          ),
                        ),
                        Text(
                          'by KN Solvro',
                          style: AppTypography.caption,
                        ),
                      ],
                    ),
                  ],
                ),
                const Expanded(
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: LoginHeroIllustration(),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Twoje narzędzie do nauki na PWr',
                      style: AppTypography.headingLg,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Quizy, fiszki i oceny w jednym miejscu. Utknąłeś na pytaniu? Zapytaj AI.',
                      style: AppTypography.body.copyWith(
                        color: AppColors.mutedForeground,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(AppRadii.md),
                  clipBehavior: Clip.antiAlias,
                  child: Ink(
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadii.md),
                      gradient: const RadialGradient(
                        center: Alignment.topLeft,
                        radius: 2.2,
                        colors: [
                          AppColors.ctaGradientFrom,
                          AppColors.ctaGradientTo,
                        ],
                      ),
                    ),
                    child: InkWell(
                      onTap: () => _openMainShell(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            LucideIcons.logIn,
                            size: 18,
                            color: AppColors.primaryForeground,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Zaloguj się',
                            style: AppTypography.labelSemiBold.copyWith(
                              color: AppColors.primaryForeground,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text.rich(
                  TextSpan(
                    text: 'Logując się, akceptujesz ',
                    children: [
                      TextSpan(
                        text: 'Regulamin',
                        style: AppTypography.captionRegular.copyWith(
                          height: 18 / 12,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(text: ' i '),
                      TextSpan(
                        text: 'Politykę prywatności',
                        style: AppTypography.captionRegular.copyWith(
                          height: 18 / 12,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(text: '.'),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: AppTypography.captionRegular.copyWith(height: 18 / 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
