import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuel_management/features/admin/dashboard/provider/fuel_purchace_provider.dart';

import '../../../utils/styles.dart';
import '../auth/provider/driver_login_provider.dart';

class PurchasesPage extends ConsumerStatefulWidget {
  const PurchasesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PurchasesPageState();
}

class _PurchasesPageState extends ConsumerState<PurchasesPage> {

  @override
  Widget build(BuildContext context) {
    var style = Styles(context);
    var driver = ref.watch(driverProvider);
    var purchases = ref.watch(fuelProvider).items.where((element) => element.boughtById == driver!.id).toList();
    return Container();
  }
}