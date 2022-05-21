import 'package:black_pearl/pages/squad_builder/squad_builder_game.dart';
import 'package:flutter/material.dart';
import 'package:black_pearl/pages/profile/profile.dart';
import 'package:black_pearl/pages/profile/update_profile.dart';
import 'package:black_pearl/pages/home/home_screen.dart';
import 'package:black_pearl/pages/auth/register_screen.dart';
import 'package:black_pearl/pages/test/test.dart';
import 'package:black_pearl/sevices/auth.dart';
import 'package:flutter/material.dart';
import 'package:black_pearl/pages/todo.dart';
import 'package:black_pearl/pages/squad_builder/squad_builder.dart';
//import 'package:black_pearl/pages/squad_builder/squad_builder_game.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:black_pearl/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:black_pearl/pages/auth/login_screen.dart';
import 'package:black_pearl/pages/player_list/player_list.dart';
import 'package:black_pearl/pages/calendar/calendar.dart';
import 'package:black_pearl/models/game_model.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case './login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case './register':
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case './todo':
        return MaterialPageRoute(builder: (_) => ToDo());
      case './squad_builder':
        return MaterialPageRoute(builder: (_) => SquadBuilder());
      case './player_list':
        return MaterialPageRoute(builder: (_) => PlayerList());
      case './calendar':
        return MaterialPageRoute(builder: (_) => Calendar());
      case './profile':
        return MaterialPageRoute(builder: (_) => Profile());
      case './update_profile':
        return MaterialPageRoute(builder: (_) => UpdateProfile());
      case './squad_builder_game':
        if (args is Game)
          return MaterialPageRoute(
            builder: (_) => SquadBuilderGame(
              game: args,
            ),
          );
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("404"),
        ),
        body: Center(child: Text('Page not found')),
      );
    });
  }
}
