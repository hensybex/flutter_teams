// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;

import '../pages/auth/login_page.dart' as _i1;
import '../pages/auth/register_page.dart' as _i2;
import '../pages/calendar/calendar_page.dart' as _i5;
import '../pages/home/home_page.dart' as _i3;
import '../pages/player_list/player_list_page.dart' as _i6;
import '../pages/profile/profile_page.dart' as _i7;
import '../pages/squad_builder/squad_builder_page.dart' as _i8;
import '../pages/test/test.dart' as _i9;
import '../pages/todo_page.dart' as _i4;

class AppRouter extends _i10.RootStackRouter {
  AppRouter([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.LoginPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.RegisterPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.HomePage(),
      );
    },
    ToDoRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.ToDoPage(),
      );
    },
    CalendarRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.CalendarPage(),
      );
    },
    PlayerListRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.PlayerListPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.ProfilePage(),
      );
    },
    SquadBuilderRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SquadBuilderRouteArgs>(
          orElse: () =>
              SquadBuilderRouteArgs(gameId: pathParams.getString('gameId')));
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.SquadBuilderPage(
          key: args.key,
          gameId: args.gameId,
        ),
      );
    },
    TestRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.TestPage(),
      );
    },
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/login',
          fullMatch: true,
        ),
        _i10.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i10.RouteConfig(
          RegisterRoute.name,
          path: '/register',
        ),
        _i10.RouteConfig(
          HomeRoute.name,
          path: '/home',
        ),
        _i10.RouteConfig(
          ToDoRoute.name,
          path: '/todo',
        ),
        _i10.RouteConfig(
          CalendarRoute.name,
          path: '/calendar',
        ),
        _i10.RouteConfig(
          PlayerListRoute.name,
          path: '/player_list',
        ),
        _i10.RouteConfig(
          ProfileRoute.name,
          path: '/profile',
        ),
        _i10.RouteConfig(
          SquadBuilderRoute.name,
          path: '/squad_builder/:gameId',
        ),
        _i10.RouteConfig(
          TestRoute.name,
          path: '/test',
        ),
      ];
}

/// generated route for
/// [_i1.LoginPage]
class LoginRoute extends _i10.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i2.RegisterPage]
class RegisterRoute extends _i10.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: '/register',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.ToDoPage]
class ToDoRoute extends _i10.PageRouteInfo<void> {
  const ToDoRoute()
      : super(
          ToDoRoute.name,
          path: '/todo',
        );

  static const String name = 'ToDoRoute';
}

/// generated route for
/// [_i5.CalendarPage]
class CalendarRoute extends _i10.PageRouteInfo<void> {
  const CalendarRoute()
      : super(
          CalendarRoute.name,
          path: '/calendar',
        );

  static const String name = 'CalendarRoute';
}

/// generated route for
/// [_i6.PlayerListPage]
class PlayerListRoute extends _i10.PageRouteInfo<void> {
  const PlayerListRoute()
      : super(
          PlayerListRoute.name,
          path: '/player_list',
        );

  static const String name = 'PlayerListRoute';
}

/// generated route for
/// [_i7.ProfilePage]
class ProfileRoute extends _i10.PageRouteInfo<void> {
  const ProfileRoute()
      : super(
          ProfileRoute.name,
          path: '/profile',
        );

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i8.SquadBuilderPage]
class SquadBuilderRoute extends _i10.PageRouteInfo<SquadBuilderRouteArgs> {
  SquadBuilderRoute({
    _i11.Key? key,
    required String gameId,
  }) : super(
          SquadBuilderRoute.name,
          path: '/squad_builder/:gameId',
          args: SquadBuilderRouteArgs(
            key: key,
            gameId: gameId,
          ),
          rawPathParams: {'gameId': gameId},
        );

  static const String name = 'SquadBuilderRoute';
}

class SquadBuilderRouteArgs {
  const SquadBuilderRouteArgs({
    this.key,
    required this.gameId,
  });

  final _i11.Key? key;

  final String gameId;

  @override
  String toString() {
    return 'SquadBuilderRouteArgs{key: $key, gameId: $gameId}';
  }
}

/// generated route for
/// [_i9.TestPage]
class TestRoute extends _i10.PageRouteInfo<void> {
  const TestRoute()
      : super(
          TestRoute.name,
          path: '/test',
        );

  static const String name = 'TestRoute';
}
