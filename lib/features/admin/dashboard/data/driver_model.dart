import 'dart:convert';

class DriverModel {
  String id;
  String name;
  String phone;
  String password;
  String image;
  String gender;
  String licenseNumber;
  int licenseExpiryDate;
  int licenseIssueDate;
  String licenseImage;
  String status;
  int dateEmployed;
  DriverModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.password,
    required this.image,
    required this.gender,
    required this.licenseNumber,
    required this.licenseExpiryDate,
    required this.licenseIssueDate,
    required this.licenseImage,
    this.status = 'active',
    required this.dateEmployed,
  });

  static DriverModel empty() {
    return DriverModel(
      id: '',
      name: '',
      phone: '',
      password: '',
      image: '',
      gender: '',
      licenseNumber: '',
      licenseExpiryDate: 0,
      licenseIssueDate: 0,
      licenseImage: '',
      status: '',
      dateEmployed: 0,
    );
  }

  DriverModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? password,
    String? image,
    String? gender,
    String? licenseNumber,
    int? licenseExpiryDate,
    int? licenseIssueDate,
    String? licenseImage,
    String? status,
    int? dateEmployed,
  }) {
    return DriverModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      image: image ?? this.image,
      gender: gender ?? this.gender,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      licenseExpiryDate: licenseExpiryDate ?? this.licenseExpiryDate,
      licenseIssueDate: licenseIssueDate ?? this.licenseIssueDate,
      licenseImage: licenseImage ?? this.licenseImage,
      status: status ?? this.status,
      dateEmployed: dateEmployed ?? this.dateEmployed,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'phone': phone});
    result.addAll({'password': password});
    result.addAll({'image': image});
    result.addAll({'gender': gender});
    result.addAll({'licenseNumber': licenseNumber});
    result.addAll({'licenseExpiryDate': licenseExpiryDate});
    result.addAll({'licenseIssueDate': licenseIssueDate});
    result.addAll({'licenseImage': licenseImage});
    result.addAll({'status': status});
    result.addAll({'dateEmployed': dateEmployed});
  
    return result;
  }

  factory DriverModel.fromMap(Map<String, dynamic> map) {
    return DriverModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
      image: map['image'] ?? '',
      gender: map['gender'] ?? '',
      licenseNumber: map['licenseNumber'] ?? '',
      licenseExpiryDate: map['licenseExpiryDate']?.toInt() ?? 0,
      licenseIssueDate: map['licenseIssueDate']?.toInt() ?? 0,
      licenseImage: map['licenseImage'] ?? '',
      status: map['status'] ?? '',
      dateEmployed: map['dateEmployed']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DriverModel.fromJson(String source) =>
      DriverModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DriverModel(id: $id, name: $name, phone: $phone, password: $password, image: $image, gender: $gender, licenseNumber: $licenseNumber, licenseExpiryDate: $licenseExpiryDate, licenseIssueDate: $licenseIssueDate, licenseImage: $licenseImage, status: $status, dateEmployed: $dateEmployed)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DriverModel &&
      other.id == id &&
      other.name == name &&
      other.phone == phone &&
      other.password == password &&
      other.image == image &&
      other.gender == gender &&
      other.licenseNumber == licenseNumber &&
      other.licenseExpiryDate == licenseExpiryDate &&
      other.licenseIssueDate == licenseIssueDate &&
      other.licenseImage == licenseImage &&
      other.status == status &&
      other.dateEmployed == dateEmployed;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      phone.hashCode ^
      password.hashCode ^
      image.hashCode ^
      gender.hashCode ^
      licenseNumber.hashCode ^
      licenseExpiryDate.hashCode ^
      licenseIssueDate.hashCode ^
      licenseImage.hashCode ^
      status.hashCode ^
      dateEmployed.hashCode;
  }
}
