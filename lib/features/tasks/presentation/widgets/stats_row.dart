import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import 'stat_card.dart';

class StatsRow extends StatelessWidget {
  final int streak;
  final int weekPercent;
  final String weekSub;
  final int remaining;
  final String streakLabel;
  final String daysLabel;
  final String weekLabel;
  final String remainingLabel;
  final String remainingTodayLabel;

  const StatsRow({
    super.key,
    this.streak = 0,
    this.weekPercent = 0,
    this.weekSub = '0 of 0',
    this.remaining = 0,
    this.streakLabel = 'Streak',
    this.daysLabel = 'din',
    this.weekLabel = 'Hafte',
    this.remainingLabel = 'Baaqi',
    this.remainingTodayLabel = 'aaj ke',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StatCard(
          label: streakLabel,
          value: '$streak',
          sub: daysLabel,
          isPrimary: true,
        ),
        const SizedBox(width: AppSpacing.sm),
        StatCard(
          label: weekLabel,
          value: '$weekPercent',
          valueSuffix: '%',
          sub: weekSub,
        ),
        const SizedBox(width: AppSpacing.sm),
        StatCard(
          label: remainingLabel,
          value: '$remaining',
          sub: remainingTodayLabel,
        ),
      ],
    );
  }
}
