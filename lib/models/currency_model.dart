// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CurrencyModel {
  final int id;
  final String symbol;
  final String name;
  final String symbolNative;
  final int decimalDigits;
  final int rounding;
  final String code;
  final String namePlural;
  final String createdAt;
  final String updatedAt;
  CurrencyModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.symbolNative,
    required this.decimalDigits,
    required this.rounding,
    required this.code,
    required this.namePlural,
    required this.createdAt,
    required this.updatedAt,
  });

  CurrencyModel copyWith({
    int? id,
    String? symbol,
    String? name,
    String? symbolNative,
    int? decimalDigits,
    int? rounding,
    String? code,
    String? namePlural,
    String? createdAt,
    String? updatedAt,
  }) {
    return CurrencyModel(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      symbolNative: symbolNative ?? this.symbolNative,
      decimalDigits: decimalDigits ?? this.decimalDigits,
      rounding: rounding ?? this.rounding,
      code: code ?? this.code,
      namePlural: namePlural ?? this.namePlural,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'symbol': symbol,
      'name': name,
      'symbolNative': symbolNative,
      'decimalDigits': decimalDigits,
      'rounding': rounding,
      'code': code,
      'namePlural': namePlural,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory CurrencyModel.fromMap(Map<String, dynamic> map) {
    return CurrencyModel(
      id: map['id'] as int,
      symbol: map['symbol'] as String,
      name: map['name'] as String,
      symbolNative: map['symbolNative'] as String,
      decimalDigits: map['decimalDigits'] as int,
      rounding: map['rounding'] as int,
      code: map['code'] as String,
      namePlural: map['namePlural'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrencyModel.fromJson(String source) =>
      CurrencyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CurrencyModel(id: $id, symbol: $symbol, name: $name, symbolNative: $symbolNative, decimalDigits: $decimalDigits, rounding: $rounding, code: $code, namePlural: $namePlural, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant CurrencyModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.symbol == symbol &&
        other.name == name &&
        other.symbolNative == symbolNative &&
        other.decimalDigits == decimalDigits &&
        other.rounding == rounding &&
        other.code == code &&
        other.namePlural == namePlural &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        symbol.hashCode ^
        name.hashCode ^
        symbolNative.hashCode ^
        decimalDigits.hashCode ^
        rounding.hashCode ^
        code.hashCode ^
        namePlural.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
