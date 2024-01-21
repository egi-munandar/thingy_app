import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:thingy_app/constants.dart';
import 'package:thingy_app/logic/repository/master_repo.dart';
import 'package:thingy_app/models/currency_model.dart';
import 'package:thingy_app/models/user_model.dart';
import 'package:thingy_app/routes/app_router.dart';
import 'package:thingy_app/screens/app_drawer.dart';
import 'package:thingy_app/screens/loading_screen.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserModel user;
  bool loaded = false;
  String gfUrl = '';
  @override
  void initState() {
    getUser();
    super.initState();
  }

  Future<void> getUser() async {
    UserModel usr = await Consts.fetchUser();
    final gravatar = Gravatar(usr.email);
    tName.text = usr.name;
    tEmail.text = usr.email;
    setState(() {
      gfUrl = gravatar.imageUrl();
      user = usr;
      print(usr.currency);
      if (usr.currency != null) {
        setState(() {
          selectedCurrency = usr.currency;
        });
      }
      loaded = true;
    });
  }

  final pFormKey = GlobalKey<FormState>();
  final passFormKey = GlobalKey<FormState>();

  final tName = TextEditingController();
  final tEmail = TextEditingController();

  final tOldPass = TextEditingController();
  final tNewPass = TextEditingController();
  final tConfirmPass = TextEditingController();

  CurrencyModel? selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
      ),
      drawer: const AppDrawer(),
      body: loaded
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: pFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(children: [
                            Image.network(
                              gfUrl,
                              alignment: Alignment.center,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                controller: tName,
                                decoration: const InputDecoration(
                                  label: Text("Name"),
                                  icon: Icon(Icons.person),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                controller: tEmail,
                                decoration: const InputDecoration(
                                  label: Text("Email"),
                                  icon: Icon(Icons.email),
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8),
                                child: ListTile(
                                  leading: const Icon(Icons.currency_exchange),
                                  title: const Text("Currency"),
                                  subtitle: Text(selectedCurrency?.name ?? "-"),
                                  trailing: IconButton(
                                    onPressed: () {
                                      context.pushRoute(
                                        SelectCurrencyRoute(onSelect: (curr) {
                                          if (curr != null) {
                                            setState(() {
                                              selectedCurrency = curr;
                                            });
                                          }
                                        }),
                                      );
                                    },
                                    icon: const Icon(Icons.menu_open),
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    foregroundColor:
                                        Theme.of(context).canvasColor),
                                onPressed: () => updateProfile(context),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.save),
                                    Text(" SAVE PROFILE")
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: passFormKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: tOldPass,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.password),
                                      label: Text("Old Password"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: tNewPass,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.password),
                                      label: Text("New Password"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: tConfirmPass,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.password),
                                      label: Text("Confirm Password"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        foregroundColor:
                                            Theme.of(context).canvasColor),
                                    onPressed: () {},
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.key),
                                        Text(" CHANGE PASSWORD")
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : const LoadingScreen(),
    );
  }

  Future<void> updateProfile(BuildContext context) async {
    if (pFormKey.currentState!.validate()) {
      setState(() {
        loaded = false;
      });
      await MasterRepo().updateUser({
        'name': tName.text,
        'email': tEmail.text,
        'currency_id': selectedCurrency?.id.toString()
      }, user.id).then((usr) {
        setState(() {
          user = usr;
          selectedCurrency = usr.currency;
        });
      }).catchError((er) {
        Consts().errDialog(context, er);
      });
      setState(() {
        loaded = true;
      });
    }
  }
}
