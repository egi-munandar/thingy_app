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
            leading: const Icon(Icons.dashboard),
            selected: context.routeData.name == HomeRoute.name,
            title: const Text("Home"),
            onTap: () => context.routeData.name != HomeRoute.name
                ? context.router.pushNamed('/home')
                : null,
          ),
          ExpansionTile(
            leading: const Icon(Icons.dataset),
            title: const Text("Master"),
            initiallyExpanded: context.routeData.name.contains("Master"),
            children: [
              ListTile(
                leading: const Icon(Icons.inventory),
                selected: context.routeData.name == MasterItemRoute.name,
                title: const Text("Item"),
                onTap: () => context.routeData.name != MasterItemRoute.name
                    ? context.router.push(const MasterItemRoute())
                    : null,
              ),
              ListTile(
                leading: const Icon(Icons.currency_exchange),
                selected: context.routeData.name == MasterCurrencyRoute.name,
                title: const Text("Currency"),
                onTap: () => context.routeData.name != MasterCurrencyRoute.name
                    ? context.router.push(const MasterCurrencyRoute())
                    : null,
              ),
            ],
          )
        ],
      ),
    );
  }
}
