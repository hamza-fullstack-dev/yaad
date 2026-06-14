import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_radius.dart';
import '../../tasks/domain/task_model.dart';
import '../../tasks/domain/task_category.dart';
import '../../tasks/domain/task_priority.dart';
import '../../tasks/domain/task_recurrence.dart';
import '../data/shared_list_providers.dart';
import '../domain/shared_list_model.dart';
import '../../auth/data/auth_providers.dart';
import '../../../core/l10n/language_provider.dart';

class SharedListDetailScreen extends ConsumerStatefulWidget {
  final String listId;

  const SharedListDetailScreen({super.key, required this.listId});

  @override
  ConsumerState<SharedListDetailScreen> createState() =>
      _SharedListDetailScreenState();
}

class _SharedListDetailScreenState
    extends ConsumerState<SharedListDetailScreen> {
  final _taskController = TextEditingController();

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  Future<void> _addTask() async {
    final title = _taskController.text.trim();
    if (title.isEmpty) return;

    final now = DateTime.now();
    final task = Task(
      id: const Uuid().v4(),
      title: title,
      category: TaskCategory.self_,
      dueDate: now,
      priority: TaskPriority.normal,
      recurrence: TaskRecurrence.none,
      createdAt: now,
      updatedAt: now,
    );

    _taskController.clear();
    await ref
        .read(sharedListTaskRepositoryProvider)
        .addTask(widget.listId, task);
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(stringsProvider);
    final tasksAsync = ref.watch(sharedListTasksProvider(widget.listId));
    final membersAsync = ref.watch(sharedListMembersProvider(widget.listId));

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, ref),
            const SizedBox(height: 8),
            _buildMembersStrip(membersAsync),
            const SizedBox(height: AppSpacing.md),
            _buildAddTaskRow(),
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: tasksAsync.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.pink,
                    strokeWidth: 2,
                  ),
                ),
                error: (e, _) => Center(
                  child: Text(
                    s.sharedTasksError,
                    style:
                        AppTypography.body(fontSize: 14, color: AppColors.ink3),
                  ),
                ),
                data: (tasks) {
                  if (tasks.isEmpty) {
                    return Center(
                      child: Text(
                        s.sharedTasksEmpty,
                        style: AppTypography.displayItalic(
                          fontSize: 15,
                          color: AppColors.ink4,
                        ),
                      ),
                    );
                  }

                  final pending = tasks.where((t) => !t.isCompleted).toList();
                  final done = tasks.where((t) => t.isCompleted).toList();

                  return ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    children: [
                      if (pending.isNotEmpty) ...[
                        _sectionLabel(s.sharedPending, pending.length),
                        const SizedBox(height: 8),
                        _taskCard(pending),
                      ],
                      if (done.isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.lg),
                        _sectionLabel(s.sharedCompleted, done.length),
                        const SizedBox(height: 8),
                        _taskCard(done),
                      ],
                      const SizedBox(height: 100),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref) {
    return FutureBuilder<SharedList?>(
      future: ref.read(sharedListRepositoryProvider).getList(widget.listId),
      builder: (context, snapshot) {
        final listName = snapshot.data?.name ?? '...';
        final isOwner =
            snapshot.data?.ownerId == ref.read(currentUserProvider)?.uid;

        return Padding(
          padding: const EdgeInsets.fromLTRB(22, 16, 22, 0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border, width: 0.5),
                  ),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    size: 18,
                    color: AppColors.ink,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  listName,
                  style: AppTypography.display(
                    fontSize: 22,
                    color: AppColors.ink,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: () => context.push(
                  '/invite/${widget.listId}',
                ),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.duskBg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.person_add_alt_1_rounded,
                    size: 18,
                    color: AppColors.dusk,
                  ),
                ),
              ),
              if (isOwner) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _confirmDelete(context, ref),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.coralBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.delete_outline_rounded,
                      size: 18,
                      color: AppColors.coral,
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildMembersStrip(AsyncValue<List<dynamic>> membersAsync) {
    return membersAsync.when(
      loading: () => const SizedBox(height: 32),
      error: (_, __) => const SizedBox(height: 32),
      data: (members) {
        if (members.isEmpty) return const SizedBox(height: 32);
        return SizedBox(
          height: 32,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 22),
            itemCount: members.length,
            separatorBuilder: (_, __) => const SizedBox(width: 6),
            itemBuilder: (_, i) {
              final m = members[i];
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.pinkMist,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  m.displayName.isNotEmpty ? m.displayName : m.email,
                  style: AppTypography.body(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.pinkDeep,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildAddTaskRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _taskController,
                style: AppTypography.body(fontSize: 14, color: AppColors.ink),
                decoration: InputDecoration(
                  hintText: ref.read(stringsProvider).sharedTaskHint,
                  hintStyle:
                      AppTypography.body(fontSize: 14, color: AppColors.ink4),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                onSubmitted: (_) => _addTask(),
              ),
            ),
            GestureDetector(
              onTap: _addTask,
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.pink,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.add_rounded,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String label, int count) {
    return Row(
      children: [
        Text(
          label,
          style: AppTypography.body(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.ink,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.pinkMist,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            '$count',
            style: AppTypography.body(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.pinkDeep,
            ),
          ),
        ),
      ],
    );
  }

  Widget _taskCard(List<Task> tasks) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.border, width: 0.5),
        boxShadow: AppShadows.sm,
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: List.generate(tasks.length, (i) {
          final task = tasks[i];
          return Column(
            children: [
              if (i != 0)
                Container(
                  margin: const EdgeInsets.only(left: 54),
                  height: 0.5,
                  color: AppColors.border,
                ),
              GestureDetector(
                onTap: () => ref
                    .read(sharedListTaskRepositoryProvider)
                    .toggleTask(widget.listId, task.id, !task.isCompleted),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: task.isCompleted
                              ? AppColors.pink
                              : Colors.transparent,
                          border: task.isCompleted
                              ? null
                              : Border.all(color: AppColors.ink5, width: 1.5),
                        ),
                        child: task.isCompleted
                            ? const Icon(Icons.check_rounded,
                                size: 14, color: Colors.white)
                            : null,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          task.title,
                          style: task.isCompleted
                              ? AppTypography.taskTitleDone
                              : AppTypography.taskTitle,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => ref
                            .read(sharedListTaskRepositoryProvider)
                            .deleteTask(widget.listId, task.id),
                        child: Icon(
                          Icons.close_rounded,
                          size: 16,
                          color: AppColors.ink5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    final s = ref.read(stringsProvider);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          s.sharedDeleteTitle,
          style: AppTypography.display(fontSize: 19, color: AppColors.ink),
        ),
        content: Text(
          s.sharedDeleteBody,
          style: AppTypography.body(fontSize: 14, color: AppColors.ink3),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              s.no,
              style: AppTypography.body(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.ink3,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              await ref
                  .read(sharedListRepositoryProvider)
                  .deleteList(widget.listId);
              if (context.mounted) context.pop();
            },
            child: Text(
              s.sharedDeleteConfirm,
              style: AppTypography.body(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.coral,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
