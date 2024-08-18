import 'dart:convert';
import 'package:flutter/foundation.dart';

class FuelModel {
  String id;
  String carId;
  double quantity;
  double price;
  int dateTime;
  Map<String,dynamic> boughtBy;
  FuelModel({
    required this.id,
    required this.carId,
    required this.quantity,
    required this.price,
    required this.dateTime,
     this.boughtBy = const {},
  });

  static FuelModel empty() {
    return FuelModel(
      id: '',
      carId: '',
      quantity: 0.0,
      price: 0.0,
      dateTime: 0,
      boughtBy: {},
    );
  }

  FuelModel copyWith({
    String? id,
    String? carId,
    double? quantity,
    double? price,
    int? dateTime,
    Map<String,dynamic>? boughtBy,
  }) {
    return FuelModel(
      id: id ?? this.id,
      carId: carId ?? this.carId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      dateTime: dateTime ?? this.dateTime,
      boughtBy: boughtBy ?? this.boughtBy,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'carId': carId});
    result.addAll({'quantity': quantity});
    result.addAll({'price': price});
    result.addAll({'dateTime': dateTime});
    result.addAll({'boughtBy': boughtBy});
  
    return result;
  }

  factory FuelModel.fromMap(Map<String, dynamic> map) {
    return FuelModel(
      id: map['id'] ?? '',
      carId: map['carId'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      price: map['price']?.toDouble() ?? 0.0,
      dateTime: map['dateTime']?.toInt() ?? 0,
      boughtBy: Map<String,dynamic>.from(map['boughtBy']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FuelModel.fromJson(String source) => FuelModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FuelModel(id: $id, carId: $carId, quantity: $quantity, price: $price, dateTime: $dateTime, boughtBy: $boughtBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is FuelModel &&
      other.id == id &&
      other.carId == carId &&
      other.quantity == quantity &&
      other.price == price &&
      other.dateTime == dateTime &&
      mapEquals(other.boughtBy, boughtBy);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      carId.hashCode ^
      quantity.hashCode ^
      price.hashCode ^
      dateTime.hashCode ^
      boughtBy.hashCode;
  }
}
