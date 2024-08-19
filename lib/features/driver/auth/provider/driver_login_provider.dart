import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuel_management/core/local_storage.dart';
import 'package:fuel_management/features/admin/dashboard/data/driver_model.dart';

final driverProvider =
    StateNotifierProvider<DriverProvider, DriverModel?>((ref) {
  var driverId = LocalStorage.getData('driver');
  if (driverId != null) {
    var driver = DriverModel.fromJson(driverId);
    return DriverProvider(driver);
  }else {
    return DriverProvider(null);
  }
});

class DriverProvider extends StateNotifier<DriverModel?> {
  DriverProvider(this.driver) : super(driver);

  final DriverModel? driver;
}
