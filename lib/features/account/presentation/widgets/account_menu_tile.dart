import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class AccountMenuTile extends StatelessWidget {
  const AccountMenuTile({
    super.key,
    required this.icon,
    required this.label,
    this.trailingValue,
    required this.showDivider,
  });

  final IconData icon;
  final String label;
  final String? trailingValue;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 52),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        border: showDivider
            ? Border(bottom: BorderSide(color: AppColors.divider))
            : null,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: AppColors.mutedForeground,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: AppTypography.labelMd),
          ),
          if (trailingValue != null) ...[
            Text(
              trailingValue!,
              style: AppTypography.bodySm.copyWith(
                color: AppColors.mutedForeground,
              ),
            ),
            const SizedBox(width: 12),
          ],
          const Icon(
            LucideIcons.chevronRight,
            size: 16,
            color: AppColors.mutedForeground,
          ),
        ],
      ),
    );
  }
}
