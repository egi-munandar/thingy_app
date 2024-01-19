// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    ChangeApiUrlRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChangeApiUrlScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginScreen(
          key: args.key,
          onResult: args.onResult,
        ),
      );
    },
    MasterCurrencyRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MasterCurrencyScreen(),
      );
    },
    MasterItemRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MasterItemScreen(),
      );
    },
    MasterLocationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MasterLocationScreen(),
      );
    },
    MasterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MasterScreen(),
      );
    },
    McAddRoute.name: (routeData) {
      final args = routeData.argsAs<McAddRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: McAddScreen(
          key: args.key,
          onResult: args.onResult,
        ),
      );
    },
    McDetailRoute.name: (routeData) {
      final args = routeData.argsAs<McDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: McDetailScreen(
          key: args.key,
          currency: args.currency,
        ),
      );
    },
    McEditRoute.name: (routeData) {
      final args = routeData.argsAs<McEditRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: McEditScreen(
          key: args.key,
          currency: args.currency,
          onResult: args.onResult,
        ),
      );
    },
  };
}

/// generated route for
/// [ChangeApiUrlScreen]
class ChangeApiUrlRoute extends PageRouteInfo<void> {
  const ChangeApiUrlRoute({List<PageRouteInfo>? children})
      : super(
          ChangeApiUrlRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangeApiUrlRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    Key? key,
    required dynamic Function(bool) onResult,
    List<PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(
            key: key,
            onResult: onResult,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<LoginRouteArgs> page = PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    required this.onResult,
  });

  final Key? key;

  final dynamic Function(bool) onResult;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onResult: $onResult}';
  }
}

/// generated route for
/// [MasterCurrencyScreen]
class MasterCurrencyRoute extends PageRouteInfo<void> {
  const MasterCurrencyRoute({List<PageRouteInfo>? children})
      : super(
          MasterCurrencyRoute.name,
          initialChildren: children,
        );

  static const String name = 'MasterCurrencyRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MasterItemScreen]
class MasterItemRoute extends PageRouteInfo<void> {
  const MasterItemRoute({List<PageRouteInfo>? children})
      : super(
          MasterItemRoute.name,
          initialChildren: children,
        );

  static const String name = 'MasterItemRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MasterLocationScreen]
class MasterLocationRoute extends PageRouteInfo<void> {
  const MasterLocationRoute({List<PageRouteInfo>? children})
      : super(
          MasterLocationRoute.name,
          initialChildren: children,
        );

  static const String name = 'MasterLocationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MasterScreen]
class MasterRoute extends PageRouteInfo<void> {
  const MasterRoute({List<PageRouteInfo>? children})
      : super(
          MasterRoute.name,
          initialChildren: children,
        );

  static const String name = 'MasterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [McAddScreen]
class McAddRoute extends PageRouteInfo<McAddRouteArgs> {
  McAddRoute({
    Key? key,
    required dynamic Function(bool) onResult,
    List<PageRouteInfo>? children,
  }) : super(
          McAddRoute.name,
          args: McAddRouteArgs(
            key: key,
            onResult: onResult,
          ),
          initialChildren: children,
        );

  static const String name = 'McAddRoute';

  static const PageInfo<McAddRouteArgs> page = PageInfo<McAddRouteArgs>(name);
}

class McAddRouteArgs {
  const McAddRouteArgs({
    this.key,
    required this.onResult,
  });

  final Key? key;

  final dynamic Function(bool) onResult;

  @override
  String toString() {
    return 'McAddRouteArgs{key: $key, onResult: $onResult}';
  }
}

/// generated route for
/// [McDetailScreen]
class McDetailRoute extends PageRouteInfo<McDetailRouteArgs> {
  McDetailRoute({
    Key? key,
    required CurrencyModel currency,
    List<PageRouteInfo>? children,
  }) : super(
          McDetailRoute.name,
          args: McDetailRouteArgs(
            key: key,
            currency: currency,
          ),
          initialChildren: children,
        );

  static const String name = 'McDetailRoute';

  static const PageInfo<McDetailRouteArgs> page =
      PageInfo<McDetailRouteArgs>(name);
}

class McDetailRouteArgs {
  const McDetailRouteArgs({
    this.key,
    required this.currency,
  });

  final Key? key;

  final CurrencyModel currency;

  @override
  String toString() {
    return 'McDetailRouteArgs{key: $key, currency: $currency}';
  }
}

/// generated route for
/// [McEditScreen]
class McEditRoute extends PageRouteInfo<McEditRouteArgs> {
  McEditRoute({
    Key? key,
    required CurrencyModel currency,
    required dynamic Function(bool) onResult,
    List<PageRouteInfo>? children,
  }) : super(
          McEditRoute.name,
          args: McEditRouteArgs(
            key: key,
            currency: currency,
            onResult: onResult,
          ),
          initialChildren: children,
        );

  static const String name = 'McEditRoute';

  static const PageInfo<McEditRouteArgs> page = PageInfo<McEditRouteArgs>(name);
}

class McEditRouteArgs {
  const McEditRouteArgs({
    this.key,
    required this.currency,
    required this.onResult,
  });

  final Key? key;

  final CurrencyModel currency;

  final dynamic Function(bool) onResult;

  @override
  String toString() {
    return 'McEditRouteArgs{key: $key, currency: $currency, onResult: $onResult}';
  }
}
