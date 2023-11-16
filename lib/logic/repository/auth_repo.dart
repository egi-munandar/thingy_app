import 'dart:convert';
import 'dart:io';

import 'package:thingy_app/constants.dart';
import 'package:thingy_app/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  final String baseUrl = Consts.baseUrl;
  Future<UserModel> login(Map<String, dynamic> data) async {
    String tokenName =
        '${Platform.localHostname} - ${Platform.operatingSystem} ${Platform.operatingSystemVersion}';
    final res = await http.post(Uri.parse("$baseUrl/login"), body: {
      ...data,
      'tokenName': tokenName,
    }, headers: {
      'Accept': 'application/json',
    }).catchError((er) => throw "Connection Failed!");
    if (res.statusCode == 200) {
      final user = UserModel.fromJson(res.body);
      return user;
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

  Future<String> logout() async {
    final UserModel user = await Consts.fetchUser();
    print(user);
    final res = await http.post(Uri.parse("$baseUrl/logout-app"), headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer ${user.apiToken}"
    }).catchError((er) {
      throw "Can't connect to server";
    });
    print(res.body);
    if (res.statusCode == 200) {
      return "logged out";
    } else if (res.statusCode == 401) {
      throw "401";
    } else {
      throw "Server Error! ${res.statusCode}";
    }
  }
}
