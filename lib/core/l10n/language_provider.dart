import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'app_strings.dart';

enum AppLanguage { urdu, english }

final languageProvider =
    StateNotifierProvider<LanguageNotifier, AppLanguage>((ref) {
  final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
  return LanguageNotifier(uid);
});

final stringsProvider = Provider<AppStrings>((ref) {
  final lang = ref.watch(languageProvider);
  return lang == AppLanguage.english ? AppStrings.en : AppStrings.ur;
});

class LanguageNotifier extends StateNotifier<AppLanguage> {
  final String _uid;

  LanguageNotifier(this._uid) : super(AppLanguage.english) {
    _load();
  }

  String get _key => 'app_language_$_uid';

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_key);
    if (saved == 'urdu') {
      state = AppLanguage.urdu;
    }
  }

  Future<void> setLanguage(AppLanguage lang) async {
    state = lang;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _key, lang == AppLanguage.english ? 'english' : 'urdu');
  }
}
