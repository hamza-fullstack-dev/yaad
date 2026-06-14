import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/diary_providers.dart';
import '../../domain/diary_entry_model.dart';
import '../../domain/mood.dart';

part 'diary_write_controller.freezed.dart';
part 'diary_write_controller.g.dart';

@freezed
class DiaryWriteState with _$DiaryWriteState {
  const factory DiaryWriteState({
    @Default('') String title,
    @Default('') String body,
    @Default(Mood.shukar) Mood mood,
    @Default(false) bool isSaving,
    String? editingId,
  }) = _DiaryWriteState;
}

extension DiaryWriteStateX on DiaryWriteState {
  bool get hasContent => title.trim().isNotEmpty || body.trim().isNotEmpty;
}

@riverpod
class DiaryWriteController extends _$DiaryWriteController {
  @override
  DiaryWriteState build() => const DiaryWriteState();

  void setTitle(String value) => state = state.copyWith(title: value);
  void setBody(String value) => state = state.copyWith(body: value);
  void setMood(Mood value) => state = state.copyWith(mood: value);

  void loadEntry(DiaryEntry entry) {
    state = DiaryWriteState(
      title: entry.title,
      body: entry.body,
      mood: entry.mood,
      editingId: entry.id,
    );
  }

  Future<bool> save() async {
    if (state.title.trim().isEmpty) return false;

    state = state.copyWith(isSaving: true);
    try {
      final repo = ref.read(diaryRepositoryProvider);
      final now = DateTime.now();

      if (state.editingId != null) {
        final existing = await repo.getById(state.editingId!);
        await repo.updateEntry(DiaryEntry(
          id: state.editingId!,
          title: state.title.trim(),
          body: state.body.trim(),
          mood: state.mood,
          createdAt: existing?.createdAt ?? now,
          updatedAt: now,
        ));
      } else {
        await repo.createEntry(DiaryEntry(
          id: '',
          title: state.title.trim(),
          body: state.body.trim(),
          mood: state.mood,
          createdAt: now,
          updatedAt: now,
        ));
      }

      return true;
    } catch (_) {
      return false;
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }
}
