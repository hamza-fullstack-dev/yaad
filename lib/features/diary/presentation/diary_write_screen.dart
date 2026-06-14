import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../domain/mood.dart';
import '../domain/diary_entry_model.dart';
import 'controllers/diary_write_controller.dart';
import 'widgets/mood_picker.dart';
import '../../../core/l10n/language_provider.dart';

class DiaryWriteScreen extends ConsumerStatefulWidget {
  final DiaryEntry? existingEntry;

  const DiaryWriteScreen({super.key, this.existingEntry});

  @override
  ConsumerState<DiaryWriteScreen> createState() => _DiaryWriteScreenState();
}

class _DiaryWriteScreenState extends ConsumerState<DiaryWriteScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _bodyController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initFromEntry());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _initFromEntry() {
    if (_initialized) return;
    _initialized = true;

    final entry = widget.existingEntry;
    if (entry != null) {
      final ctrl = ref.read(diaryWriteControllerProvider.notifier);
      ctrl.loadEntry(entry);
      _titleController.text = entry.title;
      _bodyController.text = entry.body;
    }
  }

  Future<bool> _onWillPop() async {
    final writeState = ref.read(diaryWriteControllerProvider);
    if (!writeState.hasContent) return true;
    final s = ref.read(stringsProvider);

    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          s.diaryLeaveTitleText,
          style: AppTypography.display(fontSize: 18, color: AppColors.ink),
        ),
        content: Text(
          s.diaryLeaveBody,
          style: AppTypography.body(fontSize: 14, color: AppColors.ink3),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
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
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              s.diaryLeaveConfirm,
              style: AppTypography.body(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.pink,
              ),
            ),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  Future<void> _save() async {
    HapticFeedback.mediumImpact();
    final ctrl = ref.read(diaryWriteControllerProvider.notifier);
    final saved = await ctrl.save();
    if (saved && mounted) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final writeState = ref.watch(diaryWriteControllerProvider);
    final s = ref.watch(stringsProvider);

    final dateStr = DateFormat('EEE, d MMM').format(DateTime.now());
    final isEditing = widget.existingEntry != null;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final canPop = await _onWillPop();
        if (canPop && mounted) Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: AppColors.cream,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 16, 22, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final canPop = await _onWillPop();
                        if (canPop && mounted) Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.borderSoft,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CustomPaint(painter: _ClosePainter()),
                      ),
                    ),
                    Text(
                      isEditing
                          ? DateFormat('EEE, d MMM')
                              .format(widget.existingEntry!.createdAt)
                          : dateStr,
                      style: AppTypography.mono(
                        fontSize: 12,
                        color: AppColors.ink3,
                      ).copyWith(letterSpacing: 0.3),
                    ),
                    GestureDetector(
                      onTap: writeState.isSaving ? null : _save,
                      child: writeState.isSaving
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.pink,
                              ),
                            )
                          : Text(
                              s.done,
                              style: AppTypography.body(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.pink,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: MoodPicker(
                  selectedIndex: writeState.mood.index,
                  onSelect: (i) {
                    ref
                        .read(diaryWriteControllerProvider.notifier)
                        .setMood(Mood.values[i]);
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(22, 0, 22, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _titleController,
                        onChanged: ref
                            .read(diaryWriteControllerProvider.notifier)
                            .setTitle,
                        style: AppTypography.display(
                          fontSize: 24,
                          color: AppColors.ink,
                        ).copyWith(letterSpacing: -0.3, height: 1.2),
                        decoration: InputDecoration(
                          hintText: s.diaryTitleHint,
                          hintStyle: AppTypography.displayItalic(
                            fontSize: 24,
                            color: AppColors.ink4,
                          ).copyWith(letterSpacing: -0.3),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        maxLines: null,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Container(height: 0.5, color: AppColors.border),
                      const SizedBox(height: AppSpacing.lg),
                      TextField(
                        controller: _bodyController,
                        onChanged: ref
                            .read(diaryWriteControllerProvider.notifier)
                            .setBody,
                        style: AppTypography.body(
                          fontSize: 15,
                          color: AppColors.ink2,
                        ).copyWith(height: 1.7),
                        decoration: InputDecoration(
                          hintText: s.diaryBodyHint,
                          hintStyle: AppTypography.body(
                            fontSize: 15,
                            color: AppColors.ink4,
                          ).copyWith(
                            fontStyle: FontStyle.italic,
                            height: 1.7,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ClosePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.ink2
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;

    final cx = size.width / 2;
    final cy = size.height / 2;

    canvas.drawLine(Offset(cx - 5, cy - 5), Offset(cx + 5, cy + 5), paint);
    canvas.drawLine(Offset(cx + 5, cy - 5), Offset(cx - 5, cy + 5), paint);
  }

  @override
  bool shouldRepaint(_ClosePainter old) => false;
}
