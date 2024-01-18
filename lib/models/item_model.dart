// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ItemModel {
  final int id;
  final String assetId;
  final bool archived;
  final String name;
  final num qty;
  final String description;
  final num purchasePrice;
  final String purchaseFrom;
  final DateTime? purchaseTime;
  final String manufacturer;
  final String serialNumber;
  final bool lifetimeWarranty;
  final DateTime? warrantyExpires;
  final String warrantyDetails;
  final String soldTo;
  final num soldPrice;
  final DateTime? soldTime;
  final String soldNotes;
  final String bom;
  final DateTime createdAt;
  final DateTime updatedAt;
  ItemModel({
    required this.id,
    required this.assetId,
    required this.archived,
    required this.name,
    required this.qty,
    required this.description,
    required this.purchasePrice,
    required this.purchaseFrom,
    this.purchaseTime,
    required this.manufacturer,
    required this.serialNumber,
    required this.lifetimeWarranty,
    this.warrantyExpires,
    required this.warrantyDetails,
    required this.soldTo,
    required this.soldPrice,
    this.soldTime,
    required this.soldNotes,
    required this.bom,
    required this.createdAt,
    required this.updatedAt,
  });

  ItemModel copyWith({
    int? id,
    String? assetId,
    bool? archived,
    String? name,
    num? qty,
    String? description,
    num? purchasePrice,
    String? purchaseFrom,
    DateTime? purchaseTime,
    String? manufacturer,
    String? serialNumber,
    bool? lifetimeWarranty,
    DateTime? warrantyExpires,
    String? warrantyDetails,
    String? soldTo,
    num? soldPrice,
    DateTime? soldTime,
    String? soldNotes,
    String? bom,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ItemModel(
      id: id ?? this.id,
      assetId: assetId ?? this.assetId,
      archived: archived ?? this.archived,
      name: name ?? this.name,
      qty: qty ?? this.qty,
      description: description ?? this.description,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      purchaseFrom: purchaseFrom ?? this.purchaseFrom,
      purchaseTime: purchaseTime ?? this.purchaseTime,
      manufacturer: manufacturer ?? this.manufacturer,
      serialNumber: serialNumber ?? this.serialNumber,
      lifetimeWarranty: lifetimeWarranty ?? this.lifetimeWarranty,
      warrantyExpires: warrantyExpires ?? this.warrantyExpires,
      warrantyDetails: warrantyDetails ?? this.warrantyDetails,
      soldTo: soldTo ?? this.soldTo,
      soldPrice: soldPrice ?? this.soldPrice,
      soldTime: soldTime ?? this.soldTime,
      soldNotes: soldNotes ?? this.soldNotes,
      bom: bom ?? this.bom,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'assetId': assetId,
      'archived': archived,
      'name': name,
      'qty': qty,
      'description': description,
      'purchasePrice': purchasePrice,
      'purchaseFrom': purchaseFrom,
      'purchaseTime': purchaseTime?.millisecondsSinceEpoch,
      'manufacturer': manufacturer,
      'serialNumber': serialNumber,
      'lifetimeWarranty': lifetimeWarranty,
      'warrantyExpires': warrantyExpires?.millisecondsSinceEpoch,
      'warrantyDetails': warrantyDetails,
      'soldTo': soldTo,
      'soldPrice': soldPrice,
      'soldTime': soldTime?.millisecondsSinceEpoch,
      'soldNotes': soldNotes,
      'bom': bom,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'] as int,
      assetId: map['assetId'] as String,
      archived: map['archived'] as bool,
      name: map['name'] as String,
      qty: map['qty'] as num,
      description: map['description'] as String,
      purchasePrice: map['purchasePrice'] as num,
      purchaseFrom: map['purchaseFrom'] as String,
      purchaseTime: map['purchaseTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['purchaseTime'] as int)
          : null,
      manufacturer: map['manufacturer'] as String,
      serialNumber: map['serialNumber'] as String,
      lifetimeWarranty: map['lifetimeWarranty'] as bool,
      warrantyExpires: map['warrantyExpires'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['warrantyExpires'] as int)
          : null,
      warrantyDetails: map['warrantyDetails'] as String,
      soldTo: map['soldTo'] as String,
      soldPrice: map['soldPrice'] as num,
      soldTime: map['soldTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['soldTime'] as int)
          : null,
      soldNotes: map['soldNotes'] as String,
      bom: map['bom'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemModel(id: $id, assetId: $assetId, archived: $archived, name: $name, qty: $qty, description: $description, purchasePrice: $purchasePrice, purchaseFrom: $purchaseFrom, purchaseTime: $purchaseTime, manufacturer: $manufacturer, serialNumber: $serialNumber, lifetimeWarranty: $lifetimeWarranty, warrantyExpires: $warrantyExpires, warrantyDetails: $warrantyDetails, soldTo: $soldTo, soldPrice: $soldPrice, soldTime: $soldTime, soldNotes: $soldNotes, bom: $bom, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant ItemModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.assetId == assetId &&
        other.archived == archived &&
        other.name == name &&
        other.qty == qty &&
        other.description == description &&
        other.purchasePrice == purchasePrice &&
        other.purchaseFrom == purchaseFrom &&
        other.purchaseTime == purchaseTime &&
        other.manufacturer == manufacturer &&
        other.serialNumber == serialNumber &&
        other.lifetimeWarranty == lifetimeWarranty &&
        other.warrantyExpires == warrantyExpires &&
        other.warrantyDetails == warrantyDetails &&
        other.soldTo == soldTo &&
        other.soldPrice == soldPrice &&
        other.soldTime == soldTime &&
        other.soldNotes == soldNotes &&
        other.bom == bom &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        assetId.hashCode ^
        archived.hashCode ^
        name.hashCode ^
        qty.hashCode ^
        description.hashCode ^
        purchasePrice.hashCode ^
        purchaseFrom.hashCode ^
        purchaseTime.hashCode ^
        manufacturer.hashCode ^
        serialNumber.hashCode ^
        lifetimeWarranty.hashCode ^
        warrantyExpires.hashCode ^
        warrantyDetails.hashCode ^
        soldTo.hashCode ^
        soldPrice.hashCode ^
        soldTime.hashCode ^
        soldNotes.hashCode ^
        bom.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
