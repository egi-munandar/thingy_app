import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thingy_app/constants.dart';

@RoutePage()
class ChangeApiUrlScreen extends StatefulWidget {
  const ChangeApiUrlScreen({super.key});

  @override
  State<ChangeApiUrlScreen> createState() => _ChangeApiUrlState();
}

class _ChangeApiUrlState extends State<ChangeApiUrlScreen> {
  String currentUrl = '';
  @override
  void initState() {
    Consts.baseUrl().then((value) {
      setState(() {
        currentUrl = value;
      });
    });
    super.initState();
  }

  bool isLoading = false;
  final urlText = TextEditingController();
  Future<void> setApiUrl() async {
    setState(() {
      isLoading = true;
    });
    final inst = await SharedPreferences.getInstance();
    await inst.setString('apiUrl', urlText.text);
    await Consts.baseUrl().then((value) {
      setState(() {
        currentUrl = value;
        isLoading = false;
      });
    }).catchError((er) {
      setState(() {
        isLoading = false;
      });
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change API URL"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(children: [
                  Text("Current URL: $currentUrl"),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: urlText,
                      decoration: InputDecoration(
                        label: const Text("New URL"),
                        suffixIcon: IconButton(
                          onPressed: setApiUrl,
                          icon: const Icon(Icons.save),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
