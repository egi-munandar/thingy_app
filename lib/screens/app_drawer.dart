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
          ExpansionTile(
            title: const Text("Master"),
            initiallyExpanded: context.routeData.name.contains('Master'),
            children: [
              ListTile(
                selected: context.routeData.name == MasterItemRoute.name,
                title: const Text("Item"),
                onTap: () => context.routeData.name != MasterItemRoute.name
                    ? context.router.push(const MasterItemRoute())
                    : null,
              ),
              ListTile(
                selected: context.routeData.name == MasterCurrencyRoute.name,
                title: const Text("Currency"),
                onTap: () => context.routeData.name != MasterCurrencyRoute.name
                    ? context.router.pushNamed('/master/currency')
                    : null,
              ),
              ListTile(
                selected: context.routeData.name == MasterInstanceRoute.name,
                title: const Text("Instance"),
                onTap: () => context.routeData.name != MasterInstanceRoute.name
                    ? context.router.pushNamed('/master/instance')
                    : null,
              ),
            ],
          )
        ],
      ),
    );
  }
}
