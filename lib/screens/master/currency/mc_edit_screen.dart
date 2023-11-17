import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thingy_app/logic/cubit/currency_cubit.dart';
import 'package:thingy_app/screens/error_screen.dart';
import 'package:thingy_app/screens/loading_screen.dart';

@RoutePage()
class MCEditScreen extends StatefulWidget {
  final int mcId;
  const MCEditScreen({super.key, @PathParam('id') required this.mcId});

  @override
  State<MCEditScreen> createState() => _MCEditScreenState();
}

class _MCEditScreenState extends State<MCEditScreen> {
  @override
  void initState() {
    BlocProvider.of<CurrencyCubit>(context).viewCurrency(widget.mcId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyCubit, CurrencyState>(
      builder: (context, state) {
        if (state is CurrencyLoading) {
          return const LoadingScreen(
            msg: 'Getting currency...',
          );
        } else if (state is CurrencySingle) {
          return const Card();
        } else if (state is CurrencyError) {
          return ErrorScreen(msg: state.msg);
        } else {
          return const LoadingScreen();
        }
      },
    );
  }
}
