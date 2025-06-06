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
    apiKey: 'AIzaSyBESYCD65JcNqs4-jABui5SjTyZ38k1aR0',
    appId: '1:696915250131:web:31453fe3ba2f6268d97d26',
    messagingSenderId: '696915250131',
    projectId: 'koren-app-f056c',
    authDomain: 'koren-app-f056c.firebaseapp.com',
    storageBucket: 'koren-app-f056c.firebasestorage.app',
    measurementId: 'G-HN9VGT54QX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCHEyupvv2CnJJi_QjLBmWJhCk7mlvdflQ',
    appId: '1:696915250131:android:79d450f28e806541d97d26',
    messagingSenderId: '696915250131',
    projectId: 'koren-app-f056c',
    storageBucket: 'koren-app-f056c.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCRc4JXqjAfS0hphMzP-XgG9qGhT9-GVps',
    appId: '1:696915250131:ios:ed8bf9be0205b63dd97d26',
    messagingSenderId: '696915250131',
    projectId: 'koren-app-f056c',
    storageBucket: 'koren-app-f056c.firebasestorage.app',
    iosBundleId: 'com.example.korenApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCRc4JXqjAfS0hphMzP-XgG9qGhT9-GVps',
    appId: '1:696915250131:ios:ed8bf9be0205b63dd97d26',
    messagingSenderId: '696915250131',
    projectId: 'koren-app-f056c',
    storageBucket: 'koren-app-f056c.firebasestorage.app',
    iosBundleId: 'com.example.korenApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBESYCD65JcNqs4-jABui5SjTyZ38k1aR0',
    appId: '1:696915250131:web:3ab8434fe9d39ec4d97d26',
    messagingSenderId: '696915250131',
    projectId: 'koren-app-f056c',
    authDomain: 'koren-app-f056c.firebaseapp.com',
    storageBucket: 'koren-app-f056c.firebasestorage.app',
    measurementId: 'G-3Z25RV4DGV',
  );
}
