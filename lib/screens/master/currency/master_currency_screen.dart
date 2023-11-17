import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thingy_app/constants.dart';
import 'package:thingy_app/logic/cubit/currency_cubit.dart';
import 'package:thingy_app/screens/error_screen.dart';
import 'package:thingy_app/screens/loading_screen.dart';
import 'package:thingy_app/screens/master/currency/mc_loaded_wg.dart';

@RoutePage()
class MasterCurrencyScreen extends StatelessWidget {
  const MasterCurrencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => CurrencyCubit(),
      child: Expanded(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Currencies",
                style: TextStyle(fontSize: Consts.fSize.h3),
              ),
            ]),
          ),
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
