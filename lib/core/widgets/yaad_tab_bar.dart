import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../routing/route_names.dart';
import '../l10n/language_provider.dart';

class YaadTabBar extends ConsumerWidget {
  final int activeIndex;

  const YaadTabBar({super.key, required this.activeIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(stringsProvider);
    final tabs = [
      _TabDef(s.tabToday, 'assets/icons/tab_today.png', RouteNames.home),
      _TabDef(
          s.tabCalendar, 'assets/icons/tab_calendar.png', RouteNames.calendar),
      _TabDef(s.tabDiary, 'assets/icons/tab_diary.png', RouteNames.diary),
      _TabDef(s.tabProfile, 'assets/icons/tab_profile.png', RouteNames.profile),
    ];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        border: const Border(
          top: BorderSide(color: AppColors.border, width: 0.5),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(tabs.length, (i) {
              final tab = tabs[i];
              final isActive = i == activeIndex;
              final color = isActive ? AppColors.pink : AppColors.ink4;

              return GestureDetector(
                onTap: isActive ? null : () => context.go(tab.route),
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  width: 56,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Image.asset(
                            tab.icon,
                            width: 22,
                            height: 22,
                            color: color,
                          ),
                          if (isActive)
                            Positioned(
                              bottom: -4,
                              child: Container(
                                width: 4,
                                height: 4,
                                decoration: const BoxDecoration(
                                  color: AppColors.pink,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tab.label,
                        style: AppTypography.body(
                          fontSize: 10,
                          fontWeight:
                              isActive ? FontWeight.w600 : FontWeight.w500,
                          color: color,
                        ).copyWith(letterSpacing: 0.2),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _TabDef {
  final String label;
  final String icon;
  final String route;

  const _TabDef(this.label, this.icon, this.route);
}
