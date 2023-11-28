import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:thingy_app/constants.dart';
import 'package:thingy_app/logic/cubit/currency_cubit.dart';
import 'package:thingy_app/logic/cubit/instance_cubit.dart';
import 'package:thingy_app/logic/repository/master_repo.dart';
import 'package:thingy_app/models/currency_model.dart';
import 'package:thingy_app/models/instance_model.dart';
import 'package:thingy_app/screens/error_screen.dart';
import 'package:thingy_app/screens/loading_screen.dart';
import 'package:toast/toast.dart';

@RoutePage()
class MiEditScreen extends StatefulWidget {
  final int miId;
  const MiEditScreen(
      {super.key, required this.updated, @PathParam('id') required this.miId});
  final Function(bool u) updated;

  @override
  State<MiEditScreen> createState() => _MiEditScreenState();
}

class _MiEditScreenState extends State<MiEditScreen> {
  final instFormKey = GlobalKey<FormState>();
  final tName = TextEditingController();
  final tCurrencyCode = TextEditingController();
  final tCurrencySymbol = TextEditingController();
  CurrencyModel? selectedCurrency;
  bool saving = false;
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    final Size mq = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => InstanceCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Edit Instance")),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            setState(() {
              saving = true;
            });
            if (instFormKey.currentState!.validate()) {
              await MasterRepo().updateInstance({
                'name': tName.text,
                'currency_code': tCurrencyCode.text,
                'currency': selectedCurrency!.name,
                'currency_symbol': tCurrencySymbol.text
              }, widget.miId).then((value) {
                Toast.show("Instance Saved!", duration: 3);
                widget.updated(true);
                context.router.back();
              }).catchError((er) {
                Consts().errDialog(context, er);
              });
            }
            setState(() {
              saving = false;
            });
          },
          tooltip: "Save",
          child: saving
              ? const SpinKitCircle(color: Colors.grey)
              : const Icon(Icons.save),
        ),
        body: BlocBuilder<InstanceCubit, InstanceState>(
          builder: (context, state) {
            if (state is InstanceInitial) {
              BlocProvider.of<InstanceCubit>(context).viewInstance(widget.miId);
              return Container();
            } else if (state is InstanceLoading) {
              return const LoadingScreen(msg: 'Loading...');
            } else if (state is InstanceError) {
              return ErrorScreen(
                refresh: () =>
                    BlocProvider.of<InstanceCubit>(context).getInstances(),
                msg: state.msg,
              );
            } else if (state is InstanceSingle) {
              final InstanceModel ins = state.instance;
              if (tName.text.isEmpty) {
                tName.text = ins.name;
              }
              if (tCurrencyCode.text.isEmpty) {
                tCurrencyCode.text = ins.currencyCode;
              }
              if (tCurrencySymbol.text.isEmpty) {
                tCurrencySymbol.text = ins.currencySymbol;
              }
              return BlocProvider(
                create: (context) => CurrencyCubit(),
                child: SingleChildScrollView(
                  child: Center(
                    child: SizedBox(
                      width: mq.width > Consts.wdt.sm
                          ? mq.width * 0.7
                          : mq.width * 0.99,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Form(
                          key: instFormKey,
                          child: Column(children: [
                            TextFormField(
                              controller: tName,
                              decoration: const InputDecoration(
                                label: Text("Instance Name"),
                              ),
                              validator: (val) => val == null || val.isEmpty
                                  ? 'This field is required'
                                  : null,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<CurrencyCubit, CurrencyState>(
                              builder: (context, state) {
                                if (state is CurrencyInitial) {
                                  BlocProvider.of<CurrencyCubit>(context)
                                      .getCurrencies();
                                  return SpinKitCircle(
                                    color: Theme.of(context).primaryColor,
                                  );
                                } else if (state is CurrencyLoaded) {
                                  final curs = state.currencies;
                                  final CurrencyModel sel = curs.firstWhere(
                                      (e) => e.code == ins.currencyCode);
                                  selectedCurrency ??= sel;
                                  return Column(
                                    children: [
                                      DropdownButtonFormField(
                                        value: selectedCurrency,
                                        validator: (val) =>
                                            selectedCurrency == null
                                                ? 'Please select currency'
                                                : null,
                                        decoration: const InputDecoration(
                                            label: Text("Currency")),
                                        items: state.currencies
                                            .map((e) => DropdownMenuItem(
                                                  value: e,
                                                  child: Text(e.name),
                                                ))
                                            .toList(),
                                        onChanged: (CurrencyModel? e) {
                                          if (e != null) {
                                            setState(() {
                                              selectedCurrency = e;
                                              tCurrencyCode.text = e.code;
                                              tCurrencySymbol.text =
                                                  e.symbolNative;
                                            });
                                          }
                                        },
                                      ),
                                      TextFormField(
                                        readOnly: true,
                                        controller: tCurrencyCode,
                                        decoration: const InputDecoration(
                                            label: Text("Currency Code")),
                                        validator: (val) =>
                                            val == null || val.isEmpty
                                                ? 'This field is required'
                                                : null,
                                      ),
                                      TextFormField(
                                        readOnly: true,
                                        controller: tCurrencySymbol,
                                        decoration: const InputDecoration(
                                            label: Text("Currency Symbol")),
                                        validator: (val) =>
                                            val == null || val.isEmpty
                                                ? 'This field is required'
                                                : null,
                                      ),
                                    ],
                                  );
                                } else if (state is CurrencyError) {
                                  return Text(
                                    state.msg,
                                    style: const TextStyle(color: Colors.red),
                                  );
                                } else {
                                  return SpinKitCircle(
                                    color: Theme.of(context).primaryColor,
                                  );
                                }
                              },
                            )
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
