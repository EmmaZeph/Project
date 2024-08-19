import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuel_management/core/functions/int_to_date.dart';
import 'package:fuel_management/core/functions/navigation.dart';
import 'package:fuel_management/core/views/custom_dialog.dart';
import 'package:fuel_management/features/admin/dashboard/provider/assignment_provider.dart';
import 'package:fuel_management/features/driver/auth/provider/driver_login_provider.dart';
import 'package:fuel_management/features/driver/pages/end_trip_page.dart';
import 'package:fuel_management/generated/assets.dart';
import 'package:fuel_management/utils/colors.dart';
import '../../../utils/styles.dart';

class DriverHome extends ConsumerStatefulWidget {
  const DriverHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DriverHomeState();
}

class _DriverHomeState extends ConsumerState<DriverHome> {
  @override
  Widget build(BuildContext context) {
    var style = Styles(context);
    var driver = ref.watch(driverProvider);
    var assignments = ref
        .watch(assignmentsProvider)
        .items
        .where((element) => element.driverId == driver!.id)
        .toList();
    var pendingOrOnTrip = assignments
        .where((element) =>
            element.status == 'pending' || element.status == 'on trip')
        .toList()
        .firstOrNull;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
                title: Text(
                  'Current Trip',
                  style: style.title(color: primaryColor),
                ),
                subtitle: pendingOrOnTrip == null
                    ? Text(
                        'No trip yet',
                        style: style.body(),
                      )
                    : Container(
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
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.location_on,
                                              color: Colors.white),
                                          const SizedBox(width: 10),
                                          Text(
                                            pendingOrOnTrip.route,
                                            style:
                                                style.body(color: Colors.white),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Icon(Icons.date_range,
                                              color: Colors.white),
                                          const SizedBox(width: 10),
                                          Text(
                                            'Pickup: ${intToDate(pendingOrOnTrip.pickupTime)}',
                                            style:
                                                style.body(color: Colors.white),
                                          )
                                        ],
                                      ),
                                      //car number
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.numbers,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            pendingOrOnTrip
                                                .car['registrationNumber'],
                                            style:
                                                style.body(color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      Assets.imagesLogoWhite,
                                      width: 80,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    //status
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 2),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(2)),
                                        child: Text(pendingOrOnTrip.status))
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            if (pendingOrOnTrip.status == 'on trip')
                              TextButton(
                                  style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 40,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      backgroundColor: Colors.white,
                                      foregroundColor: primaryColor),
                                  onPressed: () {
                                    ref.read(selectedAssignmentProvider.notifier).setAssignment(pendingOrOnTrip);
                                    navigateTransparentRoute(context, EndTripPage(assignment: pendingOrOnTrip,));
                                  },
                                  child: Text(
                                    'Complete Trip',
                                    style: style.subtitle(color: primaryColor),
                                  )),
                            if (pendingOrOnTrip.status == 'pending')
                              TextButton(
                                  style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 40,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      backgroundColor: Colors.white,
                                      foregroundColor: primaryColor),
                                  onPressed: () {
                                   CustomDialogs.showDialog(message: 'Are you sure you want to start trip?',
                                   secondBtnText: 'Start',
                                    onConfirm: () async {
                                      ref
                                              .read(
                                                  assignmentsProvider.notifier)
                                              .updateTrip(
                                                  pendingOrOnTrip.copyWith(
                                                status: 'on trip',
                                              ));
                                    });
                                  },
                                  child: Text(
                                    'Start Trip',
                                    style: style.subtitle(color: primaryColor),
                                  ))
                          ],
                        ),
                      )),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: style.width,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      image: AssetImage(Assets.imagesHome), fit: BoxFit.fill)),
              child: const Center(
                child: Text(''),
              ),
            )
          ],
        ),
      ),
    );
  }
}
