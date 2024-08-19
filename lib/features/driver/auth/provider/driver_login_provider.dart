import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuel_management/core/functions/navigation.dart';
import 'package:fuel_management/core/local_storage.dart';
import 'package:fuel_management/core/views/custom_dialog.dart';
import 'package:fuel_management/features/admin/dashboard/data/driver_model.dart';
import 'package:fuel_management/features/admin/dashboard/services/drivers_services.dart';
import 'package:fuel_management/features/driver/pages/driver_home_page.dart';
import '../../../admin/auth/provider/admin_login_provider.dart';

final driverProvider =
    StateNotifierProvider<DriverProvider, DriverModel?>((ref) {
  var driverId = LocalStorage.getData('driver');
  if (driverId != null) {
    var driver = DriverModel.fromJson(driverId);
    return DriverProvider(driver);
  } else {
    return DriverProvider(null);
  }
});

class DriverProvider extends StateNotifier<DriverModel?> {
  DriverProvider(this.driver) : super(driver);

  final DriverModel? driver;
}

final driverLoginProvider =
    StateNotifierProvider<DriverLoginProvider, LoginModel>((ref) {
  return DriverLoginProvider();
});

class DriverLoginProvider extends StateNotifier<LoginModel> {
  DriverLoginProvider() : super(LoginModel(id: '', password: ''));

  void setId(String id) {
    state = state.copyWith(id: id);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void loginDriver(
      {required BuildContext context, required WidgetRef ref}) async {
    CustomDialogs.loading(
      message: 'Logging in...',
    );
    var driver =
        await DriversServices.getDriver(id: state.id, password: state.password);
    if (driver != null) {
      CustomDialogs.dismiss();
      CustomDialogs.toast(message: 'Login successful');
      LocalStorage.saveData('driver', driver.toJson());
      ref.read(driverProvider.notifier).state = driver;
      navigateAndReplace(context, const DriverHomePage());
    } else {
      CustomDialogs.dismiss();
      CustomDialogs.toast(message: 'Invalid driver credentials');
    }
  }
}
