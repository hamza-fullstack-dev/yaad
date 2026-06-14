import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/widgets/yaad_loading_skeleton.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/widgets/yaad_tab_bar.dart';
import '../../../core/l10n/language_provider.dart';
import '../../../core/l10n/app_strings.dart';
import '../../auth/data/auth_providers.dart';
import '../data/task_providers.dart';
import '../domain/task_model.dart';
import 'controllers/home_controller.dart';
import 'add_task_modal.dart';
import 'widgets/greeting_header.dart';
import 'widgets/date_chip.dart';
import 'widgets/stats_row.dart';
import 'widgets/task_list.dart';
import 'widgets/reflection_card.dart';
import '../../../core/widgets/yaad_empty_state.dart';
import '../../../core/widgets/yaad_error_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  String _greetingForHour(int hour, AppStrings s) {
    if (hour < 12) return s.greetMorning;
    if (hour < 17) return s.greetAfternoon;
    return s.greetEvening;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(stringsProvider);
    final tasksAsync = ref.watch(todayTasksProvider);
    final user = ref.watch(currentUserProvider);
    final displayName = user?.displayName ?? 'Yaad User';
    final firstName = displayName.split(' ').first;
    final initial = displayName.isNotEmpty ? displayName[0].toUpperCase() : 'Y';
    final now = DateTime.now();
    final dayNames = s.dayNames;
    final dayName = dayNames[now.weekday % 7];
    final dateText = '$dayName, ${DateFormat('d MMM').format(now)}';

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: SizedBox(height: 60),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(22, 0, 22, 120),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    GreetingHeader(
                      greeting: _greetingForHour(now.hour, s),
                      namePrefix: s.greetNamePrefix,
                      name: firstName,
                      initial: initial,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    DateChip(dateText: dateText),
                    const SizedBox(height: AppSpacing.xxl),
                    tasksAsync.when(
                      loading: () => _buildLoadingState(s),
                      error: (e, _) => _buildErrorState(e, ref, s),
                      data: (tasks) => _buildDataState(context, ref, tasks, s),
                    ),
                  ]),
                ),
              ),
            ],
          ),
          Positioned(
            right: 22,
            bottom: 100,
            child: Tooltip(
              message: s.addTaskTooltip,
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  showAddTaskModal(context);
                },
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.pink,
                    shape: BoxShape.circle,
                    boxShadow: AppShadows.fab,
                  ),
                  child: CustomPaint(
                    painter: _PlusIconPainter(),
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: YaadTabBar(activeIndex: 0),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(AppStrings s) {
    return Column(
      children: [
        StatsRow(
          streakLabel: s.statStreak,
          daysLabel: s.statDays,
          weekLabel: s.statWeek,
          remainingLabel: s.statRemaining,
          remainingTodayLabel: s.statRemainingToday,
        ),
        const SizedBox(height: AppSpacing.xxl),
        _buildSectionHeader(0, 0, s),
        const SizedBox(height: AppSpacing.md),
        YaadLoadingSkeleton.taskList(),
      ],
    );
  }

  Widget _buildErrorState(Object error, WidgetRef ref, AppStrings s) {
    return YaadErrorState(
      message: s.tasksLoadError,
      onRetry: () => ref.invalidate(todayTasksProvider),
    );
  }

  Widget _buildDataState(
      BuildContext context, WidgetRef ref, List<Task> tasks, AppStrings s) {
    final completed = tasks.where((t) => t.isCompleted).length;
    final total = tasks.length;
    final remaining = total - completed;
    final weekPercent = total > 0 ? (completed * 100 ~/ total) : 0;
    final streak = ref.watch(currentStreakProvider).valueOrNull ?? 0;

    return Column(
      children: [
        StatsRow(
          streak: streak,
          weekPercent: weekPercent,
          weekSub: '$completed of $total',
          remaining: remaining,
          streakLabel: s.statStreak,
          daysLabel: s.statDays,
          weekLabel: s.statWeek,
          remainingLabel: s.statRemaining,
          remainingTodayLabel: s.statRemainingToday,
        ),
        const SizedBox(height: AppSpacing.lg),
        _buildSharedListsButton(context, s),
        const SizedBox(height: AppSpacing.xxl),
        _buildSectionHeader(completed, total, s),
        const SizedBox(height: AppSpacing.md),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          child: tasks.isEmpty
              ? YaadEmptyState(
                  key: const ValueKey('empty'),
                  title: s.emptyTodayTitle,
                  subtitle: s.emptyTodaySubtitle,
                  ctaLabel: s.addTaskCta,
                  onCtaTap: () => showAddTaskModal(context),
                )
              : TaskList(
                  key: ValueKey(tasks.length),
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
        ),
        const SizedBox(height: AppSpacing.lg),
        ReflectionCard(
          onTap: () => context.push(RouteNames.diaryWrite),
        ),
      ],
    );
  }

  Widget _buildSharedListsButton(BuildContext context, AppStrings s) {
    return GestureDetector(
      onTap: () => context.push(RouteNames.sharedLists),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.duskBg,
          borderRadius: BorderRadius.circular(100),
          border:
              Border.all(color: AppColors.dusk.withOpacity(0.15), width: 0.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.people_outline_rounded, size: 16, color: AppColors.dusk),
            const SizedBox(width: 6),
            Text(
              s.sharedLists,
              style: AppTypography.body(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.dusk,
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.arrow_forward_rounded, size: 14, color: AppColors.dusk),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(int completed, int total, AppStrings s) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          s.today,
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
              '$completed of $total ${s.completed}',
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

class _PlusIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;

    final cx = size.width / 2;
    final cy = size.height / 2;

    canvas.drawLine(Offset(cx, cy - 9), Offset(cx, cy + 9), paint);
    canvas.drawLine(Offset(cx - 9, cy), Offset(cx + 9, cy), paint);
  }

  @override
  bool shouldRepaint(_PlusIconPainter oldDelegate) => false;
}
