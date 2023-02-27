import 'package:auto_route/auto_route.dart';
import 'package:black_pearl/pages/auth/login_page.dart';
import 'package:black_pearl/pages/auth/register_page.dart';
import 'package:black_pearl/pages/calendar/calendar_page.dart';
import 'package:black_pearl/pages/home/home_page.dart';
import 'package:black_pearl/pages/player_list/player_list_page.dart';
import 'package:black_pearl/pages/profile/profile_page.dart';
import 'package:black_pearl/pages/squad_builder/squad_builder_page.dart';
import 'package:black_pearl/pages/test/test.dart';

import '../pages/todo_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/login', page: LoginPage, initial: true),
    AutoRoute(path: '/register', page: RegisterPage, initial: true),
    AutoRoute(path: '/home', page: HomePage),
    AutoRoute(path: '/todo', page: ToDoPage),
    AutoRoute(path: '/calendar', page: CalendarPage),
    AutoRoute(path: '/player_list', page: PlayerListPage),
    AutoRoute(path: '/profile', page: ProfilePage),
    AutoRoute(path: '/squad_builder/:gameId', page: SquadBuilderPage),
    AutoRoute(path: '/test', page: TestPage),
  ],
)
class $AppRouter {}
