import 'package:auto_route/auto_route.dart';
import 'package:fcm_flutter/main.dart';
import 'package:fcm_flutter/profile.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/', page: MyHomePage, initial: true),
    AutoRoute(path: '/profile', name: 'ProfileRoute', page: Profile),
    AutoRoute(path: '/profile2', name: 'Profile2Route', page: Profile2),
  ],
)
class AppRouter extends _$AppRouter {}
