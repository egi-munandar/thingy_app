import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:thingy_app/constants.dart';
import 'package:thingy_app/logic/cubit/currency_cubit.dart';
import 'package:thingy_app/logic/repository/master_repo.dart';
import 'package:thingy_app/models/currency_model.dart';
import 'package:thingy_app/routes/app_router.dart';
import 'package:toast/toast.dart';

@RoutePage()
class MiAddScreen extends StatefulWidget {
  const MiAddScreen({super.key, required this.instanceAdded});
  final Function(bool addSuccess) instanceAdded;

  @override
  State<MiAddScreen> createState() => _MiAddScreenState();
}

class _MiAddScreenState extends State<MiAddScreen> {
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
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Instance")),
      floatingActionButton: FloatingActionButton(
        onPressed: saving
            ? null
            : () async {
                setState(() {
                  saving = true;
                });
                if (instFormKey.currentState!.validate()) {
                  await MasterRepo().storeInstance({
                    'name': tName.text,
                    'currency_code': selectedCurrency!.code,
                    'currency': selectedCurrency!.name,
                    'currency_symbol': selectedCurrency!.symbolNative
                  }).then((_) {
                    Toast.show('Instance Added!');
                    widget.instanceAdded(true);
                    context.router.back();
                  }).catchError((msg) {
                    Consts().errDialog(context, msg);
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
      body: BlocProvider(
        create: (context) => CurrencyCubit(),
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width:
                  mq.width > Consts.wdt.sm ? mq.width * 0.7 : mq.width * 0.99,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Form(
                  key: instFormKey,
                  child: Column(
                    children: [
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
                            return Column(
                              children: [
                                DropdownButtonFormField(
                                  validator: (val) => selectedCurrency == null
                                      ? 'Please select currency'
                                      : null,
                                  decoration: InputDecoration(
                                      label: const Text("Currency"),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          context.router.push(McAddRoute(
                                              created: (cr) => cr
                                                  ? BlocProvider.of<
                                                              CurrencyCubit>(
                                                          context)
                                                      .getCurrencies()
                                                  : null));
                                        },
                                        icon: const Icon(Icons.add),
                                        tooltip: "Add Currency",
                                      )),
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
                                        tCurrencySymbol.text = e.symbolNative;
                                      });
                                    }
                                  },
                                ),
                                TextFormField(
                                  readOnly: true,
                                  controller: tCurrencyCode,
                                  decoration: const InputDecoration(
                                      label: Text("Currency Code")),
                                  validator: (val) => val == null || val.isEmpty
                                      ? 'This field is required'
                                      : null,
                                ),
                                TextFormField(
                                  readOnly: true,
                                  controller: tCurrencySymbol,
                                  decoration: const InputDecoration(
                                      label: Text("Currency Symbol")),
                                  validator: (val) => val == null || val.isEmpty
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
