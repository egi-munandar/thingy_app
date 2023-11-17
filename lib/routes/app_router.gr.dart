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
    MCEditRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MCEditRouteArgs>(
          orElse: () => MCEditRouteArgs(mcId: pathParams.getInt('id')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MCEditScreen(
          key: args.key,
          mcId: args.mcId,
        ),
      );
    },
    MasterCurrencyRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MasterCurrencyScreen(),
      );
    },
    MasterInstanceRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MasterInstanceScreen(),
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
  };
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
/// [MCEditScreen]
class MCEditRoute extends PageRouteInfo<MCEditRouteArgs> {
  MCEditRoute({
    Key? key,
    required int mcId,
    List<PageRouteInfo>? children,
  }) : super(
          MCEditRoute.name,
          args: MCEditRouteArgs(
            key: key,
            mcId: mcId,
          ),
          rawPathParams: {'id': mcId},
          initialChildren: children,
        );

  static const String name = 'MCEditRoute';

  static const PageInfo<MCEditRouteArgs> page = PageInfo<MCEditRouteArgs>(name);
}

class MCEditRouteArgs {
  const MCEditRouteArgs({
    this.key,
    required this.mcId,
  });

  final Key? key;

  final int mcId;

  @override
  String toString() {
    return 'MCEditRouteArgs{key: $key, mcId: $mcId}';
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
/// [MasterInstanceScreen]
class MasterInstanceRoute extends PageRouteInfo<void> {
  const MasterInstanceRoute({List<PageRouteInfo>? children})
      : super(
          MasterInstanceRoute.name,
          initialChildren: children,
        );

  static const String name = 'MasterInstanceRoute';

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
