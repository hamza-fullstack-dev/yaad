import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../tasks/data/task_providers.dart';
import '../../../diary/data/diary_providers.dart';
import '../../../../core/l10n/language_provider.dart';

class ProfileStats extends ConsumerWidget {
  const ProfileStats({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(stringsProvider);
    final allTasks = ref.watch(allTasksProvider).valueOrNull ?? [];
    final tasksDone = allTasks.where((t) => t.isCompleted).length;
    final streak = ref.watch(currentStreakProvider).valueOrNull ?? 0;
    final entriesCount =
        ref.watch(allDiaryEntriesProvider).valueOrNull?.length ?? 0;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.border, width: 0.5),
        boxShadow: AppShadows.sm,
      ),
      child: Row(
        children: [
          _StatItem(value: '$tasksDone', label: s.statTasksDone),
          _Divider(),
          _StatItem(value: '$streak', label: s.statStreak),
          _Divider(),
          _StatItem(value: '$entriesCount', label: s.statEntries),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          // .profile-stat-num: DM Serif 24px ink
          Text(
            value,
            style: AppTypography.display(
              fontSize: 24,
              color: AppColors.ink,
            ).copyWith(letterSpacing: -0.5, height: 1),
          ),
          const SizedBox(height: 4),
          // .profile-stat-label: 11px ink-4
          Text(
            label,
            style: AppTypography.body(
              fontSize: 11,
              color: AppColors.ink4,
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.5,
      height: 36,
      color: AppColors.border,
    );
  }
}
