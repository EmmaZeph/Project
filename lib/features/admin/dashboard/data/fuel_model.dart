import 'dart:convert';

class FuelModel {
  String id;
  String carId;
  double quantity;
  double price;
  int dateTime;
  String boughtByType;
  String boughtById;
  String boughtByName;
  String boughtByPhone;
  String boughtByImage;
  FuelModel({
    required this.id,
    required this.carId,
    required this.quantity,
    required this.price,
    required this.dateTime,
    required this.boughtByType,
    required this.boughtById,
    required this.boughtByName,
    required this.boughtByPhone,
    required this.boughtByImage,
  });

  static FuelModel empty() {
    return FuelModel(
      id: '',
      carId: '',
      quantity: 0.0,
      price: 0.0,
      dateTime: 0,
      boughtByType: '',
      boughtById: '',
      boughtByName: '',
      boughtByPhone: '',
      boughtByImage: '',

    );
  }

  FuelModel copyWith({
    String? id,
    String? carId,
    double? quantity,
    double? price,
    int? dateTime,
    String? boughtByType,
    String? boughtById,
    String? boughtByName,
    String? boughtByPhone,
    String? boughtByImage,
  }) {
    return FuelModel(
      id: id ?? this.id,
      carId: carId ?? this.carId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      dateTime: dateTime ?? this.dateTime,
      boughtByType: boughtByType ?? this.boughtByType,
      boughtById: boughtById ?? this.boughtById,
      boughtByName: boughtByName ?? this.boughtByName,
      boughtByPhone: boughtByPhone ?? this.boughtByPhone,
      boughtByImage: boughtByImage ?? this.boughtByImage,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'carId': carId});
    result.addAll({'quantity': quantity});
    result.addAll({'price': price});
    result.addAll({'dateTime': dateTime});
    result.addAll({'boughtByType': boughtByType});
    result.addAll({'boughtById': boughtById});
    result.addAll({'boughtByName': boughtByName});
    result.addAll({'boughtByPhone': boughtByPhone});
    result.addAll({'boughtByImage': boughtByImage});
  
    return result;
  }

  factory FuelModel.fromMap(Map<String, dynamic> map) {
    return FuelModel(
      id: map['id'] ?? '',
      carId: map['carId'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      price: map['price']?.toDouble() ?? 0.0,
      dateTime: map['dateTime']?.toInt() ?? 0,
      boughtByType: map['boughtByType'] ?? '',
      boughtById: map['boughtById'] ?? '',
      boughtByName: map['boughtByName'] ?? '',
      boughtByPhone: map['boughtByPhone'] ?? '',
      boughtByImage: map['boughtByImage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FuelModel.fromJson(String source) => FuelModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FuelModel(id: $id, carId: $carId, quantity: $quantity, price: $price, dateTime: $dateTime, boughtByType: $boughtByType, boughtById: $boughtById, boughtByName: $boughtByName, boughtByPhone: $boughtByPhone, boughtByImage: $boughtByImage)';
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
      other.boughtByType == boughtByType &&
      other.boughtById == boughtById &&
      other.boughtByName == boughtByName &&
      other.boughtByPhone == boughtByPhone &&
      other.boughtByImage == boughtByImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      carId.hashCode ^
      quantity.hashCode ^
      price.hashCode ^
      dateTime.hashCode ^
      boughtByType.hashCode ^
      boughtById.hashCode ^
      boughtByName.hashCode ^
      boughtByPhone.hashCode ^
      boughtByImage.hashCode;
  }
}
