import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuel_management/features/admin/dashboard/provider/fuel_purchace_provider.dart';
import '../../../../router/router.dart';
import '../../../../router/router_items.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';
import '../provider/assignment_provider.dart';
import '../provider/cars_provider.dart';
import '../provider/drivers_provider.dart';
import '../views/components/dasboard_item.dart';

class DashboardHomePage extends ConsumerStatefulWidget {
  const DashboardHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardHomePageState();
}

class _DashboardHomePageState extends ConsumerState<DashboardHomePage> {
  @override
  Widget build(BuildContext context) {
    var style = Styles(context);
    var cars = ref.watch(carsProvider).items;
    var drivers = ref.watch(driversProvider).items;
    var assignments = ref.watch(assignmentsProvider).items;
    var fuelPurchases = ref.watch(fuelProvider).items;
    return Container(
        color: Colors.white,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              const SizedBox(height: 20),
              Text(
                'Dashboard'.toUpperCase(),
                style: style.title(color: primaryColor),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
               
                    DashBoardItem(
                      icon: Icons.car_rental,
                      title: 'Cars'.toUpperCase(),
                      itemCount: cars.length,
                      color: Colors.blue,
                      onTap: () {
                        MyRouter(context: context,ref: ref).navigateToRoute(RouterItem.carsRoute);
                      },
                    ),
                    DashBoardItem(
                      icon: Icons.people_alt_outlined,
                      title: 'Drivers'.toUpperCase(),
                      itemCount: drivers.length,
                      color: Colors.green,
                      onTap: () {
                        MyRouter(context: context,ref: ref).navigateToRoute(RouterItem.driversRoute);
                      },
                    ),
                  DashBoardItem(
                    icon: Icons.assignment,
                    title: 'Assignment'.toUpperCase(),
                    itemCount: assignments.length,
                    color: Colors.orange,
                    onTap: () {
                      MyRouter(context: context,ref: ref).navigateToRoute(RouterItem.assignmentRoute);
                    },
                  ),
                  DashBoardItem(
                    icon: Icons.local_gas_station,
                    title: 'Fuel Purchases'.toUpperCase(),
                    itemCount: fuelPurchases.length,
                    color: Colors.red,
                    onTap: () {
                      MyRouter(context: context,ref: ref).navigateToRoute(RouterItem.fuelPurchaseRoute);
                    },
                  ),
                 ],
              ),
            ])));
  }
}
