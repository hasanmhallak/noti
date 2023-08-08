import 'dart:async';
import 'package:flutter/scheduler.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fcm_flutter/notifications/infrastructure/notification_remote_service.dart';
import 'package:fcm_flutter/profile.dart';
import 'package:fcm_flutter/push_modal.dart';
import 'package:fcm_flutter/routes/app_router.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';

final n = NotificationRemoteService();
Future<void> _backgroundHandler(RemoteMessage message) async {
  await n.insureInitialization();

  print("Handling a background message: ${message.messageId}");
  print(message.data);
}

void main() async {
  await n.insureInitialization();
  await n.registerNotificationChannel();
  n.onBackgroundMessage(_backgroundHandler);
  final token = await n.getToken();
  if (token != null) print(token);

  // timeDilation = 100;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // routeInformationParser: _router.defaultRouteParser(),
      // routerDelegate: _router.delegate(),
      builder: (context, child) {
        n.onMessageOpenedApp.listen((message) async {
          print('onMessageOpenedApp');
          final route = message.data["deep_link"];
          if (route != null) {
            // _router.replaceAll(const [
            //   MyHomeRoute(),
            //   ProfileRoute(),
            //   Profile2Route(),
            // ]);
            // final nav = child!.key as GlobalKey<NavigatorState>;
            // final route = MaterialPageRoute(builder: (c) => const Profile2());
            // _key.currentState!.push(route);
            // final asd = MaterialPageRoute(builder: (c) => const Profile());
            // _key.currentState!
            //     .replaceRouteBelow(anchorRoute: route, newRoute: asd);

            // _key.currentState!.replaceRouteBelow(
            //     anchorRoute: MaterialPageRoute(builder: (c) => const Profile()),
            //     newRoute:
            //         MaterialPageRoute(builder: (c) => const MyHomePage()));
          }
        });
        return child!;
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
    // initialRoute: '/',
    // getPages: [
    //   GetPage(name: '/', page: () => const MyHomePage()),
    //   GetPage(name: '/p', page: () => const Profile()),
    //   GetPage(name: '/p2', page: () => const Profile2()),
    // ]);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PushModal? _info;
  int _counter = 0;
  StreamSubscription? onMessageSubscription;
  StreamSubscription? onMessageOpenedApp;

  @override
  void initState() {
    onMessageSubscription = n.onMessage
        .listen((event) => print('Got a message whilst in the foreground!'));
    super.initState();
  }

  @override
  void dispose() {
    onMessageSubscription?.cancel();
    onMessageOpenedApp?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
        onPressed: () {
          // Get.to(const Profile(),
          //     transition: Transition.noTransition, fullscreenDialog: true);
          // Get.to(Profile2(),
          //     transition: Transition.noTransition, arguments: {'1': 1});
          Navigator.push(
              context,
              MyPageRoute(
                  builder: (context) {
                    return const Profile2();
                  },
                  settings: const RouteSettings(arguments: {'1': 2})));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MyPageRoute<T> extends MaterialPageRoute<T> {
  MyPageRoute({required super.builder, super.settings});

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final PageTransitionsTheme theme = Theme.of(context).pageTransitionsTheme;
    // return theme.buildTransitions<T>(
    //     this, context, AnimationController(vsync: ), secondaryAnimation, child);
    final _tween = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    );
    animation.addListener(() {
      print(controller?.value);
      if (animation.value >= 0.3) {
        _tween.begin = Offset(0.0, 0.0);
        // animation.removeListener(() { })
      }
    });
    return SlideTransition(
      position: animation.drive(_tween),
      child: child, // child is the value returned by pageBuilder
    );
  }
}