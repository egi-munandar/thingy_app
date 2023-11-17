import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:thingy_app/constants.dart';

class LoadingScreen extends StatelessWidget {
  final String msg;
  const LoadingScreen({super.key, this.msg = "Loading..."});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitThreeInOut(
          color: Theme.of(context).primaryColor,
          size: MediaQuery.of(context).size.shortestSide / 9,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          msg,
          style:
              TextStyle(fontSize: Consts.fSize.h6, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
