import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_radius.dart';
import '../../domain/task_model.dart';
import '../../domain/task_category.dart';
import 'task_item.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final void Function(String id)? onToggle;
  final void Function(String id)? onDelete;
  final String deleteTitle;
  final String deleteBodySuffix;
  final String confirmDelete;
  final String cancelLabel;
  final String doneLabel;
  final String pendingLabel;
  final String Function(TaskCategory)? categoryNameResolver;

  const TaskList({
    super.key,
    required this.tasks,
    this.onToggle,
    this.onDelete,
    this.deleteTitle = 'Kaam hatayein?',
    this.deleteBodySuffix = 'ko hata dein?',
    this.confirmDelete = 'Haan, hatao',
    this.cancelLabel = 'Nahi',
    this.doneLabel = 'mukammal',
    this.pendingLabel = 'baaqi',
    this.categoryNameResolver,
  });

  @override
  Widget build(BuildContext context) {
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
          return Column(
            children: [
              if (i != 0)
                Container(
                  margin: const EdgeInsets.only(left: 54),
                  height: 0.5,
                  color: AppColors.border,
                ),
              TaskItem(
                task: tasks[i],
                onToggle:
                    onToggle != null ? () => onToggle!(tasks[i].id) : null,
                onDelete:
                    onDelete != null ? () => onDelete!(tasks[i].id) : null,
                deleteTitle: deleteTitle,
                deleteBodySuffix: deleteBodySuffix,
                confirmDelete: confirmDelete,
                cancelLabel: cancelLabel,
                doneLabel: doneLabel,
                pendingLabel: pendingLabel,
                categoryNameResolver: categoryNameResolver,
              ),
            ],
          );
        }),
      ),
    );
  }
}
