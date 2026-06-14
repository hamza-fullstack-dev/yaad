import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ProgressDots extends StatelessWidget {
  final int total;
  final int current;

  const ProgressDots({
    super.key,
    required this.total,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (i) {
        final isActive = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.only(right: 6),
          width: isActive ? 24 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive ? AppColors.pink : AppColors.ink5,
            borderRadius: BorderRadius.circular(100),
          ),
        );
      }),
    );
  }
}
