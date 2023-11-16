import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:thingy_app/models/user_model.dart';
import 'package:intl/intl.dart';

class Consts {
  static const baseUrl =
      String.fromEnvironment('API_URL', defaultValue: 'http://localhost/api');
  static const ConstWidth wdt = ConstWidth();
  static const ConstFontSize fSize = ConstFontSize();
  String parseErrInput(Map<String, dynamic> err) {
    String st = '';
    err.forEach((k, v) {
      st += "\n$k: $v";
    });
    return st;
  }

  static Future<UserModel> fetchUser() async {
    const storage = FlutterSecureStorage();
    late UserModel user;
    final usr = await storage.read(key: 'user');
    if (usr != null) {
      user = UserModel.fromJson(usr);
      return user;
    } else {
      throw "User data not found";
    }
  }

  String dateFormat(text) {
    DateTime dt = DateTime.parse(text);
    String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(dt);
    return formattedDate.toString();
  }
}

class ConstWidth {
  const ConstWidth();
  final num xs = 300;
  final num sm = 576;
  final num md = 768;
  final num lg = 992;
  final num xl = 1200;
}

class ConstFontSize {
  const ConstFontSize();
  final double h1 = 40;
  final double h2 = 32;
  final double h3 = 28;
  final double h4 = 24;
  final double h5 = 20;
  final double h6 = 16;
}
