import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:google_sign_in/google_sign_in.dart';
import '../domain/user_model.dart';

class AuthRepository {
  final fb_auth.FirebaseAuth _auth = fb_auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<YaadUser?> authStateChanges() {
    return _auth.authStateChanges().map(
          (user) => user != null ? YaadUser.fromFirebaseUser(user) : null,
        );
  }

  YaadUser? get currentUser {
    final user = _auth.currentUser;
    return user != null ? YaadUser.fromFirebaseUser(user) : null;
  }

  Future<YaadUser> signInWithEmail(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return YaadUser.fromFirebaseUser(result.user!);
  }

  Future<YaadUser> signUpWithEmail(
    String email,
    String password,
    String name,
  ) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await result.user!.updateDisplayName(name);
    await result.user!.reload();
    final updated = _auth.currentUser!;
    return YaadUser.fromFirebaseUser(updated);
  }

  Future<YaadUser> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw fb_auth.FirebaseAuthException(
        code: 'sign-in-cancelled',
        message: 'Google sign in cancelled',
      );
    }
    final googleAuth = await googleUser.authentication;
    final credential = fb_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final result = await _auth.signInWithCredential(credential);
    return YaadUser.fromFirebaseUser(result.user!);
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Future<void> sendPasswordReset(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> deleteAccount() async {
    await _auth.currentUser?.delete();
  }
}
