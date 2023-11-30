import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thingy_app/logic/cubit/item_cubit.dart';
import 'package:thingy_app/screens/app_drawer.dart';
import 'package:thingy_app/screens/error_screen.dart';
import 'package:thingy_app/screens/loading_screen.dart';
import 'package:thingy_app/screens/master/item/mit_loaded_wg.dart';

@RoutePage()
class MasterItemScreen extends StatelessWidget {
  const MasterItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemCubit(),
      child: BlocBuilder<ItemCubit, ItemState>(
        builder: (context, state) {
          if (state is ItemInitial) {
            BlocProvider.of<ItemCubit>(context).getItems();
          }
          return Scaffold(
              appBar: AppBar(title: const Text("Items")),
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                tooltip: "Add New Item",
                child: const Icon(Icons.add),
              ),
              drawer: const AppDrawer(),
              body: Center(
                child: (state is ItemLoading)
                    ? const LoadingScreen(
                        msg: "Loading Items...",
                      )
                    : (state is ItemError)
                        ? ErrorScreen(
                            msg: state.msg,
                            refresh: () =>
                                BlocProvider.of<ItemCubit>(context).getItems())
                        : (state is ItemLoaded)
                            ? MitLoadedWidget(items: state.items)
                            : const SizedBox(),
              ));
        },
      ),
    );
  }
}
