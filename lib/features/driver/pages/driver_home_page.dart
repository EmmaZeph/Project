import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuel_management/features/admin/dashboard/provider/stream_data_provider.dart';
import 'package:fuel_management/features/driver/pages/history_page.dart';
import 'package:fuel_management/generated/assets.dart';
import 'package:fuel_management/utils/colors.dart';
import 'package:fuel_management/utils/styles.dart';
import '../auth/provider/driver_login_provider.dart';
import '../auth/provider/driver_navigation_provider.dart';
import 'home_page.dart';
import 'purchases_page.dart';

class DriverHomePage extends ConsumerStatefulWidget {
  const DriverHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends ConsumerState<DriverHomePage> {
  @override
  Widget build(BuildContext context) {
    var style = Styles(context);
    var driver = ref.watch(driverProvider);
    var assignmentStream = ref.watch(assignmentStreamProvider);
    var fuelPurchaseStream = ref.watch(fuelStreamProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Image.asset(Assets.imagesLogoWhite, height: 50),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage(driver!.image),
              ),
            ),
          ],
        ),
        body: assignmentStream.when(
            data: (data) {
              return fuelPurchaseStream.when(data: (data){
                return     ref.watch(driverNavProvider) == 0
                  ? const DriverHome()
                  : ref.watch(driverNavProvider) == 1
                      ? const HistoryPage()
                      :
                  const PurchasesPage();
              }, error: (error,stack){
                return Center(child: Text('Error: $error'));
              }, loading: ()=> const CircularProgressIndicator());
            },
            error: (error, stack) {
              return Center(child: Text('Error: $error'));
            },
            loading: () => const CircularProgressIndicator()),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          currentIndex: ref.watch(driverNavProvider),
          onTap: (index) {
            ref.read(driverNavProvider.notifier).state = index;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.money),
              label: 'Purchases',
            ),
          ],
        ),
      ),
    );
  }
}
