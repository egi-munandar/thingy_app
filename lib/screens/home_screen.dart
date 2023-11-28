import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thingy_app/logic/cubit/auth_cubit.dart';
import 'package:thingy_app/screens/app_drawer.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Th"),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context)
                      .logoutApp()
                      .then((value) => context.router.pushNamed('/home'))
                      .catchError((err) {
                    showDialog(
                      context: context,
                      builder: (BuildContext ctx) => AlertDialog(
                        title: const Text("Error"),
                        content: Text(err),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.of(ctx).pop(),
                              child: const Text("OK"))
                        ],
                      ),
                    );
                    return false;
                  });
                },
                child: const Text("Logout")),
          ),
        ],
      ),
    );
  }
}
