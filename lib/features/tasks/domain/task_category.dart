import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/l10n/app_strings.dart';

enum TaskCategory {
  self_('Self', AppColors.sage, AppColors.sageBg),
  work('Work', AppColors.dusk, AppColors.duskBg),
  family('Family', AppColors.coral, AppColors.coralBg),
  deen('Deen', AppColors.pink, AppColors.pinkMist),
  home('Ghar', AppColors.clay, AppColors.clayBg);

  final String displayName;
  final Color color;
  final Color bgColor;

  const TaskCategory(this.displayName, this.color, this.bgColor);

  String localizedName(AppStrings s) {
    switch (this) {
      case TaskCategory.self_:
        return s.catSelf;
      case TaskCategory.work:
        return s.catWork;
      case TaskCategory.family:
        return s.catFamily;
      case TaskCategory.deen:
        return s.catDeen;
      case TaskCategory.home:
        return s.catHome;
    }
  }
}
