import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class DayCell extends StatelessWidget {
  final int day;
  final bool isToday;
  final bool isMuted;
  final bool isSelected;
  final List<Color> dotColors;
  final Color? categoryBgColor;
  final Color? categoryColor;
  final VoidCallback? onTap;

  const DayCell({
    super.key,
    required this.day,
    this.isToday = false,
    this.isMuted = false,
    this.isSelected = false,
    this.dotColors = const [],
    this.categoryBgColor,
    this.categoryColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Day number circle ──────────────────────────────
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isToday
                  ? AppColors.pink
                  : isSelected
                      ? AppColors.pinkMist
                      : categoryBgColor ?? Colors.transparent,
            ),
            child: Center(
              child: Text(
                '$day',
                style: AppTypography.body(
                  fontSize: 13,
                  fontWeight: (isToday || categoryBgColor != null)
                      ? FontWeight.w600
                      : FontWeight.w400,
                  color: isToday
                      ? Colors.white
                      : isMuted
                          ? AppColors.ink5
                          : isSelected
                              ? AppColors.pink
                              : categoryColor ?? AppColors.ink,
                ).copyWith(letterSpacing: -0.2),
              ),
            ),
          ),

          const SizedBox(height: 3),

          SizedBox(
            height: 6,
            child: dotColors.isNotEmpty
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0; i < dotColors.length.clamp(0, 3); i++)
                        Container(
                          width: 3,
                          height: 3,
                          margin: EdgeInsets.only(
                              right:
                                  i < dotColors.length.clamp(0, 3) - 1 ? 2 : 0),
                          decoration: BoxDecoration(
                            color: isToday
                                ? Colors.white.withValues(alpha: 0.8)
                                : dotColors[i],
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
