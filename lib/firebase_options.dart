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
    apiKey: 'AIzaSyDWuwgpYF30YgDAIYE9WSRpqp6MmDGKiSw',
    appId: '',
    messagingSenderId: '881493058407',
    projectId: 'cogent-bison-415807',
    authDomain: 'cogent-bison-415807.firebaseapp.com',
    storageBucket: 'cogent-bison-415807.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDWuwgpYF30YgDAIYE9WSRpqp6MmDGKiSw',
    appId: '',
    messagingSenderId: '881493058407',
    projectId: 'cogent-bison-415807',
    storageBucket: 'cogent-bison-415807.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDWuwgpYF30YgDAIYE9WSRpqp6MmDGKiSw',
    appId: '',
    messagingSenderId: '881493058407',
    projectId: 'cogent-bison-415807',
    storageBucket: 'cogent-bison-415807.appspot.com',
    iosBundleId: 'com.example.chatapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDWuwgpYF30YgDAIYE9WSRpqp6MmDGKiSw',
    appId: '',
    messagingSenderId: '881493058407',
    projectId: 'cogent-bison-415807',
    storageBucket: 'cogent-bison-415807.appspot.com',
    iosBundleId: 'com.example.chatapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDWuwgpYF30YgDAIYE9WSRpqp6MmDGKiSw',
    appId: '',
    messagingSenderId: '881493058407',
    projectId: 'cogent-bison-415807',
    authDomain: 'cogent-bison-415807.firebaseapp.com',
    storageBucket: 'cogent-bison-415807.appspot.com',
  );
}
