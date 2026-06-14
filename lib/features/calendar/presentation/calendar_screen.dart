import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/widgets/yaad_loading_skeleton.dart';
import '../../../core/widgets/yaad_empty_state.dart';
import '../../../core/widgets/yaad_error_state.dart';
import '../../../features/tasks/presentation/widgets/task_list.dart';
import '../../../features/tasks/data/task_providers.dart';
import '../../../features/tasks/domain/task_model.dart';
import '../../../features/tasks/domain/task_category.dart';
import '../../../features/tasks/presentation/controllers/home_controller.dart';
import 'widgets/month_grid.dart';
import '../../../core/widgets/yaad_tab_bar.dart';
import '../../../core/l10n/language_provider.dart';
import '../../../core/l10n/app_strings.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  int _year = DateTime.now().year;
  int _month = DateTime.now().month;
  int _selectedDay = DateTime.now().day;

  DateTime get _selectedDate => DateTime(_year, _month, _selectedDay);

  String _monthName(List<String> monthNames) {
    return monthNames[_month];
  }

  void _prevMonth() {
    setState(() {
      if (_month == 1) {
        _month = 12;
        _year--;
      } else {
        _month--;
      }
      _selectedDay = 1;
    });
  }

  void _nextMonth() {
    setState(() {
      if (_month == 12) {
        _month = 1;
        _year++;
      } else {
        _month++;
      }
      _selectedDay = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(stringsProvider);
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Stack(
        children: [
          // ── Scrollable body ──────────────────────────────────
          CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 60)),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(22, 0, 22, 120),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // ── Cal head: month + nav ──────────────────
                    // .cal-head: space-between, align center
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // .cal-month: DM Serif italic month + plain year
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: _monthName(s.monthNames),
                                style: AppTypography.displayItalic(
                                  fontSize: 32,
                                  color: AppColors.ink,
                                ).copyWith(letterSpacing: -0.5),
                              ),
                              TextSpan(
                                text: ' $_year',
                                style: AppTypography.display(
                                  fontSize: 32,
                                  color: AppColors.ink3,
                                ).copyWith(letterSpacing: -0.5),
                              ),
                            ],
                          ),
                        ),

                        // .cal-nav: prev + next buttons
                        Row(
                          children: [
                            _NavBtn(
                              onTap: _prevMonth,
                              isLeft: true,
                            ),
                            const SizedBox(width: 8),
                            _NavBtn(
                              onTap: _nextMonth,
                              isLeft: false,
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // ── Month grid ─────────────────────────────
                    _buildMonthGrid(ref),

                    const SizedBox(height: AppSpacing.xxl),

                    // ── Tasks for selected day ────────────────
                    _buildSelectedDayTasks(ref, s),
                  ]),
                ),
              ),
            ],
          ),

          // ── Bottom tab bar ────────────────────────────────────
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: YaadTabBar(activeIndex: 1),
          ),
        ],
      ),
    );
  }

  ({
    Map<int, List<Color>> dots,
    Map<int, Color> bg,
    Map<int, Color> text,
  }) _buildDayColors(List<Task> tasks) {
    final dots = <int, List<Color>>{};
    final categoryCount = <int, Map<TaskCategory, int>>{};

    for (final task in tasks) {
      final d = task.dueDate;
      if (d.year == _year && d.month == _month) {
        final colors = dots.putIfAbsent(d.day, () => []);
        final c = task.category.color;
        if (!colors.contains(c) && colors.length < 3) {
          colors.add(c);
        }
        final counts = categoryCount.putIfAbsent(d.day, () => {});
        counts[task.category] = (counts[task.category] ?? 0) + 1;
      }
    }

    final bg = <int, Color>{};
    final text = <int, Color>{};
    for (final entry in categoryCount.entries) {
      final dominant =
          entry.value.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
      bg[entry.key] = dominant.bgColor;
      text[entry.key] = dominant.color;
    }

    return (dots: dots, bg: bg, text: text);
  }

  Widget _buildMonthGrid(WidgetRef ref) {
    final allTasksAsync = ref.watch(allTasksProvider);
    final colors = allTasksAsync.whenData((tasks) => _buildDayColors(tasks));
    final data = colors.valueOrNull;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.border, width: 0.5),
        boxShadow: AppShadows.sm,
      ),
      child: MonthGrid(
        year: _year,
        month: _month,
        selectedDay: _selectedDay,
        dayDotColors: data?.dots ?? const {},
        dayBgColors: data?.bg ?? const {},
        dayTextColors: data?.text ?? const {},
        onDayTap: (day) => setState(() => _selectedDay = day),
      ),
    );
  }

  Widget _buildSelectedDayTasks(WidgetRef ref, AppStrings s) {
    final tasksAsync = ref.watch(tasksByDateProvider(_selectedDate));

    return tasksAsync.when(
      loading: () => Column(
        children: [
          _buildSectionHeader(0, 0, s),
          const SizedBox(height: AppSpacing.md),
          YaadLoadingSkeleton.taskList(),
        ],
      ),
      error: (e, _) => YaadErrorState(
        message: s.tasksLoadError,
        onRetry: () => ref.invalidate(tasksByDateProvider(_selectedDate)),
      ),
      data: (tasks) {
        final remaining = tasks.where((t) => !t.isCompleted).length;
        final total = tasks.length;

        return Column(
          children: [
            _buildSectionHeader(remaining, total, s),
            const SizedBox(height: AppSpacing.md),
            if (tasks.isEmpty)
              YaadEmptyState(
                title: s.calEmptyTitle,
                subtitle: s.calEmptySubtitle,
              )
            else
              TaskList(
                tasks: tasks,
                onToggle: (id) =>
                    ref.read(homeControllerProvider.notifier).toggleTask(id),
                onDelete: (id) =>
                    ref.read(homeControllerProvider.notifier).deleteTask(id),
                deleteTitle: s.deleteTaskTitle,
                deleteBodySuffix: s.deleteTaskBody,
                confirmDelete: s.confirmDelete,
                cancelLabel: s.no,
                doneLabel: s.completed,
                pendingLabel: s.remaining,
                categoryNameResolver: (c) => c.localizedName(s),
              ),
          ],
        );
      },
    );
  }

  Widget _buildSectionHeader(int remaining, int total, AppStrings s) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          s.calTasksHeader,
          style: AppTypography.body(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: AppColors.ink,
          ).copyWith(letterSpacing: -0.2),
        ),
        if (total > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.pinkMist,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              '$remaining ${s.calRemaining}',
              style: AppTypography.body(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.pinkDeep,
              ),
            ),
          ),
      ],
    );
  }
}

// ── Nav button ───────────────────────────────────────────────────
class _NavBtn extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLeft;

  const _NavBtn({required this.onTap, required this.isLeft});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border, width: 0.5),
          boxShadow: AppShadows.xs,
        ),
        child: Center(
          child: CustomPaint(
            size: const Size(14, 14),
            painter: _ChevronPainter(isLeft: isLeft),
          ),
        ),
      ),
    );
  }
}

class _ChevronPainter extends CustomPainter {
  final bool isLeft;
  const _ChevronPainter({required this.isLeft});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.ink
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    if (isLeft) {
      // M9 2 L4 7 L9 12
      path
        ..moveTo(9, 2)
        ..lineTo(4, 7)
        ..lineTo(9, 12);
    } else {
      // M5 2 L10 7 L5 12
      path
        ..moveTo(5, 2)
        ..lineTo(10, 7)
        ..lineTo(5, 12);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_ChevronPainter old) => old.isLeft != isLeft;
}
