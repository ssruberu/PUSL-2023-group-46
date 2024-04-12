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
    apiKey: 'AIzaSyCua3BcwZPaoPRtV1rVJ7F-8Ifljp4h6nk',
    appId: '1:678598928402:web:647a491221e0b5457e90cb',
    messagingSenderId: '678598928402',
    projectId: 'e-commerce-mobile-applic-79db7',
    authDomain: 'e-commerce-mobile-applic-79db7.firebaseapp.com',
    storageBucket: 'e-commerce-mobile-applic-79db7.appspot.com',
    measurementId: 'G-2S336N1T0J',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDgD8p-JPs4vebbWeZDrlO5k3llPnkzX9U',
    appId: '1:678598928402:android:848de7bdfe041c1a7e90cb',
    messagingSenderId: '678598928402',
    projectId: 'e-commerce-mobile-applic-79db7',
    storageBucket: 'e-commerce-mobile-applic-79db7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDqlKSZYOGvMal0G8VFAC5idwfAKEpfyvo',
    appId: '1:678598928402:ios:7903981c9cd356f67e90cb',
    messagingSenderId: '678598928402',
    projectId: 'e-commerce-mobile-applic-79db7',
    storageBucket: 'e-commerce-mobile-applic-79db7.appspot.com',
    iosBundleId: 'com.example.sampleApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDqlKSZYOGvMal0G8VFAC5idwfAKEpfyvo',
    appId: '1:678598928402:ios:847a8467f269720c7e90cb',
    messagingSenderId: '678598928402',
    projectId: 'e-commerce-mobile-applic-79db7',
    storageBucket: 'e-commerce-mobile-applic-79db7.appspot.com',
    iosBundleId: 'com.example.sampleApp.RunnerTests',
  );
}
