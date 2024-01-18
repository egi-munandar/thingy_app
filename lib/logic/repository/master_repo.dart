import 'dart:convert';

import 'package:thingy_app/constants.dart';
import 'package:thingy_app/models/currency_model.dart';
import 'package:thingy_app/models/instance_model.dart';
import 'package:thingy_app/models/item_model.dart';
import 'package:thingy_app/models/user_model.dart';
import 'package:http/http.dart' as http;

class MasterRepo {
  final String baseUrl = Consts.baseUrl;

  //currencies
  Future<Map<String, dynamic>> getCurrencyPaged(String queryString) async {
    final UserModel user = await Consts.fetchUser();
    final res = await http
        .get(Uri.parse("$baseUrl/currency/paged$queryString"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user.apiToken}',
    }).catchError((_) => throw ("Can't Connect to Server"));
    if (res.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(res.body);
      return result;
    } else {
      throw "Server Error! ${res.statusCode}";
    }
  }

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

  Future<CurrencyModel> updateCurrency(
      Map<String, dynamic> data, num currencyId) async {
    final UserModel user = await Consts.fetchUser();
    final res = await http
        .put(Uri.parse("$baseUrl/currency/$currencyId"),
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer ${user.apiToken}',
            },
            body: data)
        .catchError((_) => throw ('Can\'t connect to server'));
    if (res.statusCode == 200) {
      Map<String, dynamic> map = json.decode(res.body);
      return CurrencyModel.fromMap(map);
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

  Future<CurrencyModel> storeCurrency(Map<String, dynamic> data) async {
    final UserModel user = await Consts.fetchUser();
    final res = await http
        .post(Uri.parse("$baseUrl/currency"),
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer ${user.apiToken}',
            },
            body: data)
        .catchError((_) => throw ('Can\'t connect to server'));
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

  Future<void> deleteCurrency(num currencyId) async {
    final UserModel user = await Consts.fetchUser();
    final res =
        await http.delete(Uri.parse("$baseUrl/currency/$currencyId"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user.apiToken}',
    }).catchError((_) => throw ('Can\'t connect to server'));
    if (res.statusCode == 200) {
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

  //instances
  Future<List<InstanceModel>> getInstances() async {
    final UserModel user = await Consts.fetchUser();
    final res = await http.get(Uri.parse("$baseUrl/instance"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user.apiToken}',
    }).catchError((_) => throw ('Can\'t connect to server'));
    if (res.statusCode == 200) {
      List<InstanceModel> data = [];
      for (var dt in jsonDecode(res.body)) {
        data.add(InstanceModel.fromMap(dt));
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

  Future<InstanceModel> updateInstance(
      Map<String, dynamic> data, num instanceId) async {
    final UserModel user = await Consts.fetchUser();
    final res = await http
        .put(Uri.parse("$baseUrl/instance/$instanceId"),
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer ${user.apiToken}',
            },
            body: data)
        .catchError((_) => throw ('Can\'t connect to server'));
    if (res.statusCode == 200) {
      Map<String, dynamic> map = json.decode(res.body);
      return InstanceModel.fromMap(map);
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

  Future<InstanceModel> storeInstance(Map<String, dynamic> data) async {
    final UserModel user = await Consts.fetchUser();
    final res = await http
        .post(Uri.parse("$baseUrl/instance"),
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer ${user.apiToken}',
            },
            body: data)
        .catchError((_) => throw ('Can\'t connect to server'));
    if (res.statusCode == 200) {
      return InstanceModel.fromJson(res.body);
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

  Future<InstanceModel> viewInstance(int instanceId) async {
    final UserModel user = await Consts.fetchUser();
    final res =
        await http.get(Uri.parse("$baseUrl/instance/$instanceId"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user.apiToken}',
    }).catchError((_) => throw ('Can\'t connect to server'));
    if (res.statusCode == 200) {
      return InstanceModel.fromJson(res.body);
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

  Future<void> deleteInstance(int instanceId) async {
    final UserModel user = await Consts.fetchUser();
    final res =
        await http.delete(Uri.parse("$baseUrl/instance/$instanceId"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user.apiToken}',
    }).catchError((_) => throw ('Can\'t connect to server'));
    if (res.statusCode == 200) {
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

  //items
  Future<List<ItemModel>> getItems() async {
    final UserModel user = await Consts.fetchUser();
    final res = await http.get(Uri.parse("$baseUrl/item"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user.apiToken}',
    }).catchError((_) => throw ('Can\'t connect to server'));
    if (res.statusCode == 200) {
      List<ItemModel> data = [];
      for (var dt in jsonDecode(res.body)) {
        data.add(ItemModel.fromMap(dt));
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

  Future<List<ItemModel>> getPagedItems(
      {String search = '', currPage = 1, pageSize = 10, orderBy}) async {
    final UserModel user = await Consts.fetchUser();
    final res = await http.get(Uri.parse("$baseUrl/item"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user.apiToken}',
    }).catchError((_) => throw ('Can\'t connect to server'));
    if (res.statusCode == 200) {
      List<ItemModel> data = [];
      for (var dt in jsonDecode(res.body)) {
        data.add(ItemModel.fromMap(dt));
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

  Future<ItemModel> updateItem(Map<String, dynamic> data, num itemId) async {
    final UserModel user = await Consts.fetchUser();
    final res = await http
        .put(Uri.parse("$baseUrl/item/$itemId"),
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer ${user.apiToken}',
            },
            body: data)
        .catchError((_) => throw ('Can\'t connect to server'));
    if (res.statusCode == 200) {
      Map<String, dynamic> map = json.decode(res.body);
      return ItemModel.fromMap(map);
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

  Future<ItemModel> storeItem(Map<String, dynamic> data) async {
    final UserModel user = await Consts.fetchUser();
    final res = await http
        .post(Uri.parse("$baseUrl/item"),
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer ${user.apiToken}',
            },
            body: data)
        .catchError((_) => throw ('Can\'t connect to server'));
    if (res.statusCode == 200) {
      return ItemModel.fromJson(res.body);
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

  Future<ItemModel> viewItem(int itemId) async {
    final UserModel user = await Consts.fetchUser();
    final res = await http.get(Uri.parse("$baseUrl/item/$itemId"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user.apiToken}',
    }).catchError((_) => throw ('Can\'t connect to server'));
    if (res.statusCode == 200) {
      return ItemModel.fromJson(res.body);
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

  Future<void> deleteItem(int itemId) async {
    final UserModel user = await Consts.fetchUser();
    final res = await http.delete(Uri.parse("$baseUrl/item/$itemId"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user.apiToken}',
    }).catchError((_) => throw ('Can\'t connect to server'));
    if (res.statusCode == 200) {
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