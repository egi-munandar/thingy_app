import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:thingy_app/constants.dart';
import 'package:thingy_app/logic/cubit/auth_cubit.dart';
import 'package:thingy_app/models/user_model.dart';
import 'package:thingy_app/routes/app_router.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  UserModel? user;
  String gfUrl = '';
  @override
  void initState() {
    getUser();
    super.initState();
  }

  Future<void> getUser() async {
    UserModel usr = await Consts.fetchUser();
    final gravatar = Gravatar(usr.email);
    setState(() {
      gfUrl = gravatar.imageUrl();
      user = usr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          user != null
              ? DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        child: Image.network(gfUrl),
                      ),
                      ListTile(
                        onTap: () => context.pushRoute(const ProfileRoute()),
                        title: Text(user!.name),
                        subtitle: Text(user!.email),
                        trailing: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (ctx) =>
                                    BlocBuilder<AuthCubit, AuthState>(
                                      builder: (context, state) {
                                        return AlertDialog(
                                          title: const Text("Logout App?"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  BlocProvider.of<AuthCubit>(
                                                          context)
                                                      .logoutApp()
                                                      .then((value) => context
                                                          .router
                                                          .pushNamed('/home'))
                                                      .catchError((err) {
                                                    showDialog(
                                                      context: context,
                                                      builder:
                                                          (BuildContext ctx) =>
                                                              AlertDialog(
                                                        title:
                                                            const Text("Error"),
                                                        content: Text(err),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () =>
                                                                  Navigator.of(
                                                                          ctx)
                                                                      .pop(),
                                                              child: state
                                                                      is AuthLoading
                                                                  ? const CircularProgressIndicator()
                                                                  : const Text(
                                                                      "OK"))
                                                        ],
                                                      ),
                                                    );
                                                    return false;
                                                  });
                                                },
                                                child: const Text(
                                                  "YES",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                )),
                                            TextButton(
                                                onPressed: () => ctx.popRoute(),
                                                child: const Text(
                                                  "NO",
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                )),
                                          ],
                                        );
                                      },
                                    ));
                          },
                          icon: const Icon(Icons.logout),
                        ),
                      )
                    ],
                  ),
                )
              : const SizedBox(),
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
