import 'package:flutter/material.dart';
import 'package:thingy_app/constants.dart';

class ErrorScreen extends StatelessWidget {
  final String msg;
  final Function() refresh;
  const ErrorScreen({super.key, this.msg = 'Error', required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.warning_rounded,
          color: Colors.red[900],
          size: MediaQuery.of(context).size.shortestSide / 5,
        ),
        Text(
          "ERROR!",
          style:
              TextStyle(fontSize: Consts.fSize.h2, fontWeight: FontWeight.bold),
        ),
        Text(
          msg,
          style: TextStyle(fontSize: Consts.fSize.h6),
        ),
        IconButton(onPressed: refresh, icon: const Icon(Icons.refresh))
      ],
    );
  }
}
