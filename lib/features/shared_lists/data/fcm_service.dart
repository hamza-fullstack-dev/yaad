import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FcmService {
  final _messaging = FirebaseMessaging.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> init() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      final token = await _messaging.getToken();
      if (token != null) {
        _pendingToken = token;
      }
    }

    _messaging.onTokenRefresh.listen((token) {
      _pendingToken = token;
      if (_currentUid != null) {
        saveTokenToFirestore(_currentUid!);
      }
    });
  }

  String? _pendingToken;
  String? _currentUid;

  Future<void> saveTokenToFirestore(String uid) async {
    _currentUid = uid;
    final token = _pendingToken ?? await _messaging.getToken();
    if (token == null) return;
    try {
      await _firestore.collection('users').doc(uid).set(
        {'fcm_token': token},
        SetOptions(merge: true),
      );
    } catch (_) {}
  }

  Future<void> removeToken(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'fcm_token': FieldValue.delete(),
      });
    } catch (_) {}
    _currentUid = null;
  }
}
