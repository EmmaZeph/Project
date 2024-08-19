import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/fuel_model.dart';

final newPurchaseProvider = StateNotifierProvider<NewPurchaseProvider, FuelModel>((ref) {
  return NewPurchaseProvider();
});


class NewPurchaseProvider extends StateNotifier<FuelModel> {
  NewPurchaseProvider() : super(FuelModel.empty());

}


final editPurchaseProvider = StateNotifierProvider<EditPurchaseProvider, FuelModel>((ref) {
  return EditPurchaseProvider();
});


class EditPurchaseProvider extends StateNotifier<FuelModel> {
  EditPurchaseProvider() : super(FuelModel.empty());

  void setPurchase(FuelModel purchase) {}

}



