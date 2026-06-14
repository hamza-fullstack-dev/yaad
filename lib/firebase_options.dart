import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) throw UnsupportedError('Web not supported');
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError('Unsupported platform');
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA1ycEp1v_JOLUIQEC7Ov-ibVaigEu7buk',
    appId: '1:779955954934:android:2325452a18568b905778d7',
    messagingSenderId: '779955954934',
    projectId: 'yaad-app',
    storageBucket: 'yaad-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDvKl8iVWkqA3TEgvbJmoo9d00ETXpfw5Y',
    appId: '1:779955954934:ios:4fef4d88d6d049fd5778d7',
    messagingSenderId: '779955954934',
    projectId: 'yaad-app',
    storageBucket: 'yaad-app.firebasestorage.app',
    iosBundleId: 'com.yourname.yaad',
  );
}
