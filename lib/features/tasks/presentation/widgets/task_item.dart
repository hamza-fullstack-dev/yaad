import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/task_model.dart';
import '../../domain/task_category.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  final VoidCallback? onToggle;
  final VoidCallback? onDelete;
  final String deleteTitle;
  final String deleteBodySuffix;
  final String confirmDelete;
  final String cancelLabel;
  final String doneLabel;
  final String pendingLabel;
  final String Function(TaskCategory)? categoryNameResolver;

  const TaskItem({
    super.key,
    required this.task,
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
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  bool _prevCompleted = false;

  @override
  void initState() {
    super.initState();
    _prevCompleted = widget.task.isCompleted;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(TaskItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.task.isCompleted && !_prevCompleted) {
      _controller.forward(from: 0);
    }
    _prevCompleted = widget.task.isCompleted;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          widget.deleteTitle,
          style: AppTypography.display(fontSize: 18, color: AppColors.ink),
        ),
        content: Text(
          '"${widget.task.title}" ${widget.deleteBodySuffix}',
          style: AppTypography.body(fontSize: 14, color: AppColors.ink3),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              widget.cancelLabel,
              style: AppTypography.body(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.ink3,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              widget.onDelete?.call();
            },
            child: Text(
              widget.confirmDelete,
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

  String get _timeText {
    if (widget.task.dueTimeMinutes == null) return '';
    final h = widget.task.dueTimeMinutes! ~/ 60;
    final m = widget.task.dueTimeMinutes! % 60;
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final isDone = widget.task.isCompleted;

    return RepaintBoundary(
      child: Semantics(
        label:
            '${widget.task.title}, ${isDone ? widget.doneLabel : widget.pendingLabel}',
        button: true,
        child: GestureDetector(
          onTap: widget.onToggle,
          onLongPress: widget.onDelete != null
              ? () {
                  HapticFeedback.mediumImpact();
                  _showDeleteDialog(context);
                }
              : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            color: Colors.transparent,
            child: Row(
              children: [
                GestureDetector(
                  onTap: widget.onToggle,
                  child: AnimatedBuilder(
                    animation: _scaleAnim,
                    builder: (context, child) => Transform.scale(
                      scale: _scaleAnim.value,
                      child: child,
                    ),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDone ? AppColors.pink : AppColors.cream,
                        border: isDone
                            ? null
                            : Border.all(color: AppColors.ink5, width: 1.5),
                        boxShadow: isDone
                            ? const [
                                BoxShadow(
                                  color: Color(0x4CD4537E),
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                )
                              ]
                            : null,
                      ),
                      child: isDone
                          ? CustomPaint(painter: _CheckmarkPainter())
                          : null,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: isDone
                            ? AppTypography.body(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w500,
                                color: AppColors.ink4,
                              ).copyWith(
                                decoration: TextDecoration.lineThrough,
                                decorationColor:
                                    AppColors.pink.withValues(alpha: 0.5),
                                letterSpacing: -0.1,
                                height: 1.35,
                              )
                            : AppTypography.body(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w500,
                                color: AppColors.ink,
                              ).copyWith(letterSpacing: -0.1, height: 1.35),
                        child: Text(widget.task.title),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          if (_timeText.isNotEmpty) ...[
                            Text(
                              _timeText,
                              style: AppTypography.mono(
                                fontSize: 11.5,
                                color: AppColors.ink4,
                              ),
                            ),
                            const SizedBox(width: 7),
                          ],
                          _TagChip(
                            category: widget.task.category,
                            label: widget.categoryNameResolver
                                    ?.call(widget.task.category) ??
                                widget.task.category.displayName,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CheckmarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final scaleX = size.width / 11;
    final scaleY = size.height / 8;

    final path = Path()
      ..moveTo(1 * scaleX, 4 * scaleY)
      ..lineTo(4 * scaleX, 7 * scaleY)
      ..lineTo(10 * scaleX, 1 * scaleY);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CheckmarkPainter oldDelegate) => false;
}

class _TagChip extends StatelessWidget {
  final TaskCategory category;
  final String label;

  const _TagChip({required this.category, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
      decoration: BoxDecoration(
        color: category.bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: AppTypography.body(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: category.color,
        ).copyWith(letterSpacing: 0.2),
      ),
    );
  }
}
