import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuel_management/core/views/custom_dialog.dart';
import 'package:fuel_management/features/admin/dashboard/data/assignment_model.dart';
import 'package:fuel_management/features/admin/dashboard/data/car_model.dart';
import 'package:fuel_management/features/admin/dashboard/data/driver_model.dart';
import 'package:fuel_management/features/admin/dashboard/services/assignment_services.dart';
import 'package:fuel_management/features/admin/dashboard/services/car_services.dart';
import 'package:fuel_management/features/admin/dashboard/services/drivers_services.dart';

final newAssignmentProvider =
    StateNotifierProvider<NewAssignmentProvider, AssignmentModel>((ref) {
  return NewAssignmentProvider();
});

class NewAssignmentProvider extends StateNotifier<AssignmentModel> {
  NewAssignmentProvider() : super(AssignmentModel.empty());

  void setDriver(DriverModel user) {
    state = state.copyWith(
      driver: user.toMap(),
      driverId: user.id,
    );
  }

  void setCar(CarModel car) {
    state = state.copyWith(
      car: car.toMap(),
      carId: car.id,
    );
  }

  void setInitFuelLevel(double parse) {
    state = state.copyWith(pickupFuelLevel: parse);
  }

  void setDescription(String? value) {
    state = state.copyWith(description: value);
  }

  void setInitDate(int millisecondsSinceEpoch) {
    state = state.copyWith(pickupDate: millisecondsSinceEpoch);
  }

  void setTripRoute(String? value) {
    state = state.copyWith(route: value);
  }

  void setInitTime(int millisecondsSinceEpoch) {
    state = state.copyWith(pickupTime: millisecondsSinceEpoch);
  }

  void saveAssignment(
      {required BuildContext context,
      required GlobalKey<FormState> form}) async {
    CustomDialogs.loading(message: 'Saving Assignment...');
    state = state.copyWith(
        status: 'pending', id: AssignmentServices.getAssignmentId());
    final result = await AssignmentServices.addAssignment(state);
    if (result) {
      //update car status and driver status
      var car = CarModel.fromMap(state.car);
      await CarServices.updateCar(car.copyWith(status: 'on trip'));
      var driver = DriverModel.fromMap(state.driver);
      await DriversServices.updateDriver(driver.copyWith(status: 'on trip'));
      
      CustomDialogs.dismiss();
      CustomDialogs.toast(
          message: 'Assignment saved successfully', type: DialogType.success);
      form.currentState!.reset();
      state = AssignmentModel.empty();
    } else {
      CustomDialogs.dismiss();
      CustomDialogs.toast(
          message: 'Failed to save assignment', type: DialogType.error);
    }
  }
}

final editAssignmentProvider =
    StateNotifierProvider<EditAssignmentProvider, AssignmentModel>((ref) {
  return EditAssignmentProvider();
});

class EditAssignmentProvider extends StateNotifier<AssignmentModel> {
  EditAssignmentProvider() : super(AssignmentModel.empty());

  void setAssignment(AssignmentModel assignment) {
    state = assignment;
  }

  void setDriver(DriverModel driver) {
    state = state.copyWith(
      driver: driver.toMap(),
      driverId: driver.id,
    );
  }


  void setCar(CarModel car) {
    state = state.copyWith(
      car: car.toMap(),
      carId: car.id,
    );
  }

  void setInitDate(int millisecondsSinceEpoch) {
    state = state.copyWith(pickupDate: millisecondsSinceEpoch);
  }

  void setInitTime(int millisecondsSinceEpoch) {
    state = state.copyWith(pickupTime: millisecondsSinceEpoch);
  }

  void setTripRoute(String? value) {
    state = state.copyWith(route: value);
  }

  void setInitFuelLevel(double parse) {
    state = state.copyWith(pickupFuelLevel: parse);
  }

  void setDescription(String? value) {
    state = state.copyWith(description: value);
  }

  void updateAssignments({required BuildContext context, required GlobalKey<FormState> form})async {
    CustomDialogs.loading(message: 'Updating Assignment...');
    final result = await AssignmentServices.updateAssignment(state);
    if (result) {
      //update car status and driver status
      var car = CarModel.fromMap(state.car);
      await CarServices.updateCar(car.copyWith(status: 'on trip'));
      var driver = DriverModel.fromMap(state.driver);
      await DriversServices.updateDriver(driver.copyWith(status: 'on trip'));
      CustomDialogs.dismiss();
      CustomDialogs.toast(
          message: 'Assignment updated successfully', type: DialogType.success);
      form.currentState!.reset();
      state = AssignmentModel.empty();
    } else {
      CustomDialogs.dismiss();
      CustomDialogs.toast(
          message: 'Failed to update assignment', type: DialogType.error);
    }
  }
}
