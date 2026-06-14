import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class MonthLabel extends StatelessWidget {
  final String label;

  const MonthLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // .diary-month-label: 11px, mono, ink-4, uppercase, margin 20px 0 10px
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: Text(
        label.toUpperCase(),
        style: AppTypography.mono(
          fontSize: 11,
          color: AppColors.ink4,
        ).copyWith(letterSpacing: 1.5),
      ),
    );
  }
}
