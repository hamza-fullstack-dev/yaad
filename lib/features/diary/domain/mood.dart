import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

enum Mood {
  tired('Tired', AppColors.ink4),
  pareshan('Pareshan', AppColors.dusk),
  shukar('Shukar', AppColors.pink),
  sukoon('Sukoon', AppColors.sage),
  khush('Khush', AppColors.clay);

  final String displayName;
  final Color color;

  const Mood(this.displayName, this.color);
}
