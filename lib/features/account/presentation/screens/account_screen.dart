import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/gradient_scaffold_background.dart';
import '../../../../core/widgets/surface_card.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import '../../data/account_mock_data.dart';
import '../widgets/account_menu_tile.dart';
import '../widgets/account_switch_tile.dart';
import '../widgets/profile_card.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  // MOCK DATA
  late final Map<String, bool> _toggleValues = {
    for (final toggle in AccountMockData.learningToggles)
      toggle.key: toggle.initialValue,
  };

  void _logout(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffoldBackground(
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Konto', style: AppTypography.headingLg),
              const SizedBox(height: 24),
              const ProfileCard(
                // MOCK DATA
                initials: AccountMockData.initials,
                // MOCK DATA
                fullName: AccountMockData.fullName,
                // MOCK DATA
                email: AccountMockData.email,
                // MOCK DATA
                roleBadge: AccountMockData.roleBadge,
              ),
              const SizedBox(height: 24),
              Text('Nauka', style: AppTypography.sectionTitle),
              const SizedBox(height: 10),
              SurfaceCard(
                child: Column(
                  children: [
                    // MOCK DATA
                    for (
                      int i = 0;
                      i < AccountMockData.learningToggles.length;
                      i++
                    )
                      AccountSwitchTile(
                        label: AccountMockData.learningToggles[i].label,
                        description:
                            AccountMockData.learningToggles[i].description,
                        value:
                            _toggleValues[AccountMockData
                                .learningToggles[i]
                                .key] ??
                            false,
                        showDivider:
                            i < AccountMockData.learningToggles.length - 1,
                        onChanged: (next) {
                          setState(() {
                            _toggleValues[AccountMockData
                                    .learningToggles[i]
                                    .key] =
                                next;
                          });
                        },
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text('Aplikacja', style: AppTypography.sectionTitle),
              const SizedBox(height: 10),
              const SurfaceCard(
                child: Column(
                  children: [
                    AccountMenuTile(
                      icon: LucideIcons.moon,
                      label: 'Motyw',
                      // MOCK DATA
                      trailingValue: AccountMockData.currentThemeLabel,
                      showDivider: true,
                    ),
                    AccountMenuTile(
                      icon: LucideIcons.globe,
                      label: 'Język',
                      // MOCK DATA
                      trailingValue: AccountMockData.currentLanguageLabel,
                      showDivider: true,
                    ),
                    AccountMenuTile(
                      icon: LucideIcons.shield,
                      label: 'Regulamin i prywatność',
                      showDivider: true,
                    ),
                    AccountMenuTile(
                      icon: LucideIcons.info,
                      label: 'O aplikacji',
                      // MOCK DATA
                      trailingValue: AccountMockData.appVersionLabel,
                      showDivider: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () => _logout(context),
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.destructive.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppRadii.md),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        LucideIcons.logOut,
                        size: 18,
                        color: AppColors.destructive,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Wyloguj się',
                        style: AppTypography.label.copyWith(
                          color: AppColors.destructive,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Testownik by KN Solvro',
                textAlign: TextAlign.center,
                style: AppTypography.captionRegular,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
