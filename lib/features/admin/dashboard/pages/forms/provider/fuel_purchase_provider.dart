import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuel_management/core/views/custom_dialog.dart';
import 'package:fuel_management/features/admin/dashboard/data/driver_model.dart';
import 'package:fuel_management/features/admin/dashboard/services/fuel_purchase_services.dart';
import 'package:fuel_management/router/router.dart';
import 'package:fuel_management/router/router_items.dart';

import '../../../data/fuel_model.dart';

final newPurchaseProvider =
    StateNotifierProvider<NewPurchaseProvider, FuelModel>((ref) {
  return NewPurchaseProvider();
});

class NewPurchaseProvider extends StateNotifier<FuelModel> {
  NewPurchaseProvider() : super(FuelModel.empty());

  void setDateTime(int millisecondsSinceEpoch) {
    state = state.copyWith(dateTime: millisecondsSinceEpoch);
  }

  void setQuantity(String? value) {
    state = state.copyWith(quantity: double.parse(value!));
  }

  void setPrice(String? value) {
    state = state.copyWith(price: double.parse(value!));
  }

  void setFuelType(value) {
    state = state.copyWith(fuelType: value);
  }

  void setBoughtBy(DriverModel user) {
    state = state.copyWith(
      boughtById: user.id,
      boughtByName: user.name,
      boughtByPhone: user.phone,
      boughtByImage: user.image,
    );
  }

  void setCarNo(String? value) {
    state = state.copyWith(carId: value!);
  }

  void savePurchase(
      {required WidgetRef ref, required GlobalKey<FormState> form}) async {
    CustomDialogs.loading(message: 'Saving purchase...');
    var image = ref.watch(receiptImageProvider);
    var url =await FuelPurchaseServices.uploadImage(image!);
    if(url.isEmpty){
      CustomDialogs.dismiss();
      CustomDialogs.toast(message: 'Failed to upload receipt image',type: DialogType.error);
      return;
    }
    state = state.copyWith(receiptImage: url,
    id:  FuelPurchaseServices.getFuelPurchaseId(),
    createdAt: DateTime.now().millisecondsSinceEpoch,
    recordedBy: 'admin'
    );
    var results =await FuelPurchaseServices.addFuelPurchase(state);
    if(results){
      CustomDialogs.dismiss();
      CustomDialogs.toast(message: 'Purchase saved successfully');
      form.currentState!.reset();
      ref.read(receiptImageProvider.notifier).state = null;
    }else{
      CustomDialogs.dismiss();
      CustomDialogs.toast(message: 'Failed to save purchase',type: DialogType.error);
    }
  }
}

final editPurchaseProvider =
    StateNotifierProvider<EditPurchaseProvider, FuelModel>((ref) {
  return EditPurchaseProvider();
});

class EditPurchaseProvider extends StateNotifier<FuelModel> {
  EditPurchaseProvider() : super(FuelModel.empty());

  void setPurchase(FuelModel purchase) {
    state = purchase;
  }

  void setDateTime(int millisecondsSinceEpoch) {
    state = state.copyWith(dateTime: millisecondsSinceEpoch);
  }

  void setQuantity(String? value) {
    state = state.copyWith(quantity: double.parse(value!));
  }

  void setPrice(String? value) {
    state = state.copyWith(price: double.parse(value!));
  }

  void setBoughtBy(DriverModel user) {
    state = state.copyWith(
      boughtById: user.id,
      boughtByName: user.name,
      boughtByPhone: user.phone,
      boughtByImage: user.image,
    );
  }

  void setCarNo(String registrationNumber) {
    state = state.copyWith(carId: registrationNumber);
  }

  void setFuelType(value) {
    state = state.copyWith(fuelType: value);
  }

  void updatePurchase({required WidgetRef ref, required BuildContext context})async {
    CustomDialogs.loading(message: 'Updating purchase...');
    var image = ref.watch(receiptImageProvider);
    if(image!=null){
      var url =await FuelPurchaseServices.uploadImage(image);
      if(url.isEmpty){
        CustomDialogs.dismiss();
        CustomDialogs.toast(message: 'Failed to upload receipt image',type: DialogType.error);
        return;
      }
      state = state.copyWith(receiptImage: url);
    }
    var results =await FuelPurchaseServices.updateFuelPurchase(state);
    if(results){
      CustomDialogs.dismiss();
      CustomDialogs.toast(message: 'Purchase updated successfully');
     MyRouter(context: context, ref: ref).navigateToRoute(RouterItem.fuelPurchaseRoute);
    }else{
      CustomDialogs.dismiss();
      CustomDialogs.toast(message: 'Failed to update purchase',type: DialogType.error);
    }

  }
}

final receiptImageProvider = StateProvider<Uint8List?>((ref) {
  return null;
});
