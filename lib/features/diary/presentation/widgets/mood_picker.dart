import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/l10n/language_provider.dart';

// Mood data
class MoodOption {
  final String label;
  final Color color;
  const MoodOption({required this.label, required this.color});
}

const _moodColors = [
  AppColors.ink4,
  AppColors.dusk,
  AppColors.pink,
  AppColors.sage,
  AppColors.clay,
];

class MoodPicker extends ConsumerWidget {
  final int selectedIndex;
  final Function(int index) onSelect;

  const MoodPicker({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(stringsProvider);
    final moodLabels = [
      s.moodTired,
      s.moodUpset,
      s.moodGrateful,
      s.moodPeaceful,
      s.moodHappy
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(moodLabels.length, (i) {
        final label = moodLabels[i];
        final color = _moodColors[i];
        final isSelected = i == selectedIndex;

        return GestureDetector(
          onTap: () => onSelect(i),
          child: Column(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      isSelected ? color.withOpacity(0.12) : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? color : AppColors.ink5,
                    width: isSelected ? 2 : 1.5,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                label,
                style: AppTypography.body(
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? AppColors.ink : AppColors.ink3,
                ).copyWith(letterSpacing: 0.1),
              ),
            ],
          ),
        );
      }),
    );
  }
}
