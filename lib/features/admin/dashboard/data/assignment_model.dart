import 'dart:convert';

import 'package:flutter/foundation.dart';

class AssignmentModel {
  String id;
  int pickupDate;
  int pickupTime;
  String driverId;
  String carId;
  Map<String, dynamic> driver;
  Map<String, dynamic> car;
  String route;
  int returnDate;
  int returnTime;
  double pickupFuelLevel;
  double returnFuelLevel;
  List<Map<String, dynamic>> fuelPurchase;
  String status;
  String description;
  AssignmentModel({
    required this.id,
    required this.pickupDate,
    required this.pickupTime,
    required this.driverId,
    required this.carId,
    this.driver = const {},
    this.car = const {},
    required this.route,
    required this.returnDate,
    required this.returnTime,
    required this.pickupFuelLevel,
    required this.returnFuelLevel,
    this.fuelPurchase = const [],
    this.status = 'pending',
    required this.description,
  });

  static AssignmentModel empty() {
    return AssignmentModel(
      id: '',
      pickupDate: 0,
      pickupTime: 0,
      driverId: '',
      carId: '',
      driver: {},
      car: {},
      route: '',
      returnDate: 0,
      returnTime: 0,
      pickupFuelLevel: 0.0,
      returnFuelLevel: 0.0,
      fuelPurchase: [],
      status: 'pending',
      description: '',
    );
  }

  AssignmentModel copyWith({
    String? id,
    int? pickupDate,
    int? pickupTime,
    String? driverId,
    String? carId,
    Map<String, dynamic>? driver,
    Map<String, dynamic>? car,
    String? route,
    int? returnDate,
    int? returnTime,
    double? pickupFuelLevel,
    double? returnFuelLevel,
    List<Map<String, dynamic>>? fuelPurchase,
    String? status,
    String? description,
  }) {
    return AssignmentModel(
      id: id ?? this.id,
      pickupDate: pickupDate ?? this.pickupDate,
      pickupTime: pickupTime ?? this.pickupTime,
      driverId: driverId ?? this.driverId,
      carId: carId ?? this.carId,
      driver: driver ?? this.driver,
      car: car ?? this.car,
      route: route ?? this.route,
      returnDate: returnDate ?? this.returnDate,
      returnTime: returnTime ?? this.returnTime,
      pickupFuelLevel: pickupFuelLevel ?? this.pickupFuelLevel,
      returnFuelLevel: returnFuelLevel ?? this.returnFuelLevel,
      fuelPurchase: fuelPurchase ?? this.fuelPurchase,
      status: status ?? this.status,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'pickupDate': pickupDate});
    result.addAll({'pickupTime': pickupTime});
    result.addAll({'driverId': driverId});
    result.addAll({'carId': carId});
    result.addAll({'driver': driver});
    result.addAll({'car': car});
    result.addAll({'route': route});
    result.addAll({'returnDate': returnDate});
    result.addAll({'returnTime': returnTime});
    result.addAll({'pickupFuelLevel': pickupFuelLevel});
    result.addAll({'returnFuelLevel': returnFuelLevel});
    result.addAll({'fuelPurchase': fuelPurchase});
    result.addAll({'status': status});
    result.addAll({'description': description});
  
    return result;
  }

  factory AssignmentModel.fromMap(Map<String, dynamic> map) {
    return AssignmentModel(
      id: map['id'] ?? '',
      pickupDate: map['pickupDate']?.toInt() ?? 0,
      pickupTime: map['pickupTime']?.toInt() ?? 0,
      driverId: map['driverId'] ?? '',
      carId: map['carId'] ?? '',
      driver: Map<String, dynamic>.from(map['driver']),
      car: Map<String, dynamic>.from(map['car']),
      route: map['route'] ?? '',
      returnDate: map['returnDate']?.toInt() ?? 0,
      returnTime: map['returnTime']?.toInt() ?? 0,
      pickupFuelLevel: map['pickupFuelLevel']?.toDouble() ?? 0.0,
      returnFuelLevel: map['returnFuelLevel']?.toDouble() ?? 0.0,
      fuelPurchase: List<Map<String, dynamic>>.from(map['fuelPurchase']?.map((x) => Map<String, dynamic>.from(x))),
      status: map['status'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AssignmentModel.fromJson(String source) =>
      AssignmentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AssignmentModel(id: $id, pickupDate: $pickupDate, pickupTime: $pickupTime, driverId: $driverId, carId: $carId, driver: $driver, car: $car, route: $route, returnDate: $returnDate, returnTime: $returnTime, pickupFuelLevel: $pickupFuelLevel, returnFuelLevel: $returnFuelLevel, fuelPurchase: $fuelPurchase, status: $status, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AssignmentModel &&
      other.id == id &&
      other.pickupDate == pickupDate &&
      other.pickupTime == pickupTime &&
      other.driverId == driverId &&
      other.carId == carId &&
      mapEquals(other.driver, driver) &&
      mapEquals(other.car, car) &&
      other.route == route &&
      other.returnDate == returnDate &&
      other.returnTime == returnTime &&
      other.pickupFuelLevel == pickupFuelLevel &&
      other.returnFuelLevel == returnFuelLevel &&
      listEquals(other.fuelPurchase, fuelPurchase) &&
      other.status == status &&
      other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      pickupDate.hashCode ^
      pickupTime.hashCode ^
      driverId.hashCode ^
      carId.hashCode ^
      driver.hashCode ^
      car.hashCode ^
      route.hashCode ^
      returnDate.hashCode ^
      returnTime.hashCode ^
      pickupFuelLevel.hashCode ^
      returnFuelLevel.hashCode ^
      fuelPurchase.hashCode ^
      status.hashCode ^
      description.hashCode;
  }
}
