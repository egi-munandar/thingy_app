import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:thingy_app/models/currency_model.dart';

@RoutePage()
class McDetailScreen extends StatelessWidget {
  final CurrencyModel currency;
  const McDetailScreen({super.key, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(currency.name)),
      body: SingleChildScrollView(
          child: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(children: [
              ListTile(
                title: const Text("Name"),
                subtitle: Text(currency.name),
              ),
              ListTile(
                title: const Text("Plural Name"),
                subtitle: Text(currency.name),
              ),
              ListTile(
                title: const Text("Symbol"),
                subtitle: Text(currency.symbol),
              ),
              ListTile(
                title: const Text("Native Symbol"),
                subtitle: Text(currency.symbolNative),
              ),
              ListTile(
                title: const Text("Code"),
                subtitle: Text(currency.code),
              ),
              ListTile(
                title: const Text("Decimal Digits"),
                subtitle: Text(currency.decimalDigits.toString()),
              ),
              ListTile(
                title: const Text("Rounding"),
                subtitle: Text(currency.rounding.toString()),
              ),
            ]),
          )),
        ),
      )),
    );
  }
}
