// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:thingy_app/constants.dart';
import 'package:thingy_app/routes/app_router.dart';
import 'package:thingy_app/screens/app_drawer.dart';

@RoutePage()
class MasterScreen extends StatefulWidget {
  const MasterScreen({super.key});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  final List<RtModl> rtList = [
    RtModl(
        icon: const Icon(Icons.inventory),
        label: "Items",
        route: const MasterItemRoute()),
    RtModl(
        icon: const Icon(Icons.home),
        label: "Instance",
        route: const MasterInstanceRoute()),
    RtModl(
        icon: const Icon(Icons.pin_drop),
        label: "Location",
        route: const MasterLocationRoute()),
    RtModl(
        icon: const Icon(Icons.currency_exchange),
        label: "Currency",
        route: const MasterCurrencyRoute()),
  ];
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return AutoTabsRouter(
      routes: rtList.map((v) => v.route).toList(),
      transitionBuilder: (context, child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: AppBar(title: const Text("MASTER")),
          drawer: const AppDrawer(),
          bottomNavigationBar: mq.width <= Consts.wdt.sm
              ? BottomNavigationBar(
                  currentIndex: tabsRouter.activeIndex,
                  onTap: (value) => tabsRouter.setActiveIndex(value),
                  items: rtList
                      .map((e) =>
                          BottomNavigationBarItem(icon: e.icon, label: e.label))
                      .toList(),
                )
              : null,
          body: Row(
            children: [
              mq.width > Consts.wdt.sm
                  ? NavigationRail(
                      onDestinationSelected: (value) {
                        tabsRouter.setActiveIndex(value);
                      },
                      destinations: rtList
                          .map((e) => NavigationRailDestination(
                              icon: e.icon, label: Text(e.label)))
                          .toList(),
                      selectedIndex: tabsRouter.activeIndex,
                    )
                  : const SizedBox(),
              Expanded(child: child)
            ],
          ),
        );
      },
    );
  }
}

class RtModl {
  final Icon icon;
  final String label;
  final PageRouteInfo route;
  RtModl({
    required this.icon,
    required this.label,
    required this.route,
  });
}
