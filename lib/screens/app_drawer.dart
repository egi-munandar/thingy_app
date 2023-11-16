import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:thingy_app/routes/app_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Text("Drawer Header"),
          ),
          ListTile(
            selected: context.routeData.name == HomeRoute.name,
            title: const Text("Home"),
            onTap: () => context.routeData.name != HomeRoute.name
                ? context.router.pushNamed('/home')
                : null,
          ),
          ListTile(
            selected: context.routeData.path == '/master',
            title: const Text("Master"),
            onTap: () => context.routeData.name != MasterRoute.name
                ? context.router.pushNamed('/master')
                : null,
          ),
        ],
      ),
    );
  }
}
