import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thingy_app/logic/cubit/instance_cubit.dart';
import 'package:thingy_app/routes/app_router.dart';
import 'package:thingy_app/screens/app_drawer.dart';
import 'package:thingy_app/screens/error_screen.dart';
import 'package:thingy_app/screens/loading_screen.dart';
import 'package:thingy_app/screens/master/instance/mi_loaded_wg.dart';

@RoutePage()
class MasterInstanceScreen extends StatelessWidget {
  const MasterInstanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InstanceCubit(),
      child: BlocBuilder<InstanceCubit, InstanceState>(
        builder: (context, state) {
          if (state is InstanceInitial) {
            BlocProvider.of<InstanceCubit>(context).getInstances();
          }
          return Scaffold(
              appBar: AppBar(title: const Text("Instance (HOME)")),
              drawer: const AppDrawer(),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  context.router.push((MiAddRoute(
                      instanceAdded: (e) => e
                          ? BlocProvider.of<InstanceCubit>(context)
                              .getInstances()
                          : null)));
                },
                tooltip: 'Add new instance',
                child: const Icon(Icons.add),
              ),
              body: (state is InstanceLoading)
                  ? const LoadingScreen(
                      msg: 'Loading Instances...',
                    )
                  : (state is InstanceLoaded)
                      ? MiLoadedWg(
                          instances: state.instances,
                        )
                      : (state is InstanceError)
                          ? Center(
                              child: ErrorScreen(
                                msg: state.msg,
                                refresh: () =>
                                    BlocProvider.of<InstanceCubit>(context)
                                        .getInstances(),
                              ),
                            )
                          : Container());
        },
      ),
    );
  }
}
