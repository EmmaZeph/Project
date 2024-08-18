import 'dart:convert';
import 'package:flutter/foundation.dart';

class AssignmentModel {
  String id;
  int pickupDateTime;
  String driverId;
  String carId;
  Map<String, dynamic> driver;
  Map<String, dynamic> car;
  String destination;
  int returnDateTime;
  double pickupFuelLevel;
  double returnFuelLevel;
  List<Map<String,dynamic>> fuelPurchase;
  String status;
  String description;
  AssignmentModel({
    required this.id,
    required this.pickupDateTime,
    required this.driverId,
    required this.carId,
     this.driver= const {},
     this.car=const {},
    required this.destination,
    required this.returnDateTime,
    required this.pickupFuelLevel,
    required this.returnFuelLevel,
     this.fuelPurchase = const [],
     this.status = 'pending',
    required this.description,
  });

  static AssignmentModel empty() {
    return AssignmentModel(
      id: '',
      pickupDateTime: 0,
      driverId: '',
      carId: '',
      driver: {},
      car: {},
      destination: '',
      returnDateTime: 0,
      pickupFuelLevel: 0.0,
      returnFuelLevel: 0.0,
      fuelPurchase: [],
      status: 'pending',
      description: '',
    );
  }

  AssignmentModel copyWith({
    String? id,
    int? pickupDateTime,
    String? driverId,
    String? carId,
    Map<String, dynamic>? driver,
    Map<String, dynamic>? car,
    String? destination,
    int? returnDateTime,
    double? pickupFuelLevel,
    double? returnFuelLevel,
    List<Map<String,dynamic>>? fuelPurchase,
    String? status,
    String? description,
  }) {
    return AssignmentModel(
      id: id ?? this.id,
      pickupDateTime: pickupDateTime ?? this.pickupDateTime,
      driverId: driverId ?? this.driverId,
      carId: carId ?? this.carId,
      driver: driver ?? this.driver,
      car: car ?? this.car,
      destination: destination ?? this.destination,
      returnDateTime: returnDateTime ?? this.returnDateTime,
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
    result.addAll({'pickupDateTime': pickupDateTime});
    result.addAll({'driverId': driverId});
    result.addAll({'carId': carId});
    result.addAll({'driver': driver});
    result.addAll({'car': car});
    result.addAll({'destination': destination});
    result.addAll({'returnDateTime': returnDateTime});
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
      pickupDateTime: map['pickupDateTime']?.toInt() ?? 0,
      driverId: map['driverId'] ?? '',
      carId: map['carId'] ?? '',
      driver: Map<String, dynamic>.from(map['driver']),
      car: Map<String, dynamic>.from(map['car']),
      destination: map['destination'] ?? '',
      returnDateTime: map['returnDateTime']?.toInt() ?? 0,
      pickupFuelLevel: map['pickupFuelLevel']?.toDouble() ?? 0.0,
      returnFuelLevel: map['returnFuelLevel']?.toDouble() ?? 0.0,
      fuelPurchase: List<Map<String,dynamic>>.from(map['fuelPurchase']?.map((x) => Map<String,dynamic>.from(x))),
      status: map['status'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AssignmentModel.fromJson(String source) => AssignmentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AssignmentModel(id: $id, pickupDateTime: $pickupDateTime, driverId: $driverId, carId: $carId, driver: $driver, car: $car, destination: $destination, returnDateTime: $returnDateTime, pickupFuelLevel: $pickupFuelLevel, returnFuelLevel: $returnFuelLevel, fuelPurchase: $fuelPurchase, status: $status, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AssignmentModel &&
      other.id == id &&
      other.pickupDateTime == pickupDateTime &&
      other.driverId == driverId &&
      other.carId == carId &&
      mapEquals(other.driver, driver) &&
      mapEquals(other.car, car) &&
      other.destination == destination &&
      other.returnDateTime == returnDateTime &&
      other.pickupFuelLevel == pickupFuelLevel &&
      other.returnFuelLevel == returnFuelLevel &&
      listEquals(other.fuelPurchase, fuelPurchase) &&
      other.status == status &&
      other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      pickupDateTime.hashCode ^
      driverId.hashCode ^
      carId.hashCode ^
      driver.hashCode ^
      car.hashCode ^
      destination.hashCode ^
      returnDateTime.hashCode ^
      pickupFuelLevel.hashCode ^
      returnFuelLevel.hashCode ^
      fuelPurchase.hashCode ^
      status.hashCode ^
      description.hashCode;
  }
}
