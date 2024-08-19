import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuel_management/features/admin/dashboard/provider/drivers_provider.dart';
import 'package:fuel_management/router/router.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../core/functions/int_to_date.dart';
import '../../../../../../core/views/custom_button.dart';
import '../../../../../../core/views/custom_dialog.dart';
import '../../../../../../core/views/custom_drop_down.dart';
import '../../../../../../core/views/custom_input.dart';
import '../../../../../../router/router_items.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/styles.dart';
import '../provider/driver_new_edit_provider.dart';

class EditDriverForm extends ConsumerStatefulWidget {
  const EditDriverForm({super.key, required this.id});
  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditDriverFormState();
}

class _EditDriverFormState extends ConsumerState<EditDriverForm> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    var notifier = ref.read(editDriverProvider.notifier);
    var driver = ref
        .watch(driversProvider)
        .items
        .firstWhere((element) => element.id == widget.id);
    //wait for widget is build

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifier.setDriver(driver);
    });

     driver = ref.watch(editDriverProvider);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(22),
      alignment: Alignment.center,
      child: SizedBox(
        width: styles.width * 0.55,
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    MyRouter(context: context, ref: ref)
                        .navigateToRoute(RouterItem.driversRoute);
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
                        'Update Driver'.toUpperCase(),
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
                          hintText: 'Driver Id',
                          label: 'Driver Id',
                          initialValue: driver.id,
                          //isCapitalized: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Driver Id is required';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            notifier.setDriverId(value);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: CustomDropDown(
                          value: driver.gender,
                          label: 'Driver Gender',
                          items: ['Male', 'Female']
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          hintText: 'Driver Gender',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Driver gender is required';
                            }
                            return null;
                          },
                          onChanged: (type) {
                            notifier.setGender(type);
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
                        child: CustomTextFields(
                          label: 'Driver Name',
                          initialValue: driver.name,
                          hintText: 'Driver Name',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Driver Name is required';
                            }
                            return null;
                          },
                          onSaved: (name) {
                            notifier.setName(name);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: CustomTextFields(
                          hintText: 'Driver Phone',
                          initialValue: driver.phone,
                          isPhoneInput: true,
                          label: 'Driver Phone',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Driver Phone is required';
                            }
                            return null;
                          },
                          onSaved: (phone) {
                            notifier.setPhone(phone!);
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
                          child: CustomTextFields(
                              label: 'License Number',
                              hintText: 'License Number',
                              initialValue: driver.licenseNumber,
                              validator: (fuel) {
                                if (fuel == null || fuel.isEmpty) {
                                  return 'Driver License Number is required';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                notifier.setLicenseNumber(value);
                              })),
                      const SizedBox(
                        width: 10,
                      ),
                      //fuel capacity
                      Expanded(
                        child: CustomTextFields(
                          hintText: 'License Expiry Date',
                          label: 'License Expiry Date',
                          controller: TextEditingController(
                              text: ref
                                          .watch(editDriverProvider)
                                          .licenseExpiryDate !=
                                      0
                                  ? intToDate(ref
                                      .watch(editDriverProvider)
                                      .licenseExpiryDate)
                                  : ''),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'License Expiry Date is required';
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
                                  notifier.setLicenseExpire(
                                      value.millisecondsSinceEpoch);
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                      Expanded(
                        child: CustomTextFields(
                          hintText: 'Join Date',
                          label: 'Join Date',
                          controller: TextEditingController(
                              text:
                                  ref.watch(editDriverProvider).dateEmployed !=
                                          0
                                      ? intToDate(ref
                                          .watch(editDriverProvider)
                                          .dateEmployed)
                                      : ''),
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
                                  notifier.setDateEmployed(
                                      value.millisecondsSinceEpoch);
                                }
                              });
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'License Expiry Date is required';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            //notifier.setLicenseExpire(value);
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
                      Column(
                        children: [
                          if (driver.image.isNotEmpty &&
                              ref.watch(driverImageProvider) == null)
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ImageNetwork(
                                image: driver.image,
                                width: 100,
                                height: 100,
                              ),
                            ),
                          if (ref.watch(driverImageProvider) != null)
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  image: DecorationImage(
                                      image: MemoryImage(
                                          ref.watch(driverImageProvider)!),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        ref
                                            .read(driverImageProvider.notifier)
                                            .state = null;
                                      },
                                      icon: const Icon(Icons.delete)),
                                ],
                              ),
                            ),
                          if (ref.watch(driverImageProvider) == null)
                            TextButton(
                                onPressed: () {
                                  pickImage();
                                },
                                child: const Text('Upload Driver Image'))
                          else
                            TextButton(
                                onPressed: () {
                                  ref.read(driverImageProvider.notifier).state =
                                      null;
                                },
                                child: const Text(
                                  'Remove Image',
                                  style: TextStyle(color: Colors.red),
                                ))
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        children: [
                          if (driver.licenseImage.isNotEmpty &&
                              ref.watch(licenseImageProvider) == null)
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)),
                              child: ImageNetwork(
                                image: driver.licenseImage,
                                width: 100,
                                height: 100,
                              ),
                            ),
                          if (ref.watch(licenseImageProvider) != null)
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  image: DecorationImage(
                                      image: MemoryImage(
                                          ref.watch(licenseImageProvider)!),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          if (ref.watch(licenseImageProvider) == null)
                            TextButton(
                                onPressed: () {
                                  pickLicense();
                                },
                                child: const Text('Upload License Image'))
                          else
                            TextButton(
                                onPressed: () {
                                  ref
                                      .read(licenseImageProvider.notifier)
                                      .state = null;
                                },
                                child: const Text(
                                  'Remove Image',
                                  style: TextStyle(color: Colors.red),
                                ))
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomButton(
                    text: 'Update Driver',
                    radius: 10,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();                       
                          notifier.updateDriver(ref: ref, context: context);
                        
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

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      ref.read(driverImageProvider.notifier).state = await image.readAsBytes();
    }
  }

  void pickLicense() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      ref.read(licenseImageProvider.notifier).state = await image.readAsBytes();
    }
  }
}
