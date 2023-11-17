import 'dart:convert';
import 'dart:io';

import 'package:thingy_app/constants.dart';
import 'package:thingy_app/models/currency_model.dart';
import 'package:thingy_app/models/user_model.dart';
import 'package:http/http.dart' as http;

class MasterRepo {
  final String baseUrl = Consts.baseUrl;

  //currencies
  Future<List<CurrencyModel>> getCurrencies() async {
    final UserModel user = await Consts.fetchUser();
    final res = await http.get(Uri.parse("$baseUrl/currency"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user.apiToken}',
    }).catchError((_) => throw ('Can\'t connect to server'));
    if (res.statusCode == 200) {
      List<CurrencyModel> data = [];
      for (var dt in jsonDecode(res.body)) {
        data.add(CurrencyModel.fromMap(dt));
      }
      return data;
    } else if (res.statusCode == 422) {
      final Map<String, dynamic> err = jsonDecode(res.body);
      String erStr = 'Server Error';
      if (err.containsKey('errors')) {
        erStr = Consts().parseErrInput(err['errors']);
      }
      throw erStr;
    } else {
      throw "Server Error! ${res.statusCode}";
    }
  }

  Future<CurrencyModel> viewCurrency(int currencyId) async {
    final UserModel user = await Consts.fetchUser();
    final res =
        await http.get(Uri.parse("$baseUrl/currency/$currencyId"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user.apiToken}',
    }).catchError((_) => throw ('Can\'t connect to server'));
    if (res.statusCode == 200) {
      return CurrencyModel.fromJson(res.body);
    } else if (res.statusCode == 422) {
      final Map<String, dynamic> err = jsonDecode(res.body);
      String erStr = 'Server Error';
      if (err.containsKey('errors')) {
        erStr = Consts().parseErrInput(err['errors']);
      }
      throw erStr;
    } else {
      throw "Server Error! ${res.statusCode}";
    }
  }
}
