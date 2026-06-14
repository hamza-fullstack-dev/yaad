import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/widgets/yaad_loading_skeleton.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/services/secure_storage_service.dart';
import '../../auth/data/auth_providers.dart';
import '../data/diary_providers.dart';
import '../domain/diary_entry_model.dart';
import 'widgets/month_label.dart';
import '../../../core/widgets/yaad_tab_bar.dart';
import '../../../core/widgets/yaad_error_state.dart';
import '../../../core/widgets/yaad_empty_state.dart';
import '../../../core/l10n/language_provider.dart';
import '../../../core/l10n/app_strings.dart';

class DiaryListScreen extends ConsumerWidget {
  const DiaryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(stringsProvider);
    final entriesAsync = ref.watch(allDiaryEntriesProvider);

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Stack(
        children: [
          entriesAsync.when(
            loading: () => _buildShimmer(),
            error: (e, _) => YaadErrorState(
              message: s.diaryLoadError,
              onRetry: () => ref.invalidate(allDiaryEntriesProvider),
            ),
            data: (entries) => entries.isEmpty
                ? _buildEmpty(context, s)
                : _buildList(context, ref, entries, s),
          ),
          Positioned(
            right: 22,
            bottom: 100,
            child: Tooltip(
              message: s.diaryWriteTooltip,
              child: GestureDetector(
                onTap: () => context.push(RouteNames.diaryWrite),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.pink,
                    shape: BoxShape.circle,
                    boxShadow: AppShadows.fab,
                  ),
                  child: CustomPaint(painter: _PenFabPainter()),
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: YaadTabBar(activeIndex: 2),
          ),
        ],
      ),
    );
  }

  void _showDeleteDiaryDialog(
      BuildContext context, WidgetRef ref, DiaryEntry entry) {
    final s = ref.read(stringsProvider);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          s.diaryDeleteTitle,
          style: AppTypography.display(fontSize: 18, color: AppColors.ink),
        ),
        content: Text(
          '"${entry.title}" ${s.diaryDeleteBody}',
          style: AppTypography.body(fontSize: 14, color: AppColors.ink3),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              s.no,
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
              ref.read(diaryRepositoryProvider).deleteEntry(entry.id);
            },
            child: Text(
              s.diaryDeleteConfirm,
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

  Widget _buildList(BuildContext context, WidgetRef ref,
      List<DiaryEntry> entries, AppStrings s) {
    final grouped = <String, List<DiaryEntry>>{};
    for (final entry in entries) {
      final key = DateFormat('MMMM yyyy').format(entry.createdAt);
      grouped.putIfAbsent(key, () => []).add(entry);
    }

    final widgets = <Widget>[];
    for (final monthKey in grouped.keys) {
      widgets.add(MonthLabel(label: monthKey));
      for (final entry in grouped[monthKey]!) {
        widgets.add(_DiaryTile(
          entry: entry,
          onTap: () => context.push(RouteNames.diaryWrite, extra: entry),
          onLongPress: () {
            HapticFeedback.mediumImpact();
            _showDeleteDiaryDialog(context, ref, entry);
          },
        ));
      }
    }

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 60)),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(22, 0, 22, 120),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildHeader(context, s),
              ...widgets,
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, AppStrings s) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          s.diaryTitle,
          style: AppTypography.displayItalic(
            fontSize: 36,
            color: AppColors.ink,
          ).copyWith(letterSpacing: -0.5),
        ),
        Consumer(builder: (context, ref, _) {
          return FutureBuilder<bool>(
            future: ref
                .read(secureStorageServiceProvider)
                .isLockEnabled(ref.read(currentUserProvider)?.uid ?? ''),
            builder: (context, snap) {
              final locked = snap.data ?? false;
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: locked ? AppColors.sageBg : AppColors.borderSoft,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  children: [
                    CustomPaint(
                      size: const Size(10, 10),
                      painter: _LockIconPainter(
                        color: locked ? AppColors.sage : AppColors.ink4,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      locked ? s.diaryLocked : s.diaryUnlocked,
                      style: AppTypography.body(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: locked ? AppColors.sage : AppColors.ink4,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ],
    );
  }

  Widget _buildEmpty(BuildContext context, AppStrings s) {
    return Center(
      child: YaadEmptyState(
        title: s.diaryEmptyTitle,
        subtitle: s.diaryEmptySubtitle,
        ctaLabel: s.diaryEmptyCta,
        onCtaTap: () => context.push(RouteNames.diaryWrite),
      ),
    );
  }

  Widget _buildShimmer() {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 60)),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(22, 0, 22, 120),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              YaadLoadingSkeleton.diaryList(),
            ]),
          ),
        ),
      ],
    );
  }
}

class _DiaryTile extends StatelessWidget {
  final DiaryEntry entry;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const _DiaryTile({required this.entry, this.onTap, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    final dayStr = DateFormat('dd').format(entry.createdAt);
    final weekdayStr = DateFormat('EEE').format(entry.createdAt);

    return RepaintBoundary(
      child: Semantics(
        label: '${entry.title}, ${entry.mood.displayName}',
        button: true,
        child: GestureDetector(
          onTap: onTap,
          onLongPress: onLongPress,
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border, width: 0.5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 36,
                  child: Column(
                    children: [
                      Text(
                        dayStr,
                        style: AppTypography.displayItalic(
                          fontSize: 22,
                          color: AppColors.pink,
                        ).copyWith(letterSpacing: -0.5, height: 1),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        weekdayStr,
                        style: AppTypography.mono(
                          fontSize: 10,
                          color: AppColors.ink4,
                        ).copyWith(letterSpacing: 0.3),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 0.5,
                  height: 70,
                  color: AppColors.border,
                  margin: const EdgeInsets.symmetric(horizontal: 14),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.title,
                        style: AppTypography.body(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.ink,
                        ).copyWith(letterSpacing: -0.1),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        entry.body,
                        style: AppTypography.body(
                          fontSize: 12,
                          color: AppColors.ink3,
                        ).copyWith(height: 1.5),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(
                              color: entry.mood.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            entry.mood.displayName,
                            style: AppTypography.body(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: entry.mood.color,
                            ),
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

class _LockIconPainter extends CustomPainter {
  final Color color;
  _LockIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(2, 4.5, 6, 5),
        const Radius.circular(0.8),
      ),
      paint,
    );

    final shacklePath = Path()
      ..moveTo(3.5, 4.5)
      ..lineTo(3.5, 3)
      ..quadraticBezierTo(3.5, 1, 5, 1)
      ..quadraticBezierTo(6.5, 1, 6.5, 3)
      ..lineTo(6.5, 4.5);
    canvas.drawPath(shacklePath, paint);
  }

  @override
  bool shouldRepaint(_LockIconPainter old) => old.color != color;
}

class _PenFabPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final cx = size.width / 2;
    final cy = size.height / 2;

    final path = Path()
      ..moveTo(cx - 8, cy + 8)
      ..lineTo(cx - 4, cy + 4)
      ..lineTo(cx + 6, cy - 6)
      ..cubicTo(cx + 7, cy - 7, cx + 9, cy - 6.5, cx + 8, cy - 5)
      ..lineTo(cx - 2, cy + 5)
      ..lineTo(cx - 6, cy + 8)
      ..close();
    canvas.drawPath(path, paint);

    canvas.drawLine(
      Offset(cx + 3, cy - 3),
      Offset(cx + 5, cy - 1),
      paint,
    );
  }

  @override
  bool shouldRepaint(_PenFabPainter old) => false;
}
