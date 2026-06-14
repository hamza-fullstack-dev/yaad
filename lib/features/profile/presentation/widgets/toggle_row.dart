import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class ToggleRow extends StatelessWidget {
  final Color iconBg;
  final Color iconColor;
  final CustomPainter iconPainter;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const ToggleRow({
    super.key,
    required this.iconBg,
    required this.iconColor,
    required this.iconPainter,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: CustomPaint(
                size: const Size(16, 16),
                painter: iconPainter,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: AppTypography.body(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.ink,
              ).copyWith(letterSpacing: -0.1),
            ),
          ),
          SizedBox(
            height: 28,
            child: Switch.adaptive(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.pink,
            ),
          ),
        ],
      ),
    );
  }
}
