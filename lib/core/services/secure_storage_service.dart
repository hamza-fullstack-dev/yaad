import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../constants/app_constants.dart';

part 'secure_storage_service.g.dart';

@Riverpod(keepAlive: true)
SecureStorageService secureStorageService(SecureStorageServiceRef ref) {
  return SecureStorageService();
}

class SecureStorageService {
  static const _storage = FlutterSecureStorage();

  String _hashPin(String pin) {
    final bytes = utf8.encode(pin);
    return sha256.convert(bytes).toString();
  }

  String _pinKey(String uid) => 'diary_pin_hash_$uid';
  String _lockKey(String uid) => '${AppConstants.diaryLockEnabledKey}_$uid';

  Future<bool> isLockEnabled(String uid) async {
    final value = await _storage.read(key: _lockKey(uid));
    return value == 'true';
  }

  Future<bool> hasPinSet(String uid) async {
    final value = await _storage.read(key: _pinKey(uid));
    return value != null && value.isNotEmpty;
  }

  Future<void> setPin(String pin, {required String uid}) async {
    final hash = _hashPin(pin);
    await _storage.write(key: _pinKey(uid), value: hash);
    await _storage.write(key: _lockKey(uid), value: 'true');
  }

  Future<bool> verifyPin(String pin, {required String uid}) async {
    final stored = await _storage.read(key: _pinKey(uid));
    if (stored == null) return false;
    return _hashPin(pin) == stored;
  }

  Future<void> removePin(String uid) async {
    await _storage.delete(key: _pinKey(uid));
    await _storage.write(key: _lockKey(uid), value: 'false');
  }

  Future<void> setLockEnabled(bool enabled, {required String uid}) async {
    await _storage.write(key: _lockKey(uid), value: enabled.toString());
  }
}
