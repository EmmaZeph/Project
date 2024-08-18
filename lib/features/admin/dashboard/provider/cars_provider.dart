import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuel_management/core/views/custom_dialog.dart';
import 'package:fuel_management/features/admin/dashboard/services/car_services.dart';
import '../data/car_model.dart';

class CarsFilter {
  List<CarModel> items;
  List<CarModel> filter;
  CarsFilter({
    required this.items,
    required this.filter,
  });

  CarsFilter copyWith({
    List<CarModel>? items,
    List<CarModel>? filter,
  }) {
    return CarsFilter(
      items: items ?? this.items,
      filter: filter ?? this.filter,
    );
  }
}

final carsProvider = StateNotifierProvider<CarsProvider, CarsFilter>((ref) {
  return CarsProvider();
});

class CarsProvider extends StateNotifier<CarsFilter> {
  CarsProvider() : super(CarsFilter(items: [], filter: []));

  void setItems(List<CarModel> items) {
    state = state.copyWith(items: items, filter: items);
  }

  void filterCars(String query) {
    if (query.isEmpty) {
      state = state.copyWith(filter: state.items);
    } else {
      final filter = state.items
          .where((element) =>
              element.brand.toLowerCase().contains(query.toLowerCase()) ||
              element.model.toLowerCase().contains(query.toLowerCase()) ||
              element.registrationNumber
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
      state = state.copyWith(filter: filter);
    }
  }

  void deleteCar(CarModel car) async {
    CustomDialogs.dismiss();
    CustomDialogs.loading(message: 'Deleting car...');
    var results = await CarServices.deleteCar( car.id);
    if (results) {
      CustomDialogs.dismiss();
      CustomDialogs.showDialog(
        message: 'Car deleted successfully',
        type: DialogType.success,
      );
    } else {
      CustomDialogs.dismiss();
      CustomDialogs.showDialog(
        message: 'Failed to delete car',
        type: DialogType.error,
      );
    }
  }
}
