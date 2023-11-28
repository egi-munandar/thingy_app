import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thingy_app/constants.dart';
import 'package:thingy_app/logic/cubit/currency_cubit.dart';
import 'package:thingy_app/logic/repository/master_repo.dart';
import 'package:thingy_app/models/currency_model.dart';
import 'package:thingy_app/screens/error_screen.dart';
import 'package:thingy_app/screens/loading_screen.dart';
import 'package:toast/toast.dart';

@RoutePage()
class MCEditScreen extends StatefulWidget {
  final int mcId;
  const MCEditScreen(
      {super.key, @PathParam('id') required this.mcId, required this.updated});
  @override
  State<MCEditScreen> createState() => _MCEditScreenState();
  final Function(bool upd) updated;
}

class _MCEditScreenState extends State<MCEditScreen> {
  final tSymbol = TextEditingController();
  final tName = TextEditingController();
  final tSymbolNative = TextEditingController();
  final tDecimalDigits = TextEditingController();
  final tRounding = TextEditingController();
  final tCode = TextEditingController();
  final tNamePlural = TextEditingController();
  final curFormKey = GlobalKey<FormState>();
  bool saving = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    Size mq = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => CurrencyCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Edit Currency")),
        floatingActionButton: FloatingActionButton(
          onPressed: () => updateCur(context),
          child: const Icon(Icons.save),
        ),
        body: BlocBuilder<CurrencyCubit, CurrencyState>(
          builder: (context, state) {
            if (saving) {
              return const LoadingScreen(
                msg: 'Saving...',
              );
            } else {
              if (state is CurrencyInitial) {
                BlocProvider.of<CurrencyCubit>(context)
                    .viewCurrency(widget.mcId);
                return const LoadingScreen();
              } else if (state is CurrencyLoading) {
                return const LoadingScreen(
                  msg: 'Getting currency...',
                );
              } else if (state is CurrencySingle) {
                final CurrencyModel c = state.currency;
                tName.text = c.name;
                tSymbolNative.text = c.symbolNative;
                tSymbol.text = c.symbol;
                tDecimalDigits.text = c.decimalDigits.toString();
                tRounding.text = c.rounding.toString();
                tCode.text = c.code;
                tNamePlural.text = c.namePlural;
                return SingleChildScrollView(
                  child: Center(
                    child: SizedBox(
                      width: mq.width > Consts.wdt.sm
                          ? mq.width * 0.7
                          : mq.width * 0.99,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Form(
                          key: curFormKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: tSymbol,
                                  decoration: const InputDecoration(
                                    label: Text("Symbol"),
                                  ),
                                  validator: (val) => val == null || val.isEmpty
                                      ? 'This field is required'
                                      : null,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: tName,
                                  decoration: const InputDecoration(
                                    label: Text("Name"),
                                  ),
                                  validator: (val) => val == null || val.isEmpty
                                      ? 'This field is required'
                                      : null,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: tSymbolNative,
                                  decoration: const InputDecoration(
                                    label: Text("Symbol Native"),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: tCode,
                                  decoration: const InputDecoration(
                                    label: Text("Code"),
                                  ),
                                  validator: (val) => val == null || val.isEmpty
                                      ? 'This field is required'
                                      : null,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: tDecimalDigits,
                                  decoration: const InputDecoration(
                                    label: Text("Decimal Digits"),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: tRounding,
                                  decoration: const InputDecoration(
                                    label: Text("Rounding"),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: tNamePlural,
                                  decoration: const InputDecoration(
                                    label: Text("Plural Name"),
                                  ),
                                  validator: (val) => val == null || val.isEmpty
                                      ? 'This field is required'
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else if (state is CurrencyError) {
                return ErrorScreen(msg: state.msg);
              } else {
                return const LoadingScreen();
              }
            }
          },
        ),
      ),
    );
  }

  void updateCur(BuildContext context) async {
    if (curFormKey.currentState!.validate()) {
      setState(() {
        saving = true;
      });
      await MasterRepo().updateCurrency({
        'symbol': tSymbol.text,
        'name': tName.text,
        'symbol_native': tSymbolNative.text,
        'decimal_digits': tDecimalDigits.text,
        'rounding': tRounding.text,
        'code': tCode.text,
        'name_plural': tNamePlural.text,
      }, widget.mcId).then((_) {
        widget.updated(true);
        Toast.show("Currency Updated!", duration: 2, gravity: Toast.bottom);
        context.router.back();
      }).catchError((er) {
        Consts().errDialog(context, er);
      });
      setState(() {
        saving = false;
      });
    }
  }
}
