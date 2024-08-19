import 'dart:convert';

class FuelModel {
  String id;
  String carId;
  double quantity;
  double price;
  int dateTime;
  String fuelType;
  String receiptImage;
  String boughtById;
  String recordedBy;
  String boughtByName;
  String boughtByPhone;
  String boughtByImage;
  int createdAt;
  FuelModel({
    required this.id,
    required this.carId,
    required this.quantity,
    required this.price,
    required this.dateTime,
    required this.fuelType,
    required this.receiptImage,
    required this.boughtById,
    required this.recordedBy,
    required this.boughtByName,
    required this.boughtByPhone,
    required this.boughtByImage,
    required this.createdAt,
  });

  static FuelModel empty() {
    return FuelModel(
      id: '',
      carId: '',
      quantity: 0.0,
      price: 0.0,
      dateTime: 0,
      fuelType: '',
      receiptImage: '',
      boughtById: '',
      boughtByName: '',
      boughtByPhone: '',
      boughtByImage: '',
      createdAt: 0,
      recordedBy: '',
    );
  }

  FuelModel copyWith({
    String? id,
    String? carId,
    double? quantity,
    double? price,
    int? dateTime,
    String? fuelType,
    String? receiptImage,
    String? boughtById,
    String? recordedBy,
    String? boughtByName,
    String? boughtByPhone,
    String? boughtByImage,
    int? createdAt,
  }) {
    return FuelModel(
      id: id ?? this.id,
      carId: carId ?? this.carId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      dateTime: dateTime ?? this.dateTime,
      fuelType: fuelType ?? this.fuelType,
      receiptImage: receiptImage ?? this.receiptImage,
      boughtById: boughtById ?? this.boughtById,
      recordedBy: recordedBy ?? this.recordedBy,
      boughtByName: boughtByName ?? this.boughtByName,
      boughtByPhone: boughtByPhone ?? this.boughtByPhone,
      boughtByImage: boughtByImage ?? this.boughtByImage,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'carId': carId});
    result.addAll({'quantity': quantity});
    result.addAll({'price': price});
    result.addAll({'dateTime': dateTime});
    result.addAll({'fuelType': fuelType});
    result.addAll({'receiptImage': receiptImage});
    result.addAll({'boughtById': boughtById});
    result.addAll({'recordedBy': recordedBy});
    result.addAll({'boughtByName': boughtByName});
    result.addAll({'boughtByPhone': boughtByPhone});
    result.addAll({'boughtByImage': boughtByImage});
    result.addAll({'createdAt': createdAt});
  
    return result;
  }

  factory FuelModel.fromMap(Map<String, dynamic> map) {
    return FuelModel(
      id: map['id'] ?? '',
      carId: map['carId'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      price: map['price']?.toDouble() ?? 0.0,
      dateTime: map['dateTime']?.toInt() ?? 0,
      fuelType: map['fuelType'] ?? '',
      receiptImage: map['receiptImage'] ?? '',
      boughtById: map['boughtById'] ?? '',
      recordedBy: map['recordedBy'] ?? '',
      boughtByName: map['boughtByName'] ?? '',
      boughtByPhone: map['boughtByPhone'] ?? '',
      boughtByImage: map['boughtByImage'] ?? '',
      createdAt: map['createdAt']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory FuelModel.fromJson(String source) =>
      FuelModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FuelModel(id: $id, carId: $carId, quantity: $quantity, price: $price, dateTime: $dateTime, fuelType: $fuelType, receiptImage: $receiptImage, boughtById: $boughtById, recordedBy: $recordedBy, boughtByName: $boughtByName, boughtByPhone: $boughtByPhone, boughtByImage: $boughtByImage, createdAt: $createdAt)';
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
      other.fuelType == fuelType &&
      other.receiptImage == receiptImage &&
      other.boughtById == boughtById &&
      other.recordedBy == recordedBy &&
      other.boughtByName == boughtByName &&
      other.boughtByPhone == boughtByPhone &&
      other.boughtByImage == boughtByImage &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      carId.hashCode ^
      quantity.hashCode ^
      price.hashCode ^
      dateTime.hashCode ^
      fuelType.hashCode ^
      receiptImage.hashCode ^
      boughtById.hashCode ^
      recordedBy.hashCode ^
      boughtByName.hashCode ^
      boughtByPhone.hashCode ^
      boughtByImage.hashCode ^
      createdAt.hashCode;
  }
}
