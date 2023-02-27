import 'dart:html';
import 'package:black_pearl/pages/profile/profile_page.dart';
import 'package:black_pearl/pages/profile/update_profile.dart';
import 'package:black_pearl/pages/home/home_page.dart';
import 'package:black_pearl/pages/auth/register_page.dart';
import 'package:black_pearl/pages/test/test.dart';
import 'package:black_pearl/sevices/auth.dart';
import 'package:flutter/material.dart';
import 'package:black_pearl/pages/todo_page.dart';
import 'package:black_pearl/pages/squad_builder/squad_builder_page.dart';
//import 'package:black_pearl/pages/squad_builder/squad_builder_game.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:black_pearl/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:black_pearl/pages/auth/login_page.dart';
import 'package:black_pearl/pages/player_list/player_list_page.dart';
import 'package:black_pearl/pages/calendar/calendar_page.dart';

import 'models/router.gr.dart';

void initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

final _appRouter = AppRouter();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
/*     return MultiProvider(
        providers: [
          Provider<AuthService>(
            create: (_) => AuthService(),
          ),
        ],
        child: MaterialApp(
            /* navigatorObservers: <RouteObserver<ModalRoute<void>>>[
              routeObserver
            ], */
            title: 'Flutter Auth Example',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: './login',
            onGenerateRoute: RouteGenerator.generateRoute,
            routes: {
              //'./': (context) => Wrapper(),
              './login': (context) => LoginPage(),
              './register': (context) => RegisterPage(),
              './todo': (context) => ToDo(),
              './home': (context) => HomePage(),
              './squad_builder': (context) => SquadBuilderPage(),
              //'./squad_builder_game': (context) => SquadBuilderGame(game: ),
              './player_list': (context) => PlayerListPage(),
              './calendar': (context) => CalendarPage(),
              './profile': (context) => ProfilePage(),
              './update_profile': (context) => UpdateProfile(),
              './test': (context) => TestPage(),
              //'./player': (context) => Player(id: '',),
              //'./coach': (context) => Coach(),
            }));
  }
}
 */