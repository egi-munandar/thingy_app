import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:thingy_app/constants.dart';
import 'package:thingy_app/screens/auth/login_form.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onResult});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
  final Function(bool didLogin) onResult;
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: mq.width > Consts.wdt.md ? 3 : 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "LOGIN",
                  style: TextStyle(
                      fontSize: Consts.fSize.h1, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: LoginForm(
                    onResult: (didLogin) => widget.onResult(didLogin),
                  ),
                ),
              ],
            ),
          ),
          mq.width > Consts.wdt.md
              ? Expanded(
                  flex: 7,
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    child: Center(
                        child: Text(
                      "LOGIN HERE",
                      style: TextStyle(
                          fontSize: Consts.fSize.h2,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
