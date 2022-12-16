// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAGFKq1vYnrmSsSianlT7ebK_5APhldPbk',
    appId: '1:1004809454363:web:199cbe792048192a40c9be',
    messagingSenderId: '1004809454363',
    projectId: 'gymbro-f478f',
    authDomain: 'gymbro-f478f.firebaseapp.com',
    storageBucket: 'gymbro-f478f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDkoYvfBgiNe8c8XXNiZ8ZsXQEBsM4IwSw',
    appId: '1:1004809454363:android:ec54fbfeaab39c8140c9be',
    messagingSenderId: '1004809454363',
    projectId: 'gymbro-f478f',
    storageBucket: 'gymbro-f478f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB0Yk9TtepyEp-1jteVnwEEh15PuI_vN20',
    appId: '1:1004809454363:ios:edb239401ceda20940c9be',
    messagingSenderId: '1004809454363',
    projectId: 'gymbro-f478f',
    storageBucket: 'gymbro-f478f.appspot.com',
    androidClientId: '1004809454363-s73lhs78dnmdeaorer6lld7pf41grcek.apps.googleusercontent.com',
    iosClientId: '1004809454363-396ohqhmik1qmoqg4rq89f5k6iv7lef7.apps.googleusercontent.com',
    iosBundleId: 'com.example.gymbro',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB0Yk9TtepyEp-1jteVnwEEh15PuI_vN20',
    appId: '1:1004809454363:ios:edb239401ceda20940c9be',
    messagingSenderId: '1004809454363',
    projectId: 'gymbro-f478f',
    storageBucket: 'gymbro-f478f.appspot.com',
    androidClientId: '1004809454363-s73lhs78dnmdeaorer6lld7pf41grcek.apps.googleusercontent.com',
    iosClientId: '1004809454363-396ohqhmik1qmoqg4rq89f5k6iv7lef7.apps.googleusercontent.com',
    iosBundleId: 'com.example.gymbro',
  );
}