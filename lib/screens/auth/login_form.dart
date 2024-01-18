import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:thingy_app/constants.dart';
import 'package:thingy_app/logic/cubit/auth_cubit.dart';
import 'package:thingy_app/logic/repository/auth_repo.dart';
import 'package:thingy_app/models/user_model.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.onResult});

  @override
  State<LoginForm> createState() => _LoginFormState();
  final Function(bool didLogin) onResult;
}

class _LoginFormState extends State<LoginForm> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  bool showPassword = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              controller: _email,
              validator: (val) =>
                  val == null || val.isEmpty ? 'Please fill your email' : null,
              decoration: const InputDecoration(
                  labelText: "Email",
                  icon: Icon(Icons.email),
                  hintText: "Your Email..."),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextFormField(
              controller: _password,
              validator: (val) => val == null || val.isEmpty
                  ? 'Please type in your password...'
                  : null,
              decoration: InputDecoration(
                labelText: "Password",
                icon: const Icon(Icons.key),
                hintText: "Password...",
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(showPassword
                      ? Icons.visibility_rounded
                      : Icons.visibility_off),
                ),
              ),
              obscureText: showPassword ? false : true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      setState(() {
                        isLoading = true;
                      });
                      await AuthRepo().login({
                        'email': _email.text,
                        'password': _password.text,
                      }).then((UserModel user) {
                        _loginFormKey.currentState!.reset();
                        const str = FlutterSecureStorage();
                        str.write(key: 'user', value: user.toJson());
                        BlocProvider.of<AuthCubit>(context).emitAuthUser(user);
                        widget.onResult(true);
                      }).catchError((er) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text(
                              "Error!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            content: Text(
                              er.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  "OK",
                                  style: TextStyle(color: Colors.green),
                                ),
                              )
                            ],
                          ),
                        );
                      });
                      setState(() {
                        isLoading = false;
                      });
                    },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                textStyle: TextStyle(fontSize: Consts.fSize.h3),
              ),
              child: Text(isLoading ? "Logging In..." : "LOGIN"),
            ),
          ),
          TextButton(
              onPressed: () {
                context.router.pushNamed('/change-api-url');
              },
              child: const Text("Change API URL"))
        ],
      ),
    );
  }
}
