// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:thingy_app/models/currency_model.dart';

class UserModel {
  final int id;
  final String email;
  final String name;
  final List<dynamic>? perms;
  final String apiToken;
  final CurrencyModel? currency;
  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.perms,
    required this.apiToken,
    this.currency,
  });

  UserModel copyWith({
    int? id,
    String? email,
    String? name,
    List<dynamic>? perms,
    String? apiToken,
    CurrencyModel? currency,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      perms: perms ?? this.perms,
      apiToken: apiToken ?? this.apiToken,
      currency: currency ?? this.currency,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
      'perms': perms,
      'apiToken': apiToken,
      'currency': currency?.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      email: map['email'] as String,
      name: map['name'] as String,
      perms: map['perms'] != null
          ? List<dynamic>.from((map['perms'] as List<dynamic>))
          : null,
      apiToken: map['apiToken'] as String,
      currency: map['currency'] != null
          ? CurrencyModel.fromMap(map['currency'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, name: $name, perms: $perms, apiToken: $apiToken, currency: $currency)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.name == name &&
        listEquals(other.perms, perms) &&
        other.apiToken == apiToken &&
        other.currency == currency;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        name.hashCode ^
        perms.hashCode ^
        apiToken.hashCode ^
        currency.hashCode;
  }
}
