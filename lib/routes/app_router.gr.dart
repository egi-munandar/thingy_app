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
    MCEditRoute.name: (routeData) {
      final args = routeData.argsAs<MCEditRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MCEditScreen(
          key: args.key,
          mcId: args.mcId,
          updated: args.updated,
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
    McAddRoute.name: (routeData) {
      final args = routeData.argsAs<McAddRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: McAddScreen(
          key: args.key,
          created: args.created,
        ),
      );
    },
    MiAddRoute.name: (routeData) {
      final args = routeData.argsAs<MiAddRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MiAddScreen(
          key: args.key,
          instanceAdded: args.instanceAdded,
        ),
      );
    },
    MiEditRoute.name: (routeData) {
      final args = routeData.argsAs<MiEditRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MiEditScreen(
          key: args.key,
          updated: args.updated,
          miId: args.miId,
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
/// [MCEditScreen]
class MCEditRoute extends PageRouteInfo<MCEditRouteArgs> {
  MCEditRoute({
    Key? key,
    required int mcId,
    required dynamic Function(bool) updated,
    List<PageRouteInfo>? children,
  }) : super(
          MCEditRoute.name,
          args: MCEditRouteArgs(
            key: key,
            mcId: mcId,
            updated: updated,
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
    required this.updated,
  });

  final Key? key;

  final int mcId;

  final dynamic Function(bool) updated;

  @override
  String toString() {
    return 'MCEditRouteArgs{key: $key, mcId: $mcId, updated: $updated}';
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

/// generated route for
/// [McAddScreen]
class McAddRoute extends PageRouteInfo<McAddRouteArgs> {
  McAddRoute({
    Key? key,
    required dynamic Function(bool) created,
    List<PageRouteInfo>? children,
  }) : super(
          McAddRoute.name,
          args: McAddRouteArgs(
            key: key,
            created: created,
          ),
          initialChildren: children,
        );

  static const String name = 'McAddRoute';

  static const PageInfo<McAddRouteArgs> page = PageInfo<McAddRouteArgs>(name);
}

class McAddRouteArgs {
  const McAddRouteArgs({
    this.key,
    required this.created,
  });

  final Key? key;

  final dynamic Function(bool) created;

  @override
  String toString() {
    return 'McAddRouteArgs{key: $key, created: $created}';
  }
}

/// generated route for
/// [MiAddScreen]
class MiAddRoute extends PageRouteInfo<MiAddRouteArgs> {
  MiAddRoute({
    Key? key,
    required dynamic Function(bool) instanceAdded,
    List<PageRouteInfo>? children,
  }) : super(
          MiAddRoute.name,
          args: MiAddRouteArgs(
            key: key,
            instanceAdded: instanceAdded,
          ),
          initialChildren: children,
        );

  static const String name = 'MiAddRoute';

  static const PageInfo<MiAddRouteArgs> page = PageInfo<MiAddRouteArgs>(name);
}

class MiAddRouteArgs {
  const MiAddRouteArgs({
    this.key,
    required this.instanceAdded,
  });

  final Key? key;

  final dynamic Function(bool) instanceAdded;

  @override
  String toString() {
    return 'MiAddRouteArgs{key: $key, instanceAdded: $instanceAdded}';
  }
}

/// generated route for
/// [MiEditScreen]
class MiEditRoute extends PageRouteInfo<MiEditRouteArgs> {
  MiEditRoute({
    Key? key,
    required dynamic Function(bool) updated,
    required int miId,
    List<PageRouteInfo>? children,
  }) : super(
          MiEditRoute.name,
          args: MiEditRouteArgs(
            key: key,
            updated: updated,
            miId: miId,
          ),
          rawPathParams: {'id': miId},
          initialChildren: children,
        );

  static const String name = 'MiEditRoute';

  static const PageInfo<MiEditRouteArgs> page = PageInfo<MiEditRouteArgs>(name);
}

class MiEditRouteArgs {
  const MiEditRouteArgs({
    this.key,
    required this.updated,
    required this.miId,
  });

  final Key? key;

  final dynamic Function(bool) updated;

  final int miId;

  @override
  String toString() {
    return 'MiEditRouteArgs{key: $key, updated: $updated, miId: $miId}';
  }
}
