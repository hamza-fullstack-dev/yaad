import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_radius.dart';

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String? valueSuffix;
  final String sub;
  final bool isPrimary;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    this.valueSuffix,
    required this.sub,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // .stat-card: white, 16px radius, border, shadow-sm
        // .stat-card.pink: pink bg, shadow-pink
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.pink : Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: isPrimary
              ? null
              : Border.all(color: AppColors.border, width: 0.5),
          boxShadow: isPrimary ? AppShadows.pink : AppShadows.sm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // .stat-label: 10px, weight 500, ink-4 (or white 75% if primary)
            Text(
              label.toUpperCase(),
              style: AppTypography.body(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color:
                    isPrimary ? Colors.white.withOpacity(0.75) : AppColors.ink4,
              ).copyWith(letterSpacing: 0.5),
            ),

            const SizedBox(height: 8),

            // .stat-value: DM Serif 26px
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: AppTypography.display(
                    fontSize: 26,
                    color: isPrimary ? Colors.white : AppColors.ink,
                  ).copyWith(letterSpacing: -0.5, height: 1),
                ),
                if (valueSuffix != null)
                  Text(
                    valueSuffix!,
                    style: AppTypography.body(
                      fontSize: 14,
                      color: isPrimary
                          ? Colors.white.withOpacity(0.75)
                          : AppColors.ink4,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 4),

            // .stat-sub: 11px, ink-4 (or white 70% if primary)
            Text(
              sub,
              style: AppTypography.body(
                fontSize: 11,
                color:
                    isPrimary ? Colors.white.withOpacity(0.70) : AppColors.ink4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
