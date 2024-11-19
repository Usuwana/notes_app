// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDgD9ye8oKch0TxQqNIDnkmGTNKmASW0G8',
    appId: '1:533882279656:web:85b2d023096d8531c61b5d',
    messagingSenderId: '533882279656',
    projectId: 'notes-23ba6',
    authDomain: 'notes-23ba6.firebaseapp.com',
    storageBucket: 'notes-23ba6.firebasestorage.app',
    measurementId: 'G-4CDCVFFEFP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAEcdSy962VXAuBAIYNqbLrayy1eqhKLGY',
    appId: '1:533882279656:android:624ee6bb7f217680c61b5d',
    messagingSenderId: '533882279656',
    projectId: 'notes-23ba6',
    storageBucket: 'notes-23ba6.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBnSrzaK4S612ivQVuiPW_mfEQWfj-azlA',
    appId: '1:533882279656:ios:746758cfa08fb94cc61b5d',
    messagingSenderId: '533882279656',
    projectId: 'notes-23ba6',
    storageBucket: 'notes-23ba6.firebasestorage.app',
    iosBundleId: 'com.example.notesApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBnSrzaK4S612ivQVuiPW_mfEQWfj-azlA',
    appId: '1:533882279656:ios:746758cfa08fb94cc61b5d',
    messagingSenderId: '533882279656',
    projectId: 'notes-23ba6',
    storageBucket: 'notes-23ba6.firebasestorage.app',
    iosBundleId: 'com.example.notesApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDgD9ye8oKch0TxQqNIDnkmGTNKmASW0G8',
    appId: '1:533882279656:web:fed27dc169bfdc6bc61b5d',
    messagingSenderId: '533882279656',
    projectId: 'notes-23ba6',
    authDomain: 'notes-23ba6.firebaseapp.com',
    storageBucket: 'notes-23ba6.firebasestorage.app',
    measurementId: 'G-3WC11VJKXW',
  );
}
