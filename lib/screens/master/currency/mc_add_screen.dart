import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thingy_app/constants.dart';
import 'package:thingy_app/logic/repository/master_repo.dart';

@RoutePage()
class McAddScreen extends StatefulWidget {
  final Function(bool didSave) onResult;
  const McAddScreen({super.key, required this.onResult});
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
  final cFormKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Currency")),
      floatingActionButton: FloatingActionButton(
        onPressed: isLoading
            ? null
            : () async {
                setState(() {
                  isLoading = true;
                });
                await saveCurrency(context);
                setState(() {
                  isLoading = false;
                });
              },
        child: isLoading
            ? const Icon(Icons.hourglass_top)
            : const Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: cFormKey,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  validator: (val) => val == null || val.isEmpty
                      ? 'This field is required'
                      : null,
                  controller: tName,
                  decoration: const InputDecoration(
                    label: Text("Name*"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  validator: (val) => val == null || val.isEmpty
                      ? 'This field is required'
                      : null,
                  controller: tNamePlural,
                  decoration: const InputDecoration(
                    label: Text("Plural Name*"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  validator: (val) => val == null || val.isEmpty
                      ? 'This field is required'
                      : null,
                  controller: tSymbol,
                  decoration: const InputDecoration(
                    label: Text("Symbol*"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  validator: (val) => val == null || val.isEmpty
                      ? 'This field is required'
                      : null,
                  controller: tSymbolNative,
                  decoration: const InputDecoration(
                    label: Text("Native Symbol*"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  validator: (val) => val == null || val.isEmpty
                      ? 'This field is required'
                      : null,
                  controller: tCode,
                  decoration: const InputDecoration(
                    label: Text("Code*"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: tDecimalDigits,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text("Decimal Digits"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: tRounding,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text("Rounding"),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> saveCurrency(BuildContext context) async {
    if (cFormKey.currentState!.validate()) {
      MasterRepo().storeCurrency({
        'symbol': tSymbol.text,
        'name': tName.text,
        'symbol_native': tSymbolNative.text,
        'code': tCode.text,
        'name_plural': tNamePlural.text,
        'decimal_digits': tDecimalDigits.text,
        'rounding': tRounding.text,
      }).then((val) {
        Fluttertoast.showToast(msg: 'Currency Saved');
        widget.onResult(true);
        context.popRoute();
      }).catchError((er) {
        Consts().errDialog(context, er);
      });
    }
  }
}
