import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fuel_management/features/admin/dashboard/data/driver_model.dart';

class DriversServices {
  static final CollectionReference<Map<String, dynamic>> drivers =
      FirebaseFirestore.instance.collection('drivers');

  static String getDriverId() {
    return drivers.doc().id;
  }

  static Future<bool> addDriver(DriverModel driver) async {
    try {
      await drivers.doc(driver.id).set(driver.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateDriver(DriverModel driver) async {
    try {
      await drivers.doc(driver.id).update(driver.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteDriver(String id) async {
    try {
      await drivers.doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Stream<List<DriverModel>> getDrivers() {
    return drivers.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => DriverModel.fromMap(doc.data())).toList());
  }

  static Future<(String, String)> uploadFiles(
      {required Uint8List image,
      required Uint8List license,
      required String driverId}) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref(driverId);
      TaskSnapshot imageTask = await ref.child('image').putData(image, SettableMetadata(contentType: 'image/jpeg'));
      TaskSnapshot licenseTask = await ref.child('license').putData(license, SettableMetadata(contentType: 'image/jpeg'));
      String imageUrl = await imageTask.ref.getDownloadURL();
      String licenseUrl = await licenseTask.ref.getDownloadURL();
      return (imageUrl, licenseUrl);
    } catch (error) {
      return ('', '');
    }
  }

  static uploadImage({required Uint8List image, required String driverId})async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref(driverId);
      TaskSnapshot imageTask = await ref.child('image').putData(image, SettableMetadata(contentType: 'image/jpeg'));
      return await imageTask.ref.getDownloadURL();
    } catch (error) {
      return '';
    }
  }

  static uploadLicense({required Uint8List license, required String driverId}) async{
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref(driverId);
      TaskSnapshot licenseTask = await ref.child('license').putData(license, SettableMetadata(contentType: 'image/jpeg'));
      return await licenseTask.ref.getDownloadURL();
    } catch (error) {
      return '';
    }
  }
}
