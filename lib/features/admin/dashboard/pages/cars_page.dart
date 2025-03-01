import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuel_management/core/views/custom_button.dart';
import 'package:fuel_management/core/views/custom_dialog.dart';
import 'package:fuel_management/features/admin/dashboard/pages/forms/provider/car_new_edit_provider.dart';
import 'package:fuel_management/features/admin/dashboard/provider/cars_provider.dart';
import 'package:fuel_management/router/router.dart';
import 'package:fuel_management/router/router_items.dart';
import 'package:fuel_management/utils/styles.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/views/custom_input.dart';
import '../../../../utils/colors.dart';

class CarsPage extends ConsumerStatefulWidget {
  const CarsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CarsPageState();
}

class _CarsPageState extends ConsumerState<CarsPage> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    var titleStyles = styles.title(color: Colors.white, fontSize: 15);
    var rowStyles = styles.body(fontSize: 13);
    var cars = ref.watch(carsProvider).filter;
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Registered Cars'.toUpperCase(),
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
                  hintText: 'Search a car',
                  onChanged: (query) {
                    ref.read(carsProvider.notifier).filterCars(query);
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              CustomButton(
                text: 'New Car',
                radius: 10,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                onPressed: () {
                  context.go(RouterItem.newCarRoute.path);
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
              isHorizontalScrollBarVisible: true,
              empty: Center(
                  child: Text(
                'No Cars found',
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
                    label: Text('Number'.toUpperCase()),
                    size: ColumnSize.S,
                    fixedWidth: styles.isMobile ? null : 120),
                DataColumn2(
                    label: Text('Type'.toUpperCase()),
                    size: ColumnSize.S,
                    fixedWidth: styles.isMobile ? null : 100),
                DataColumn2(
                  label: Text(
                    'Description'.toUpperCase(),
                    textAlign: TextAlign.center,
                  ),
                  size: ColumnSize.L,
                ),
                DataColumn2(
                  label: Text('Fuel Type'.toString()),
                  size: ColumnSize.S,
                  fixedWidth: styles.isMobile ? null : 150,
                ),
                DataColumn2(
                  label: Text('Fuel Quantity'.toString()),
                  size: ColumnSize.S,
                  fixedWidth: styles.isMobile ? null : 150,
                ),
                DataColumn2(
                  label: Text('Seat Capacity'.toUpperCase()),
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
              rows: List<DataRow>.generate(cars.length, (index) {
                var car = cars[index];
                return DataRow(
                  cells: [
                    DataCell(Text('${index + 1}', style: rowStyles)),
                    DataCell(Text(car.registrationNumber, style: rowStyles)),
                    DataCell(Text(car.type, style: rowStyles)),
                    DataCell(Text(car.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: rowStyles)),
                    DataCell(Text(car.fuelType, style: rowStyles)),
                    DataCell(Text(
                        '${car.fuelCapacity.toStringAsFixed(1)} litre',
                        style: rowStyles)),
                    DataCell(
                        Text(car.seatCapacity.toString(), style: rowStyles)),
                    DataCell(Container(
                        width: 90,
                        // alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        decoration: BoxDecoration(
                            color: car.status == 'available'
                                ? Colors.green
                                : car.status == 'on trip'
                                    ? Colors.blue
                                    : Colors.red,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(car.status,
                            style: rowStyles.copyWith(color: Colors.white)))),
                    DataCell(
                      Row(
                        children: [
                          //delete and edit
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              ref.read(editCarProvider.notifier).setCar(car);
                              if (ref.watch(editCarProvider).id.isNotEmpty) {
                                MyRouter(context: context, ref: ref)
                                    .navigateToNamed(
                                        pathPrams: {'id': car.id},
                                        item: RouterItem.editCarRoute);
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              CustomDialogs.showDialog(
                                message:
                                    'Are you sure you want to delete this car?',
                                type: DialogType.warning,
                                secondBtnText: 'Delete',
                                onConfirm: () {
                                  ref
                                      .read(carsProvider.notifier)
                                      .deleteCar(car);
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
