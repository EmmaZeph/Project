import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuel_management/core/views/custom_dialog.dart';
import 'package:fuel_management/features/admin/dashboard/services/drivers_services.dart';

import '../data/driver_model.dart';

class DriverFilter {
  List<DriverModel> items;
  List<DriverModel> filter;

  DriverFilter({
    required this.items,
    required this.filter,
  });

  DriverFilter copyWith({
    List<DriverModel>? items,
    List<DriverModel>? filter,
  }) {
    return DriverFilter(
      items: items ?? this.items,
      filter: filter ?? this.filter,
    );
  }
}

final driversProvider =
    StateNotifierProvider<DriversProvider, DriverFilter>((ref) {
  return DriversProvider();
});

class DriversProvider extends StateNotifier<DriverFilter> {
  DriversProvider() : super(DriverFilter(items: [], filter: []));

  void setItems(List<DriverModel> items) {
    state = state.copyWith(items: items, filter: items);
  }

  void filterDrivers(String query) {
    if (query.isEmpty) {
      state = state.copyWith(filter: state.items);
    } else {
      final filter = state.items
          .where((element) =>
              element.name.toLowerCase().contains(query.toLowerCase()) ||
              element.id.toLowerCase().contains(query.toLowerCase()) ||
              element.phone.toLowerCase().contains(query.toLowerCase()))
          .toList();
      state = state.copyWith(filter: filter);
    }
  }

  void deleteDriver(DriverModel driver) async {
    CustomDialogs.dismiss();
    CustomDialogs.loading(message: 'Delete driver...');
    var results = await DriversServices.deleteDriver(driver.id);
    if (results) {
      CustomDialogs.dismiss();
      CustomDialogs.toast(
          message: 'Driver deleted successfully', type: DialogType.success);
    } else {
      CustomDialogs.dismiss();
      CustomDialogs.toast(
          message: 'Unable to delete driver', type: DialogType.error);
    }
  }
}
