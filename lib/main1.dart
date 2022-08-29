import 'package:fcm_flutter/firebase_options.dart';
import 'package:fcm_flutter/push_modal.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// this call back must be a high order call back
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print("Handling a background message: ${message.messageId}");
}

Future<void> requestPermissionAndReigster() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    try {
      final fcmToken = await messaging.getToken();
      print(fcmToken);
      print(settings.authorizationStatus);
    } catch (e) {
      print(e);
    }
  }
}

// void initMessaging() {
//   var androiInit = const AndroidInitializationSettings('@mipmap/ic_launcher');
//   var iosInit = const IOSInitializationSettings();
//   var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);

//   final fltNotification =
//       FlutterLocalNotificationsPlugin().resolvePlatformSpecificImplementation();
//   fltNotification.initialize(initSetting);
//   var androidDetails = const AndroidNotificationDetails('1', 'channelName',
//       channelDescription: 'channelDescription', importance: Importance.max);

//   var iosDetails = const IOSNotificationDetails();
//   var generalNotificationDetails =
//       NotificationDetails(android: androidDetails, iOS: iosDetails);
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = message.notification?.android;
//     if (notification != null && android != null) {
//       fltNotification.show(notification.hashCode, notification.title,
//           notification.body, generalNotificationDetails);
//     }
//   });
// }

void main() {
  requestPermissionAndReigster();
  // initMessaging();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final FirebaseMessaging _messaging;
  PushModal? _info;

  @override
  void initState() {
    // requestPermissionAndReigster();
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Got a message whilst in the foreground!');

    //   final not =
    //       PushModal(message.notification?.title, message.notification?.body);
    //   setState(() {
    //     _info = not;
    //     _counter++;
    //   });
    // });
    final s =
        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final not =
          PushModal(message.notification?.title, message.notification?.body);
      setState(() {
        _info = not;
        _counter++;
      });
    });
    super.initState();
  }

  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            if (_info?.title != null)
              Text(
                _info!.title!,
                style: Theme.of(context).textTheme.headline4,
              ),
            if (_info?.body != null)
              Text(
                _info!.body!,
                style: Theme.of(context).textTheme.headline4,
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
