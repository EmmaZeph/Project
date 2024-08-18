import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuel_management/features/admin/dashboard/data/driver_model.dart';

class DriversServices{
  static final CollectionReference<Map<String,dynamic>> drivers = FirebaseFirestore.instance.collection('drivers');

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
    return drivers.snapshots().map((snapshot) => snapshot.docs.map((doc) => DriverModel.fromMap(doc.data())).toList());
  }
}