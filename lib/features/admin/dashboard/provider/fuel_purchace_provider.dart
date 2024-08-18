import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/fuel_model.dart';

class FuelFilter {
  List<FuelModel> items;
  List<FuelModel> filter;

  FuelFilter({
    required this.items,
    required this.filter,
  });


  FuelFilter copyWith({
    List<FuelModel>? items,
    List<FuelModel>? filter,
  }) {
    return FuelFilter(
      items: items ?? this.items,
      filter: filter ?? this.filter,
    );
  }
}


final fuelProvider = StateNotifierProvider<FuelProvider, FuelFilter>((ref) {
  return FuelProvider();
});


class FuelProvider extends StateNotifier<FuelFilter> {
  FuelProvider() : super(FuelFilter(items: [], filter: []));

  void setItems(List<FuelModel> items) {
    state = state.copyWith(items: items, filter: items);
  }

  void filterFuel(String query) {
    if (query.isEmpty) {
      state = state.copyWith(filter: state.items);
    } else {
      final filter = state.items
          .where((element) =>
              element.carId.toLowerCase().contains(query.toLowerCase()) ||
              element.id.toLowerCase().contains(query.toLowerCase()))
          .toList();
      state = state.copyWith(filter: filter);
    }
  }
}
