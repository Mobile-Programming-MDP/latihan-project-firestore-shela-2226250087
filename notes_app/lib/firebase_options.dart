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
    apiKey: 'AIzaSyCILWmP1bUc9flWeLv03J0n5Fx2SXPyDjk',
    appId: '1:281659162814:web:56fdf18b40cf34bbe69eef',
    messagingSenderId: '281659162814',
    projectId: 'notes-2d3c2',
    authDomain: 'notes-2d3c2.firebaseapp.com',
    storageBucket: 'notes-2d3c2.appspot.com',
    measurementId: 'G-E0KQ7SNBM5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD69gpcJjq2T8WQyKb2gnK3LiZX6iYqTk0',
    appId: '1:281659162814:android:77a8fea402f46318e69eef',
    messagingSenderId: '281659162814',
    projectId: 'notes-2d3c2',
    storageBucket: 'notes-2d3c2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAI_iJ2C7ZQBhpJ3pAo8Q-p7TfI0NcgLbg',
    appId: '1:281659162814:ios:0d72995a5abf5cf4e69eef',
    messagingSenderId: '281659162814',
    projectId: 'notes-2d3c2',
    storageBucket: 'notes-2d3c2.appspot.com',
    iosBundleId: 'com.example.notes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAI_iJ2C7ZQBhpJ3pAo8Q-p7TfI0NcgLbg',
    appId: '1:281659162814:ios:0d72995a5abf5cf4e69eef',
    messagingSenderId: '281659162814',
    projectId: 'notes-2d3c2',
    storageBucket: 'notes-2d3c2.appspot.com',
    iosBundleId: 'com.example.notes',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCILWmP1bUc9flWeLv03J0n5Fx2SXPyDjk',
    appId: '1:281659162814:web:593f10ce185bc05fe69eef',
    messagingSenderId: '281659162814',
    projectId: 'notes-2d3c2',
    authDomain: 'notes-2d3c2.firebaseapp.com',
    storageBucket: 'notes-2d3c2.appspot.com',
    measurementId: 'G-5RR6649B0R',
  );

}