import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class DateChip extends StatelessWidget {
  final String dateText;

  const DateChip({
    super.key,
    this.dateText = 'Budh, 14 May',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // .date-chip: pink-mist bg, pill, padding 5px 12px 5px 9px
      padding: const EdgeInsets.fromLTRB(9, 5, 12, 5),
      decoration: BoxDecoration(
        color: AppColors.pinkMist,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // .date-dot: 6px pink circle
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.pink,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 7),
          // .date-text: 12px, weight 500, pink-deep
          Text(
            dateText,
            style: AppTypography.body(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.pinkDeep,
            ).copyWith(letterSpacing: 0.2),
          ),
        ],
      ),
    );
  }
}
