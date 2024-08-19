import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuel_management/core/functions/int_to_date.dart';
import 'package:fuel_management/features/admin/dashboard/pages/forms/provider/fuel_purchase_provider.dart';
import 'package:fuel_management/features/admin/dashboard/provider/fuel_purchace_provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/views/custom_button.dart';
import '../../../../core/views/custom_dialog.dart';
import '../../../../core/views/custom_input.dart';
import '../../../../router/router.dart';
import '../../../../router/router_items.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';

class FuelPurchasePage extends ConsumerStatefulWidget {
  const FuelPurchasePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FuelPurchasePageState();
}

class _FuelPurchasePageState extends ConsumerState<FuelPurchasePage> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    var titleStyles = styles.title(color: Colors.white, fontSize: 15);
    var rowStyles = styles.body(fontSize: 13);
    var purchases = ref.watch(fuelProvider).filter.toList();
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recorded Fuel Purchases'.toUpperCase(),
            style: styles.title(fontSize: 35, color: primaryColor),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            color: secondaryColor,
            thickness: 2,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: styles.width * .4,
                child: CustomTextFields(
                  hintText: 'Search a purchase',
                  onChanged: (query) {
                    ref.read(fuelProvider.notifier).filterFuel(query);
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              CustomButton(
                text: 'Record New',
                radius: 10,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                onPressed: () {
                  context.go(RouterItem.newFuelPurchaseRoute.path);
                },
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: DataTable2(
              columnSpacing: 30,
              horizontalMargin: 12,
              empty: Center(
                  child: Text(
                'No Purchase found',
                style: rowStyles,
              )),
              minWidth: styles.width * .8,
              headingRowColor: WidgetStateColor.resolveWith(
                  (states) => primaryColor.withOpacity(0.6)),
              headingTextStyle: titleStyles,
              columns: [
                DataColumn2(
                    label: Text(
                      'INDEX',
                      style: titleStyles,
                    ),
                    fixedWidth: styles.largerThanMobile ? 80 : null),
                DataColumn2(
                  label: Text('Date'.toUpperCase()),
                  size: ColumnSize.M,
                ),
                DataColumn2(
                  label: Text('Bought By'.toUpperCase()),
                  size: ColumnSize.L,
                ),
                DataColumn2(
                    label: Text('Quantity'.toUpperCase()),
                    size: ColumnSize.S,
                    fixedWidth: styles.isMobile ? null : 120),
                DataColumn2(
                  label: Text('Cost'.toUpperCase()),
                  size: ColumnSize.M,
                ),
                DataColumn2(
                  label: Text(
                    'Car No.'.toUpperCase(),
                    textAlign: TextAlign.center,
                  ),
                  size: ColumnSize.M,
                ),
                DataColumn2(
                  label: Text('Action'.toUpperCase()),
                  size: ColumnSize.S,
                  fixedWidth: styles.isMobile ? null : 150,
                ),
              ],
              rows: List<DataRow>.generate(purchases.length, (index) {
                var purchase = purchases[index];
                return DataRow(
                  cells: [
                    DataCell(Text('${index + 1}', style: rowStyles)),
                    DataCell(
                        Text(intToDate(purchase.dateTime), style: rowStyles)),
                    DataCell(Text(purchase.boughtByName, style: rowStyles)),
                    DataCell(Text(
                        '${purchase.quantity.toStringAsFixed(1)} litre',
                        style: rowStyles)),
                    DataCell(Text('GHS ${purchase.price.toStringAsFixed(2)}',
                        style: rowStyles)),
                    DataCell(Text(purchase.carId, style: rowStyles)),
                    DataCell(
                      Row(
                        children: [
                          //delete and edit
                          if (purchase.boughtById == 'admin')
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                ref
                                    .read(editPurchaseProvider.notifier)
                                    .setPurchase(purchase);
                                if (ref
                                    .watch(editPurchaseProvider)
                                    .id
                                    .isNotEmpty) {
                                  MyRouter(context: context, ref: ref)
                                      .navigateToNamed(pathPrams: {
                                    'id': purchase.id
                                  }, item: RouterItem.editFuelPurchaseRoute);
                                }
                              },
                            ),
                          if (purchase.boughtById == 'admin')
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                CustomDialogs.showDialog(
                                  message:
                                      'Are you sure you want to delete this purchase?',
                                  type: DialogType.warning,
                                  secondBtnText: 'Delete',
                                  onConfirm: () {
                                    ref
                                        .read(fuelProvider.notifier)
                                        .deletePurchase(purchase);
                                  },
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
