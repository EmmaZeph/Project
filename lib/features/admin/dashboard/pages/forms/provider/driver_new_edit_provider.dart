import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuel_management/core/views/custom_dialog.dart';
import 'package:fuel_management/features/admin/dashboard/services/drivers_services.dart';
import '../../../data/driver_model.dart';
import '../../../provider/drivers_provider.dart';

final newDriverProvider =
    StateNotifierProvider<NewDriverProvider, DriverModel>((ref) {
  return NewDriverProvider();
});

class NewDriverProvider extends StateNotifier<DriverModel> {
  NewDriverProvider() : super(DriverModel.empty());

  void setDriverId(String? value) {
    state = state.copyWith(id: value!.trim());
  }

  void setGender(type) {
    state = state.copyWith(gender: type);
  }

  void setName(String? name) {
    state = state.copyWith(name: name);
  }

  void setPhone(String? phone) {
    state = state.copyWith(phone: phone);
  }

  void setLicenseNumber(String? value) {
    state = state.copyWith(licenseNumber: value);
  }

  void setLicenseExpire(int value) {
    state = state.copyWith(licenseExpiryDate: value);
  }

  void setDateEmployed(int date) {
    state = state.copyWith(dateEmployed: date);
  }

  void saveDriver(
      {required WidgetRef ref, required GlobalKey<FormState> form}) async {
    CustomDialogs.loading(message: 'Saving driver...');
    var image = ref.watch(driverImageProvider);
    var license = ref.watch(licenseImageProvider);
    //check if user with the same id exists
    var user = ref.watch(driversProvider).items.firstWhere(
        (element) => element.id == state.id,
        orElse: () => DriverModel.empty());
    if (user.id.isNotEmpty) {
      CustomDialogs.dismiss();
      CustomDialogs.showDialog(
          message: 'Driver with the same id already exists',
          type: DialogType.error);
      return;
    }
    var (imageUrl, licenseUrl) = await DriversServices.uploadFiles(
        image: image!, license: license!, driverId: state.id);
    state = state.copyWith(
        image: imageUrl,
        licenseImage: licenseUrl,
        id: state.id,
        status: 'available',
        password: '123456');
    var result = await DriversServices.addDriver(state);
    if (result) {
      CustomDialogs.dismiss();
      CustomDialogs.toast(
          message: 'Driver saved successfully', type: DialogType.success);
      form.currentState!.reset();
      ref.read(driverImageProvider.notifier).state = null;
      ref.read(licenseImageProvider.notifier).state = null;
      state = DriverModel.empty();
    } else {
      CustomDialogs.dismiss();
      CustomDialogs.showDialog(
          message: 'Failed to save driver', type: DialogType.error);
    }
  }
}

final editDriverProvider =
    StateNotifierProvider<EditDriverProvider, DriverModel>((ref) {
  return EditDriverProvider();
});

class EditDriverProvider extends StateNotifier<DriverModel> {
  EditDriverProvider() : super(DriverModel.empty());

  void setDriver(DriverModel driver) {
    state = driver;
  }

  void setDriverId(String? value) {
    state = state.copyWith(id: value!.trim());
  }

  void setGender(type) {
    state = state.copyWith(gender: type);
  }

  void setName(String? name) {
    state = state.copyWith(name: name);
  }

  void setPhone(String s) {
    state = state.copyWith(phone: s);
  }

  void setLicenseNumber(String? value) {
    state = state.copyWith(licenseNumber: value);
  }

  void setLicenseExpire(int millisecondsSinceEpoch) {
    state = state.copyWith(licenseExpiryDate: millisecondsSinceEpoch);
  }

  void setDateEmployed(int millisecondsSinceEpoch) {
    state = state.copyWith(dateEmployed: millisecondsSinceEpoch);
  }

  void updateDriver({required WidgetRef ref, required BuildContext context})async {
    CustomDialogs.loading(message: 'Updating driver...');
    var image = ref.watch(driverImageProvider);
    var license = ref.watch(licenseImageProvider);
    if(image !=null){
      var imageUrl = await DriversServices.uploadImage(image: image, driverId: state.id);
      state = state.copyWith(image: imageUrl);
    }
    if(license !=null){
      var licenseUrl = await DriversServices.uploadLicense(license: license, driverId: state.id);
      state = state.copyWith(licenseImage: licenseUrl);
    }
   }
}

final driverImageProvider = StateProvider<Uint8List?>((ref) {
  return null;
});

final licenseImageProvider = StateProvider<Uint8List?>((ref) {
  return null;
});
