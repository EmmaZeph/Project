import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuel_management/features/admin/dashboard/provider/fuel_purchace_provider.dart';
import '../../../core/functions/int_to_date.dart';
import '../../../utils/colors.dart';
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
    var purchases = ref
        .watch(fuelProvider)
        .items
        .where((element) => element.boughtById == driver!.id)
        .toList();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Fuel Purchases', style: style.title(color: primaryColor)),
          const SizedBox(
            height: 20,
          ),
          if (purchases.isEmpty) const Center(child: Text('No purchases yet')),
          ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var purchase = purchases[index];
                return Container(
                  width: style.width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.5),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date: ${intToDate(purchase.dateTime)}',
                        style: style.body(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Quantity: ${purchase.quantity} Litres',
                        style: style.body(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Price: GHS${purchase.price}',
                        style: style.body(color: Colors.white),
                      ),
                    ],
                  ),
                );
              },
              itemCount: purchases.length),
        ],
      ),
    );
  }
}
