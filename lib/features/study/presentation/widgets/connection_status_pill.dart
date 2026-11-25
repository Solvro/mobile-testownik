import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_typography.dart';

enum ConnectionBadgeState { connected, reconnecting, offline }

class ConnectionStatusPill extends StatelessWidget {
  const ConnectionStatusPill({
    super.key,
    this.state = ConnectionBadgeState.connected,
  });

  final ConnectionBadgeState state;

  @override
  Widget build(BuildContext context) {
    final (String label, Color accent, Color textColor) = switch (state) {
      ConnectionBadgeState.connected => (
        'Połączono na żywo',
        AppColors.green500,
        AppColors.greenText,
      ),
      ConnectionBadgeState.reconnecting => (
        'Łączenie…',
        AppColors.yellow500,
        AppColors.yellowText,
      ),
      ConnectionBadgeState.offline => (
        'Rozłączono – postęp zapisany lokalnie',
        AppColors.gray500,
        AppColors.gray600,
      ),
    };

    return Container(
      height: 22,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: accent.withValues(alpha: 0.6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: accent,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: accent.withValues(alpha: 0.25),
                  spreadRadius: 3,
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTypography.caption.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}
