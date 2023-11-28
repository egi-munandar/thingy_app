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
    return BlocProvider(
      create: (context) => CurrencyCubit(),
      child: BlocBuilder<CurrencyCubit, CurrencyState>(
        builder: (context, state) {
          if (state is CurrencyInitial) {
            BlocProvider.of<CurrencyCubit>(context).getCurrencies();
          }
          return Scaffold(
            drawer: const AppDrawer(),
            appBar: AppBar(
                title: Text(
              "Currencies",
              style: TextStyle(fontSize: Consts.fSize.h3),
            )),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.router.push(McAddRoute(
                    created: (c) => c
                        ? BlocProvider.of<CurrencyCubit>(context)
                            .getCurrencies()
                        : null));
              },
              tooltip: "Add Currency",
              child: const Icon(Icons.add_rounded),
            ),
            body: Column(children: [
              Expanded(
                  child: (state is CurrencyLoading)
                      ? const LoadingScreen(msg: 'Loading Currencies...')
                      : (state is CurrencyLoaded)
                          ? MCLoadedWg(curs: state.currencies)
                          : (state is CurrencyError)
                              ? ErrorScreen(
                                  msg: state.msg,
                                  refresh: () =>
                                      BlocProvider.of<CurrencyCubit>(context)
                                          .getCurrencies(),
                                )
                              : const LoadingScreen(
                                  msg: "Loading...",
                                )),
            ]),
          );
        },
      ),
    );
  }
}
