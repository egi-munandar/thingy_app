// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class InstanceModel {
  final int id;
  final String name;
  final String currencCode;
  final String currency;
  final String currencySymbol;
  final String createdAt;
  final String updatedAt;
  InstanceModel({
    required this.id,
    required this.name,
    required this.currencCode,
    required this.currency,
    required this.currencySymbol,
    required this.createdAt,
    required this.updatedAt,
  });

  InstanceModel copyWith({
    int? id,
    String? name,
    String? currencCode,
    String? currency,
    String? currencySymbol,
    String? createdAt,
    String? updatedAt,
  }) {
    return InstanceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      currencCode: currencCode ?? this.currencCode,
      currency: currency ?? this.currency,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'currencCode': currencCode,
      'currency': currency,
      'currencySymbol': currencySymbol,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory InstanceModel.fromMap(Map<String, dynamic> map) {
    return InstanceModel(
      id: map['id'] as int,
      name: map['name'] as String,
      currencCode: map['currencCode'] as String,
      currency: map['currency'] as String,
      currencySymbol: map['currencySymbol'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory InstanceModel.fromJson(String source) =>
      InstanceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InstanceModel(id: $id, name: $name, currencCode: $currencCode, currency: $currency, currencySymbol: $currencySymbol, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant InstanceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.currencCode == currencCode &&
        other.currency == currency &&
        other.currencySymbol == currencySymbol &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        currencCode.hashCode ^
        currency.hashCode ^
        currencySymbol.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
