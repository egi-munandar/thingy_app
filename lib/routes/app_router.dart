import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:thingy_app/constants.dart';
import 'package:thingy_app/screens/auth/change_api_url.dart';
import 'package:thingy_app/screens/home_screen.dart';
import 'package:thingy_app/screens/master/master_screen.dart';
import 'package:thingy_app/screens/master/location/master_location_screen.dart';
import 'package:thingy_app/screens/master/item/master_item_screen.dart';
import 'package:thingy_app/screens/master/instance/master_instance_screen.dart';
import 'package:thingy_app/screens/master/instance/mi_add_screen.dart';
import 'package:thingy_app/screens/master/instance/mi_edit_screen.dart';
import 'package:thingy_app/screens/master/currency/master_currency_screen.dart';
import 'package:thingy_app/screens/master/currency/mc_edit_screen.dart';
import 'package:thingy_app/screens/master/currency/mc_add_screen.dart';
import 'package:thingy_app/screens/auth/login_screen.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter implements AutoRouteGuard {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true, path: '/home'),
        AutoRoute(page: MasterRoute.page, path: '/master', children: [
          RedirectRoute(path: '', redirectTo: 'item'),
          AutoRoute(page: MasterLocationRoute.page, path: 'location'),
          AutoRoute(page: MasterItemRoute.page, path: 'item'),
          AutoRoute(page: MasterInstanceRoute.page, path: 'instance'),
          AutoRoute(page: MiAddRoute.page, path: 'instance/add'),
          AutoRoute(page: MiEditRoute.page, path: 'instance/:id/edit'),
          AutoRoute(page: MCEditRoute.page, path: 'currency/:id/edit'),
          AutoRoute(page: MasterCurrencyRoute.page, path: 'currency'),
          AutoRoute(page: McAddRoute.page, path: 'currency/add'),
        ]),
        AutoRoute(page: LoginRoute.page, path: '/login'),
        AutoRoute(page: ChangeApiUrlRoute.page, path: '/change-api-url'),
      ];

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    try {
      if (resolver.route.name == LoginRoute.name ||
          resolver.route.name == ChangeApiUrlRoute.name) {
        resolver.next();
      } else {
        await Consts.fetchUser().then((value) => resolver.next());
      }
    } catch (e) {
      push(LoginRoute(onResult: (bool didLogin) => resolver.next(didLogin)));
    }
  }
}
