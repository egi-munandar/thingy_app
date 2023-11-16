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
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return AutoTabsRouter(
      routes: const [
        MasterLocationRoute(),
        MasterItemRoute(),
      ],
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
                  items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.pin_drop), label: 'Location'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.add_box), label: 'Item'),
                    ])
              : null,
          body: Row(
            children: [
              mq.width > Consts.wdt.sm
                  ? NavigationRail(
                      onDestinationSelected: (value) {
                        tabsRouter.setActiveIndex(value);
                      },
                      destinations: const [
                        NavigationRailDestination(
                            icon: Icon(Icons.pin_drop),
                            label: Text("Location")),
                        NavigationRailDestination(
                            icon: Icon(Icons.add_box), label: Text("Item")),
                      ],
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
