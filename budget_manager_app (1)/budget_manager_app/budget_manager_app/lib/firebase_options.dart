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
    apiKey: 'AIzaSyBWlss9g1P5FMKihreNJs5HkUCPrFXFyRY',
    appId: '1:424852080336:web:bca9cc07ecf8c172d480d5',
    messagingSenderId: '424852080336',
    projectId: 'cartera-app-7b7d8',
    authDomain: 'cartera-app-7b7d8.firebaseapp.com',
    databaseURL: 'https://cartera-app-7b7d8-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'cartera-app-7b7d8.firebasestorage.app',
    measurementId: 'G-WCVF835XLJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDW9wVyhLgxbOuyMuwtglMiVFkgaEo_cJk',
    appId: '1:424852080336:android:b2b7a974dff8a414d480d5',
    messagingSenderId: '424852080336',
    projectId: 'cartera-app-7b7d8',
    databaseURL: 'https://cartera-app-7b7d8-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'cartera-app-7b7d8.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDEZ7fIifO1DDqnGZsmKYo6i0CuKTPNML0',
    appId: '1:424852080336:ios:8d64bc0b237cdddbd480d5',
    messagingSenderId: '424852080336',
    projectId: 'cartera-app-7b7d8',
    databaseURL: 'https://cartera-app-7b7d8-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'cartera-app-7b7d8.firebasestorage.app',
    iosBundleId: 'com.example.budgetManagerApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDEZ7fIifO1DDqnGZsmKYo6i0CuKTPNML0',
    appId: '1:424852080336:ios:8d64bc0b237cdddbd480d5',
    messagingSenderId: '424852080336',
    projectId: 'cartera-app-7b7d8',
    databaseURL: 'https://cartera-app-7b7d8-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'cartera-app-7b7d8.firebasestorage.app',
    iosBundleId: 'com.example.budgetManagerApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBWlss9g1P5FMKihreNJs5HkUCPrFXFyRY',
    appId: '1:424852080336:web:a338018f55c86670d480d5',
    messagingSenderId: '424852080336',
    projectId: 'cartera-app-7b7d8',
    authDomain: 'cartera-app-7b7d8.firebaseapp.com',
    databaseURL: 'https://cartera-app-7b7d8-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'cartera-app-7b7d8.firebasestorage.app',
    measurementId: 'G-8JWRE73XYE',
  );
}