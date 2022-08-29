import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// [FirebaseOptions] for use with Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: FirebaseDefaultOptions.currentPlatform,
/// );
/// ```
class FirebaseDefaultOptions {
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
    apiKey: 'AIzaSyBU8r_H77-5KPQv6eHkZhH6PQKZJkJ7lqM',
    appId: '1:886043182999:web:bba34cf9f693e965a9a6d2',
    messagingSenderId: '886043182999',
    projectId: 'fcm-notification-183e1',
    authDomain: 'fcm-notification-183e1.firebaseapp.com',
    storageBucket: 'fcm-notification-183e1.appspot.com',
    measurementId: 'G-0C67R5NT11',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBJAR_uHeWMm2ST1cYP-IcUxoTzugwYCWI',
    appId: '1:886043182999:android:448735a113ecf314a9a6d2',
    messagingSenderId: '886043182999',
    projectId: 'fcm-notification-183e1',
    storageBucket: 'fcm-notification-183e1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBWaCWBe1JhcbStHfhDE43eCM2o6J6GACk',
    appId: '1:886043182999:ios:31d182bdaac501fba9a6d2',
    messagingSenderId: '886043182999',
    projectId: 'fcm-notification-183e1',
    storageBucket: 'fcm-notification-183e1.appspot.com',
    androidClientId:
        '886043182999-v51o1dpn4va52dlpu0shgdpgfqs2l22a.apps.googleusercontent.com',
    iosClientId:
        '886043182999-bhm5t1a4jh1b71mjthoupli58sgn1l7u.apps.googleusercontent.com',
    iosBundleId: 'com.hmh.fcmFlutter',
  );
}
