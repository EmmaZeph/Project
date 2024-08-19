import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuel_management/features/admin/dashboard/pages/forms/provider/driver_new_edit_provider.dart';
import 'package:fuel_management/features/admin/dashboard/provider/drivers_provider.dart';
import 'package:fuel_management/router/router.dart';
import 'package:go_router/go_router.dart';
import 'package:image_network/image_network.dart';
import '../../../../core/functions/int_to_date.dart';
import '../../../../core/views/custom_button.dart';
import '../../../../core/views/custom_dialog.dart';
import '../../../../core/views/custom_input.dart';
import '../../../../router/router_items.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';

class DriversPage extends ConsumerStatefulWidget {
  const DriversPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DriversPageState();
}

class _DriversPageState extends ConsumerState<DriversPage> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    var titleStyles = styles.title(color: Colors.white, fontSize: 15);
    var rowStyles = styles.body(fontSize: 13);
    var drivers = ref.watch(driversProvider).filter.toList();
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Registered Drivers'.toUpperCase(),
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
                  hintText: 'Search a driver',
                  onChanged: (query) {
                    ref.read(driversProvider.notifier).filterDrivers(query);
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              CustomButton(
                text: 'New Driver',
                radius: 10,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                onPressed: () {
                  context.go(RouterItem.newDriverRoute.path);
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
                'No Driver found',
                style: rowStyles,
              )),
              minWidth: 1200,
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
                    label: Text('Image'.toUpperCase()),
                    size: ColumnSize.S,
                    fixedWidth: styles.isMobile ? null : 120),
                DataColumn2(
                    label: Text('Name'.toUpperCase()),
                    size: ColumnSize.S,
                    fixedWidth: styles.isMobile ? null : 120),
                DataColumn2(
                    label: Text('Gender'.toUpperCase()),
                    size: ColumnSize.S,
                    fixedWidth: styles.isMobile ? null : 120),
                DataColumn2(
                  label: Text('Phone'.toUpperCase()),
                  size: ColumnSize.S,
                ),
                DataColumn2(
                  label: Text(
                    'License No.'.toUpperCase(),
                    textAlign: TextAlign.center,
                  ),
                  size: ColumnSize.M,
                ),
                DataColumn2(
                  label: Text('License Expire'.toString()),
                  size: ColumnSize.M,
                  fixedWidth: styles.isMobile ? null : 150,
                ),
                DataColumn2(
                  label: Text('Join Date'.toString()),
                  size: ColumnSize.M,
                  fixedWidth: styles.isMobile ? null : 150,
                ),
                DataColumn2(
                  label: Text(
                    'Status'.toUpperCase(),
                    textAlign: TextAlign.center,
                  ),
                  size: ColumnSize.S,
                  fixedWidth: styles.isMobile ? null : 200,
                ),
                DataColumn2(
                  label: Text('Action'.toUpperCase()),
                  size: ColumnSize.S,
                  fixedWidth: styles.isMobile ? null : 150,
                ),
              ],
              rows: List<DataRow>.generate(drivers.length, (index) {
                var driver = drivers[index];
                return DataRow(
                  cells: [
                    DataCell(Text('${index + 1}', style: rowStyles)),
                    DataCell(Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ImageNetwork(
                          height: 70,
                          width: 70,
                          image: driver.image,
                        ),
                      ),
                    )),
                    DataCell(Text(driver.name, style: rowStyles)),
                    DataCell(Text(driver.gender, style: rowStyles)),
                    DataCell(Text(driver.phone, style: rowStyles)),
                    DataCell(Text(driver.licenseNumber, style: rowStyles)),
                    DataCell(Text(intToDate(driver.licenseExpiryDate),
                        style: rowStyles)),
                    DataCell(
                        Text(intToDate(driver.dateEmployed), style: rowStyles)),
                    DataCell(Container(
                        width: 90,
                        // alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        decoration: BoxDecoration(
                            color: driver.status == 'available'
                                ? Colors.green
                                : driver.status == 'on trip'
                                    ? Colors.blue
                                    : Colors.red,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(driver.status,
                            style: rowStyles.copyWith(color: Colors.white)))),
                    DataCell(
                      Row(
                        children: [
                          //delete and edit
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              ref
                                  .read(editDriverProvider.notifier)
                                  .setDriver(driver);
                              if (ref.watch(editDriverProvider).id.isNotEmpty) {
                                MyRouter(context: context, ref: ref)
                                    .navigateToNamed(
                                        pathPrams: {'id': driver.id},
                                        item: RouterItem.editDriverRoute);
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              CustomDialogs.showDialog(
                                message:
                                    'Are you sure you want to delete this driver?',
                                type: DialogType.warning,
                                secondBtnText: 'Delete',
                                onConfirm: () {
                                  ref
                                      .read(driversProvider.notifier)
                                      .deleteDriver(driver);
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
