// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    MyHomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const MyHomePage());
    },
    ProfileRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const Profile());
    },
    Profile2Route.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const Profile2());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(MyHomeRoute.name, path: '/'),
        RouteConfig(ProfileRoute.name, path: '/profile'),
        RouteConfig(Profile2Route.name, path: '/profile2')
      ];
}

/// generated route for
/// [MyHomePage]
class MyHomeRoute extends PageRouteInfo<void> {
  const MyHomeRoute() : super(MyHomeRoute.name, path: '/');

  static const String name = 'MyHomeRoute';
}

/// generated route for
/// [Profile]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute() : super(ProfileRoute.name, path: '/profile');

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [Profile2]
class Profile2Route extends PageRouteInfo<void> {
  const Profile2Route() : super(Profile2Route.name, path: '/profile2');

  static const String name = 'Profile2Route';
}
