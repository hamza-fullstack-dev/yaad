import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class YaadUser with _$YaadUser {
  const factory YaadUser({
    required String uid,
    required String email,
    String? displayName,
    String? photoUrl,
    required DateTime createdAt,
  }) = _YaadUser;

  factory YaadUser.fromFirebaseUser(firebase_auth.User firebaseUser) {
    return YaadUser(
      uid: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL,
      createdAt: firebaseUser.metadata.creationTime ?? DateTime.now(),
    );
  }

  factory YaadUser.fromJson(Map<String, dynamic> json) =>
      _$YaadUserFromJson(json);
}
