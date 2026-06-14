import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_radius.dart';
import '../domain/task_category.dart';
import '../domain/task_recurrence.dart';
import '../../../core/l10n/language_provider.dart';
import '../../../core/l10n/app_strings.dart';
import 'controllers/add_task_controller.dart';

void showAddTaskModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const AddTaskModal(),
  );
}

class AddTaskModal extends ConsumerStatefulWidget {
  const AddTaskModal({super.key});

  @override
  ConsumerState<AddTaskModal> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends ConsumerState<AddTaskModal> {
  final _taskController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _taskController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addTaskControllerProvider);
    final controller = ref.read(addTaskControllerProvider.notifier);
    final s = ref.watch(stringsProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.88,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppRadius.modal),
              topRight: Radius.circular(AppRadius.modal),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                decoration: BoxDecoration(
                  color: AppColors.ink5,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        s.cancel,
                        style: AppTypography.body(
                          fontSize: 15,
                          color: AppColors.ink3,
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: s.newTaskTitle,
                            style: AppTypography.display(
                              fontSize: 17,
                              color: AppColors.ink,
                            ),
                          ),
                          TextSpan(
                            text: s.newTaskTitleItalic,
                            style: AppTypography.displayItalic(
                              fontSize: 17,
                              color: AppColors.pink,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: state.isValid && !state.isSaving
                          ? () async {
                              HapticFeedback.mediumImpact();
                              final saved = await controller.save();
                              if (saved && context.mounted) {
                                Navigator.pop(context);
                              }
                            }
                          : null,
                      child: state.isSaving
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.pink,
                              ),
                            )
                          : Text(
                              s.save,
                              style: AppTypography.body(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: state.isValid
                                    ? AppColors.pink
                                    : AppColors.ink5,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(22, 20, 22, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _taskController,
                        autofocus: true,
                        onChanged: controller.setTitle,
                        style: AppTypography.display(
                          fontSize: 26,
                          color: AppColors.ink,
                        ).copyWith(letterSpacing: -0.3, height: 1.3),
                        decoration: InputDecoration(
                          hintText: s.taskNameHint,
                          hintStyle: AppTypography.displayItalic(
                            fontSize: 26,
                            color: AppColors.ink4,
                          ).copyWith(letterSpacing: -0.3),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        maxLines: null,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: TaskCategory.values.map((cat) {
                            final isSelected = state.category == cat;
                            return GestureDetector(
                              onTap: () => controller.setCategory(cat),
                              child: Container(
                                margin: EdgeInsets.only(
                                  right:
                                      cat != TaskCategory.values.last ? 8 : 0,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 7),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? cat.bgColor
                                      : AppColors.borderSoft,
                                  borderRadius: BorderRadius.circular(100),
                                  border: isSelected
                                      ? null
                                      : Border.all(
                                          color: AppColors.border, width: 0.5),
                                ),
                                child: Text(
                                  cat.displayName,
                                  style: AppTypography.body(
                                    fontSize: 13,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    color:
                                        isSelected ? cat.color : AppColors.ink3,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.paperWarm,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          border:
                              Border.all(color: AppColors.border, width: 0.5),
                        ),
                        child: Column(
                          children: [
                            _ModalRow(
                              iconBg: AppColors.pinkMist,
                              iconColor: AppColors.pink,
                              label: s.dateLabel,
                              value: _formatDate(state.dueDate, s),
                              onTap: () => _pickDate(controller),
                            ),
                            _Divider(),
                            _ModalRow(
                              iconBg: AppColors.coralBg,
                              iconColor: AppColors.coral,
                              label: s.timeLabel,
                              value: state.dueTimeMinutes != null
                                  ? _formatTime(state.dueTimeMinutes!)
                                  : s.setTime,
                              onTap: () => _pickTime(controller),
                            ),
                            _Divider(),
                            _ModalRow(
                              iconBg: AppColors.sageBg,
                              iconColor: AppColors.sage,
                              label: s.repeatLabel,
                              value: _recurrenceLabel(state.recurrence, s),
                              onTap: () => _pickRecurrence(controller),
                            ),
                            _Divider(),
                            _ModalRow(
                              iconBg: AppColors.duskBg,
                              iconColor: AppColors.dusk,
                              label: s.remindLabel,
                              value: _remindLabel(state.remindBeforeMinutes, s),
                              onTap: () => _pickRemind(controller),
                            ),
                            if (state.dueTimeMinutes != null) ...[
                              _Divider(),
                              _AlarmToggleRow(
                                isAlarm: state.isAlarm,
                                onChanged: controller.setIsAlarm,
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          border:
                              Border.all(color: AppColors.border, width: 0.5),
                        ),
                        child: TextField(
                          controller: _notesController,
                          onChanged: controller.setNotes,
                          style: AppTypography.body(
                            fontSize: 13,
                            color: AppColors.ink2,
                          ).copyWith(height: 1.5),
                          decoration: InputDecoration(
                            hintText: s.notesHint,
                            hintStyle: AppTypography.displayItalic(
                              fontSize: 13,
                              color: AppColors.ink4,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          maxLines: 4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickDate(AddTaskController controller) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) controller.setDueDate(picked);
  }

  Future<void> _pickTime(AddTaskController controller) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      controller.setDueTimeMinutes(picked.hour * 60 + picked.minute);
    }
  }

  String _formatDate(DateTime date, AppStrings s) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(date.year, date.month, date.day);

    if (target == today) return s.today;
    if (target == today.add(const Duration(days: 1))) return s.tomorrow;

    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month]}';
  }

  String _formatTime(int minutes) {
    final h = minutes ~/ 60;
    final m = minutes % 60;
    final period = h >= 12 ? 'PM' : 'AM';
    final displayH = h == 0 ? 12 : (h > 12 ? h - 12 : h);
    return '$displayH:${m.toString().padLeft(2, '0')} $period';
  }

  String _recurrenceLabel(TaskRecurrence r, AppStrings s) {
    switch (r) {
      case TaskRecurrence.none:
        return s.never;
      case TaskRecurrence.daily:
        return s.daily;
      case TaskRecurrence.weekly:
        return s.weekly;
      case TaskRecurrence.monthly:
        return s.monthly;
    }
  }

  String _remindLabel(int minutes, AppStrings s) {
    if (minutes == 0) return s.atTime;
    if (minutes < 60) return '$minutes ${s.minBefore}';
    final h = minutes ~/ 60;
    return '$h ${s.hourBefore}';
  }

  void _pickRecurrence(AddTaskController controller) {
    final s = ref.read(stringsProvider);
    final options = TaskRecurrence.values;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.ink5,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              s.repeatLabel,
              style: AppTypography.display(fontSize: 17, color: AppColors.ink),
            ),
            const SizedBox(height: 8),
            ...options.map((r) => ListTile(
                  title: Text(
                    _recurrenceLabel(r, s),
                    style: AppTypography.body(
                      fontSize: 15,
                      color: AppColors.ink,
                    ),
                  ),
                  trailing: ref.read(addTaskControllerProvider).recurrence == r
                      ? const Icon(Icons.check_rounded,
                          size: 20, color: AppColors.pink)
                      : null,
                  onTap: () {
                    controller.setRecurrence(r);
                    Navigator.pop(ctx);
                  },
                )),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _pickRemind(AddTaskController controller) {
    final s = ref.read(stringsProvider);
    final options = [0, 5, 10, 15, 30, 60];
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.ink5,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              s.remindLabel,
              style: AppTypography.display(fontSize: 17, color: AppColors.ink),
            ),
            const SizedBox(height: 8),
            ...options.map((m) => ListTile(
                  title: Text(
                    _remindLabel(m, s),
                    style: AppTypography.body(
                      fontSize: 15,
                      color: AppColors.ink,
                    ),
                  ),
                  trailing:
                      ref.read(addTaskControllerProvider).remindBeforeMinutes ==
                              m
                          ? const Icon(Icons.check_rounded,
                              size: 20, color: AppColors.pink)
                          : null,
                  onTap: () {
                    controller.setRemindBeforeMinutes(m);
                    Navigator.pop(ctx);
                  },
                )),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _ModalRow extends StatelessWidget {
  final Color iconBg;
  final Color iconColor;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _ModalRow({
    required this.iconBg,
    required this.iconColor,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: AppTypography.body(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.ink,
              ),
            ),
            const Spacer(),
            Text(
              value,
              style: AppTypography.body(
                fontSize: 13,
                color: AppColors.ink3,
              ),
            ),
            const SizedBox(width: 4),
            CustomPaint(
              size: const Size(10, 10),
              painter: _DropdownChevron(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 52),
      height: 0.5,
      color: AppColors.border,
    );
  }
}

class _AlarmToggleRow extends StatelessWidget {
  final bool isAlarm;
  final ValueChanged<bool> onChanged;

  const _AlarmToggleRow({
    required this.isAlarm,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.coralBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.alarm_rounded,
                size: 16, color: AppColors.coral),
          ),
          const SizedBox(width: 10),
          Text(
            'Alarm', // label doesn't need localization — same in both languages
            style: AppTypography.body(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.ink,
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 28,
            child: Switch.adaptive(
              value: isAlarm,
              onChanged: onChanged,
              activeTrackColor: AppColors.coral,
            ),
          ),
        ],
      ),
    );
  }
}

class _DropdownChevron extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.ink4
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..moveTo(3, 4)
      ..lineTo(5, 6)
      ..lineTo(7, 4);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_DropdownChevron old) => false;
}
