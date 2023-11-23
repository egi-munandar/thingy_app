import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:thingy_app/constants.dart';
import 'package:thingy_app/logic/repository/master_repo.dart';
import 'package:toast/toast.dart';

@RoutePage()
class McAddScreen extends StatefulWidget {
  const McAddScreen({super.key});

  @override
  State<McAddScreen> createState() => _McAddScreenState();
}

class _McAddScreenState extends State<McAddScreen> {
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
  Widget build(BuildContext context) {
    ToastContext().init(context);
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Add Currency")),
      floatingActionButton: FloatingActionButton(
          onPressed: () => saveCurrency(context),
          child: const Icon(Icons.save_rounded)),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: mq.width > Consts.wdt.sm ? mq.width * 0.7 : mq.width * 0.99,
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
      ),
    );
  }

  Future<void> saveCurrency(BuildContext context) async {
    if (curFormKey.currentState!.validate()) {
      setState(() {
        saving = true;
      });
      MasterRepo().storeCurrency({
        'symbol': tSymbol.text,
        'name': tName.text,
        'symbol_native': tSymbolNative.text,
        'decimal_digits': tDecimalDigits.text,
        'rounding': tRounding.text,
        'code': tCode.text,
        'name_plural': tNamePlural.text,
      }).then((_) {
        Toast.show("New Currency Saved!", duration: 2, gravity: Toast.bottom);
        context.router.back();
      }).catchError((er) {
        Consts().errDialog(context, er);
      });
    }
  }
}
