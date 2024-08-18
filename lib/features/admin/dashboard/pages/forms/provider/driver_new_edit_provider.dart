import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/driver_model.dart';

final newDriverProvider =
    StateNotifierProvider<NewDriverProvider, DriverModel>((ref) {
  return NewDriverProvider();
});

class NewDriverProvider extends StateNotifier<DriverModel> {
  NewDriverProvider() : super(DriverModel.empty());
}


final editDriverProvider
