import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thingy_app/constants.dart';
import 'package:thingy_app/logic/cubit/currency_cubit.dart';
import 'package:thingy_app/routes/app_router.dart';
import 'package:thingy_app/screens/app_drawer.dart';
import 'package:thingy_app/screens/error_screen.dart';
import 'package:thingy_app/screens/loading_screen.dart';
import 'package:thingy_app/screens/master/currency/mc_loaded_wg.dart';

@RoutePage()
class MasterCurrencyScreen extends StatelessWidget {
  const MasterCurrencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
          title: Text(
        "Currencies",
        style: TextStyle(fontSize: Consts.fSize.h3),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.router.push(const McAddRoute()),
        tooltip: "Add Currency",
        child: const Icon(Icons.add_rounded),
      ),
      body: BlocProvider(
        create: (context) => CurrencyCubit(),
        child: Column(children: [
          Expanded(
            child: BlocBuilder<CurrencyCubit, CurrencyState>(
              builder: (context, state) {
                if (state is CurrencyInitial) {
                  BlocProvider.of<CurrencyCubit>(context).getCurrencies();
                  return const LoadingScreen();
                } else if (state is CurrencyLoading) {
                  return const LoadingScreen(msg: 'Loading Currencies...');
                } else if (state is CurrencyLoaded) {
                  return MCLoadedWg(curs: state.currencies);
                } else if (state is CurrencyError) {
                  return ErrorScreen(
                    msg: state.msg,
                  );
                } else {
                  return const ErrorScreen(
                    msg: 'Please refresh this page.',
                  );
                }
              },
            ),
          )
        ]),
      ),
    );
  }
}
