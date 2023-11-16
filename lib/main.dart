import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thingy_app/logic/cubit/auth_cubit.dart';
import 'package:thingy_app/routes/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS) {
    HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: await getTemporaryDirectory());
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(),
          ),
        ],
        child: ThingyApp(
          appRouter: _appRouter,
        ));
  }
}

class ThingyApp extends StatelessWidget {
  final AppRouter appRouter;
  const ThingyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter.config(),
      title: 'Thingy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 15, 76, 129)),
        useMaterial3: true,
      ),
    );
  }
}
