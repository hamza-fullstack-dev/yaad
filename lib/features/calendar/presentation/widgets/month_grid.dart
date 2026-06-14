import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import 'day_cell.dart';

class MonthGrid extends StatelessWidget {
  final int year;
  final int month;
  final int? selectedDay;
  final Function(int day)? onDayTap;
  final Map<int, List<Color>> dayDotColors;
  final Map<int, Color> dayBgColors;
  final Map<int, Color> dayTextColors;

  const MonthGrid({
    super.key,
    required this.year,
    required this.month,
    this.selectedDay,
    this.onDayTap,
    this.dayDotColors = const {},
    this.dayBgColors = const {},
    this.dayTextColors = const {},
  });

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final firstDay = DateTime(year, month, 1);
    final daysInMonth = DateTime(year, month + 1, 0).day;

    // Day of week for first day (0=Sun, 6=Sat)
    int startWeekday = firstDay.weekday % 7;

    // Days from previous month to fill
    final prevMonthDays = DateTime(year, month, 0).day;

    return Column(
      children: [
        // ── Weekday headers: S M T W T F S ───────────────────
        Row(
          children: ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((d) {
            return Expanded(
              child: Center(
                child: Text(
                  d,
                  style: AppTypography.mono(
                    fontSize: 11,
                    color: AppColors.ink4,
                  ).copyWith(letterSpacing: 0.5),
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 8),

        // ── Day grid ─────────────────────────────────────────
        Builder(builder: (context) {
          // Build full list of cells
          final cells = <Widget>[];

          // Previous month muted days
          for (int i = startWeekday - 1; i >= 0; i--) {
            cells.add(DayCell(
              day: prevMonthDays - i,
              isMuted: true,
            ));
          }

          // Current month days
          for (int d = 1; d <= daysInMonth; d++) {
            final isToday =
                today.year == year && today.month == month && today.day == d;
            cells.add(DayCell(
              day: d,
              isToday: isToday,
              isSelected: selectedDay == d && !isToday,
              dotColors: dayDotColors[d] ?? const [],
              categoryBgColor: dayBgColors[d],
              categoryColor: dayTextColors[d],
              onTap: () => onDayTap?.call(d),
            ));
          }

          // Next month muted days to fill grid
          final remaining = 7 - (cells.length % 7);
          if (remaining < 7) {
            for (int d = 1; d <= remaining; d++) {
              cells.add(DayCell(day: d, isMuted: true));
            }
          }

          // Build rows of 7
          final rows = <Widget>[];
          for (int i = 0; i < cells.length; i += 7) {
            rows.add(
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Row(
                  children: cells
                      .sublist(i, (i + 7).clamp(0, cells.length))
                      .map((c) => Expanded(child: Center(child: c)))
                      .toList(),
                ),
              ),
            );
          }

          return Column(children: rows);
        }),
      ],
    );
  }
}
