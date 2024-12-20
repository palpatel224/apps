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
    apiKey: 'AIzaSyBwFTQZOP0pEHOGNCMjItdO8GxR-at2HWs',
    appId: '1:294761007888:web:9b5c2faf4727174cfbf395',
    messagingSenderId: '294761007888',
    projectId: 'bootcampweek4-b6ae1',
    authDomain: 'bootcampweek4-b6ae1.firebaseapp.com',
    storageBucket: 'bootcampweek4-b6ae1.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAL9TRDmlyiGW_KfVm1FhTf4cY7as67PPk',
    appId: '1:294761007888:android:fad7f656b0d96717fbf395',
    messagingSenderId: '294761007888',
    projectId: 'bootcampweek4-b6ae1',
    storageBucket: 'bootcampweek4-b6ae1.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCW2mqwZiuCpNPzNg_LHqwU5eWAhQviprU',
    appId: '1:294761007888:ios:c5321f75aaad2133fbf395',
    messagingSenderId: '294761007888',
    projectId: 'bootcampweek4-b6ae1',
    storageBucket: 'bootcampweek4-b6ae1.firebasestorage.app',
    iosClientId: '294761007888-3csk3d31n8nj1rqti3c6u8kdmq4jrcvd.apps.googleusercontent.com',
    iosBundleId: 'com.example.week4',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCW2mqwZiuCpNPzNg_LHqwU5eWAhQviprU',
    appId: '1:294761007888:ios:c5321f75aaad2133fbf395',
    messagingSenderId: '294761007888',
    projectId: 'bootcampweek4-b6ae1',
    storageBucket: 'bootcampweek4-b6ae1.firebasestorage.app',
    iosClientId: '294761007888-3csk3d31n8nj1rqti3c6u8kdmq4jrcvd.apps.googleusercontent.com',
    iosBundleId: 'com.example.week4',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBwFTQZOP0pEHOGNCMjItdO8GxR-at2HWs',
    appId: '1:294761007888:web:1d6b2db91aff093efbf395',
    messagingSenderId: '294761007888',
    projectId: 'bootcampweek4-b6ae1',
    authDomain: 'bootcampweek4-b6ae1.firebaseapp.com',
    storageBucket: 'bootcampweek4-b6ae1.firebasestorage.app',
  );

}