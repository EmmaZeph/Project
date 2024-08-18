import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuel_management/core/local_storage.dart';
import 'package:fuel_management/core/views/custom_dialog.dart';
import 'package:fuel_management/router/router.dart';
import 'package:fuel_management/router/router_items.dart';

class AdminLogin {
  String id;
  String password;
  AdminLogin({
    required this.id,
    required this.password,
  });

  AdminLogin copyWith({
    String? id,
    String? password,
  }) {
    return AdminLogin(
      id: id ?? this.id,
      password: password ?? this.password,
    );
  }
}

final adminLoginProvider =
    StateNotifierProvider<AdminLoginProvider, AdminLogin>(
        (ref) => AdminLoginProvider());

class AdminLoginProvider extends StateNotifier<AdminLogin> {
  AdminLoginProvider() : super(AdminLogin(id: '', password: ''));

  void setId(String id) {
    state = state.copyWith(id: id);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void loginAdmin(
      {required BuildContext context, required WidgetRef ref}) async {
    CustomDialogs.loading(
      message: 'Logging in...',
    );
    await Future.delayed(const Duration(seconds: 2));
    if (state.id == 'admin' && state.password == 'admin123') {
      CustomDialogs.dismiss();
      CustomDialogs.toast(message: 'Login successful');
      LocalStorage.saveData('isLogged', 'true');
      ref.read(adminProvider.notifier).state = true;
      MyRouter(context: context, ref: ref)
          .navigateToRoute(RouterItem.dashboardRoute);
    } else {
      CustomDialogs.toast(message: 'Invalid admin credentials');
    }
  }

  void logout({required BuildContext context, required WidgetRef ref}) {
    CustomDialogs.dismiss();
    CustomDialogs.loading(message: 'Logging out...');
    LocalStorage.removeData('isLogged');
    ref.read(adminProvider.notifier).state = false;
    CustomDialogs.dismiss();
    MyRouter(context: context, ref: ref)
        .navigateToRoute(RouterItem.loginRoute);
  }
}

final adminProvider = StateProvider< bool>((ref) {
  var isLogged = LocalStorage.getData('isLogged');
  if (isLogged != null) {
    return true;
  }
  return false;
});
