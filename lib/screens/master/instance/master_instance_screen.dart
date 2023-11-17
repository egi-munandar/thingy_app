import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:thingy_app/constants.dart';

@RoutePage()
class MasterInstanceScreen extends StatelessWidget {
  const MasterInstanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: mq.width > Consts.wdt.sm
          ? FloatingActionButtonLocation.endTop
          : FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add new instance',
        child: const Icon(Icons.add),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Instance",
              style: TextStyle(fontSize: Consts.fSize.h3),
            ),
            Text(
              "(HOME)",
              style: TextStyle(fontSize: Consts.fSize.h5),
            ),
          ]),
        )
      ]),
    );
  }
}
