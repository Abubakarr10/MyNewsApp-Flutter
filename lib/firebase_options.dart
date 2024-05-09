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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAOYUemEUyDqE0OHDGCII9gOz7V13JV0fw',
    appId: '1:319487889734:web:09e4daa66d49fb454a9547',
    messagingSenderId: '319487889734',
    projectId: 'mynewsapp-mad',
    authDomain: 'mynewsapp-mad.firebaseapp.com',
    storageBucket: 'mynewsapp-mad.appspot.com',
    measurementId: 'G-15DZK0CEFG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDDkgLrlrSpnB-vp6-9Ya2rGz8XsD7RpQI',
    appId: '1:319487889734:android:a1c3506daae6ab1f4a9547',
    messagingSenderId: '319487889734',
    projectId: 'mynewsapp-mad',
    storageBucket: 'mynewsapp-mad.appspot.com',
  );
}