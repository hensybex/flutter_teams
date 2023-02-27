import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../models/router.gr.dart';

class SideBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('SideMenu header'),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              context.pushRoute(const HomeRoute());
              //context.replaceRoute(const HomeRoute());
              //Navigator.pop(context);
              //Navigator.pushNamedAndRemoveUntil(
              //context, './home', (route) => false);
            },
          ),
          ListTile(
            title: const Text('ToDo list'),
            onTap: () {
              context.pushRoute(const ToDoRoute());
              //Navigator.pop(context);
              //Navigator.pushNamedAndRemoveUntil(
              //    context, './todo', (route) => false);
            },
          ),
          ListTile(
            title: const Text('Player list'),
            onTap: () {
              context.pushRoute(const PlayerListRoute());
              //Navigator.pop(context);
              //Navigator.pushNamedAndRemoveUntil(
              //    context, './player_list', (route) => false);
            },
          ),
          ListTile(
            title: const Text('Calendar'),
            onTap: () {
              context.pushRoute(const CalendarRoute());
              //Navigator.pop(context);
              //Navigator.pushNamedAndRemoveUntil(
              //    context, './calendar', (route) => false);
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              context.pushRoute(const ProfileRoute());
              //Navigator.pop(context);
              //Navigator.pushNamedAndRemoveUntil(
              //    context, './profile', (route) => false);
            },
          ),
          ListTile(
            title: const Text('Test'),
            onTap: () {
              context.pushRoute(const TestRoute());
              //Navigator.pop(context);
              //Navigator.pushNamedAndRemoveUntil(
              //    context, './test', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
