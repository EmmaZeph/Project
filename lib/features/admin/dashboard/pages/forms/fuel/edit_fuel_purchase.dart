import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fuel_management/features/admin/dashboard/data/car_model.dart';
import 'package:fuel_management/features/admin/dashboard/data/driver_model.dart';
import 'package:fuel_management/features/admin/dashboard/pages/forms/provider/fuel_purchase_provider.dart';
import 'package:fuel_management/features/admin/dashboard/provider/fuel_purchace_provider.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../core/constant.dart';
import '../../../../../../core/functions/int_to_date.dart';
import '../../../../../../core/views/custom_button.dart';
import '../../../../../../core/views/custom_dialog.dart';
import '../../../../../../core/views/custom_drop_down.dart';
import '../../../../../../core/views/custom_input.dart';
import '../../../../../../router/router.dart';
import '../../../../../../router/router_items.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/styles.dart';
import '../../../provider/cars_provider.dart';
import '../../../provider/drivers_provider.dart';

class EditFuelPurchase extends ConsumerStatefulWidget {
  const EditFuelPurchase({super.key, required this.id});
  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditFuelPurchaseState();
}

class _EditFuelPurchaseState extends ConsumerState<EditFuelPurchase> {
  final formKey = GlobalKey<FormState>();

  final receiptController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    var notifier = ref.read(editPurchaseProvider.notifier);
    var purchase = ref
        .watch(fuelProvider)
        .items
        .where((element) => element.id == widget.id)
        .toList()
        .firstOrNull;
        print(purchase);
    //check if widget is done building
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (purchase != null) {
        notifier.setPurchase(purchase);
        setState(() {
          
        });
      }
      receiptController.text = purchase?.receiptImage ?? '';
    });
    purchase = ref.watch(editPurchaseProvider);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(22),
      alignment: Alignment.center,
      child: SizedBox(
        width: styles.width * 0.5,
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    MyRouter(context: context, ref: ref)
                        .navigateToRoute(RouterItem.fuelPurchaseRoute);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back_ios),
                      Text(
                        'Back',
                        style: styles.body(fontSize: 15),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Update Purchase'.toUpperCase(),
                        style: styles.title(fontSize: 35, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              color: primaryColor,
              thickness: 5,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: Form(
              key: formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFields(
                          hintText: 'Date of Purchase',
                          label: 'Date of Purchase',
                          controller: TextEditingController(
                              text: ref.watch(editPurchaseProvider).dateTime !=
                                      0
                                  ? intToDate(
                                      ref.watch(editPurchaseProvider).dateTime)
                                  : ''),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Date of Purchase is required';
                            }
                            return null;
                          },
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2100),
                              ).then((value) {
                                if (value != null) {
                                  notifier.setDateTime(
                                      value.millisecondsSinceEpoch);
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: CustomTextFields(
                          hintText: 'Quantity',
                          label: 'Quantity (Liters)',
                          //isCapitalized: true,
                          isDigitOnly: true,
                          initialValue: ref.watch(editPurchaseProvider).quantity.toString(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Quantity is required';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            notifier.setQuantity(value);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: CustomTextFields(
                          hintText: 'Price',
                          label: 'Price (GHS)',
                          initialValue: purchase?.price.toString(),
                          keyboardType: TextInputType.number,
                          isDigitOnly: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Price is required';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            notifier.setPrice(value);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TypeAheadField<DriverModel>(
                          suggestionsCallback: (search) {
                            return ref
                                .watch(driversProvider)
                                .items
                                .where((element) =>
                                    element.name
                                        .toLowerCase()
                                        .contains(search.toLowerCase()) ||
                                    element.id
                                        .toLowerCase()
                                        .contains(search.toLowerCase()))
                                .toList();
                          },
                          builder: (context, controller, focusNode) {
                            //wait for build to complete
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              controller.text =
                                  ref.watch(editPurchaseProvider).boughtByName;
                              //remove focus
                            });
                            return CustomTextFields(
                              label: 'Select User',
                              hintText: 'Search user',
                              controller: controller,
                              focusNode: focusNode,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select user';
                                }
                                return null;
                              },
                              onSaved: (value) {},
                            );
                          },
                          itemBuilder: (context, user) {
                            return ListTile(
                              leading: CircleAvatar(
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: ClipOval(
                                    child: ImageNetwork(
                                      image: user.image,
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(10),
                              title: Text(user.name),
                              subtitle: Text(user.id),
                            );
                          },
                          onSelected: (user) {
                            notifier.setBoughtBy(user);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TypeAheadField<CarModel>(
                          suggestionsCallback: (search) {
                            return ref
                                .watch(carsProvider)
                                .items
                                .where((element) =>
                                    element.registrationNumber
                                        .toLowerCase()
                                        .contains(search.toLowerCase()) ||
                                    element.model
                                        .toLowerCase()
                                        .contains(search.toLowerCase()))
                                .toList();
                          },
                          builder: (context, controller, focusNode) {
                            //wait for build to complete
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              controller.text =
                                  ref.watch(editPurchaseProvider).carId;
                              //remove focus
                            });
                            return CustomTextFields(
                              label: 'Select a car',
                              hintText: 'Search a car',
                              controller: controller,
                              focusNode: focusNode,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select car';
                                }
                                return null;
                              },
                              onSaved: (value) {},
                            );
                          },
                          itemBuilder: (context, user) {
                            return ListTile(
                              contentPadding: const EdgeInsets.all(10),
                              title: Text(user.registrationNumber),
                              subtitle: Text(user.model),
                            );
                          },
                          onSelected: (user) {
                            notifier.setCarNo(user.registrationNumber);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: CustomDropDown(
                              label: 'Fuel Type',
                              hintText: 'Fuel Type',
                              value: purchase!.fuelType.isEmpty
                                  ? null
                                  : purchase.fuelType,
                              validator: (fuel) {
                                if (fuel == null || fuel.isEmpty) {
                                  return 'Fuel Type is required';
                                }
                                return null;
                              },
                              items: fuelType
                                  .map((e) => DropdownMenuItem(
                                      value: e, child: Text(e)))
                                  .toList(),
                              onChanged: (value) {
                                notifier.setFuelType(value);
                              })),
                      const SizedBox(
                        width: 15,
                      ),
                      //upload receipt image
                      Expanded(
                        child: CustomTextFields(
                          hintText: 'Upload Receipt',
                          label: 'Upload Receipt',
                          isReadOnly: true,
                          controller: receiptController,
                          validator: (path) {
                            if (path == null || path.isEmpty) {
                              return 'Receipt is required';
                            }
                            return null;
                          },
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.upload_file),
                            onPressed: () {
                              _pickImage();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomButton(
                    text: 'Update Purchase',
                    radius: 10,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        if (ref
                            .watch(editPurchaseProvider)
                            .boughtById
                            .isEmpty) {
                          CustomDialogs.toast(
                              message: 'Please select driver',
                              type: DialogType.error);
                          return;
                        }
                        if (ref.watch(receiptImageProvider) == null) {
                          CustomDialogs.toast(
                              message: 'Please upload receipt image',
                              type: DialogType.error);
                          return;
                        }
                        if (ref.watch(editPurchaseProvider).carId.isEmpty) {
                          CustomDialogs.toast(
                              message: 'Please select Car',
                              type: DialogType.error);
                          return;
                        }
                        notifier.updatePurchase(ref: ref, context: context);
                      }
                    },
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  void _pickImage() async {
    ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      ref.read(receiptImageProvider.notifier).state =
          await pickedFile.readAsBytes();
      setState(() {
        receiptController.text = pickedFile.name;
      });
    }
  }
}
