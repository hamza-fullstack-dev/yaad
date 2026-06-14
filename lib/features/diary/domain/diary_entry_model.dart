import 'package:freezed_annotation/freezed_annotation.dart';
import 'mood.dart';

part 'diary_entry_model.freezed.dart';
part 'diary_entry_model.g.dart';

@freezed
class DiaryEntry with _$DiaryEntry {
  const factory DiaryEntry({
    required String id,
    required String title,
    required String body,
    required Mood mood,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DiaryEntry;

  factory DiaryEntry.fromJson(Map<String, dynamic> json) =>
      _$DiaryEntryFromJson(json);
}
