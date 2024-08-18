import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuel_management/features/admin/dashboard/data/fuel_model.dart';

class FuelPurchaseServices{

  static final CollectionReference<Map<String,dynamic>> fuelPurchases = FirebaseFirestore.instance.collection('fuelPurchases');

  static String getFuelPurchaseId() {
    return fuelPurchases.doc().id;
  }

  static Future<bool> addFuelPurchase(FuelModel fuelPurchase) async {
    try {
      await fuelPurchases.doc(fuelPurchase.id).set(fuelPurchase.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateFuelPurchase(FuelModel fuelPurchase) async {
    try {
      await fuelPurchases.doc(fuelPurchase.id).update(fuelPurchase.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }


  static Future<bool> deleteFuelPurchase(String id) async {
    try {
      await fuelPurchases.doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }


  static Stream<List<FuelModel>> getFuelPurchases() {
    return fuelPurchases.snapshots().map((snapshot) => snapshot.docs.map((doc) => FuelModel.fromMap(doc.data())).toList());
  }
}