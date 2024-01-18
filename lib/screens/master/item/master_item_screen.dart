import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:thingy_app/screens/app_drawer.dart';

@RoutePage()
class MasterItemScreen extends StatelessWidget {
  const MasterItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ITEMS")),
      drawer: const AppDrawer(),
    );
  }
}
