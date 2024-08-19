import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuel_management/core/views/custom_input.dart';
import 'package:fuel_management/generated/assets.dart';
import 'package:fuel_management/utils/colors.dart';
import 'package:fuel_management/utils/styles.dart';

class DriverLogin extends ConsumerStatefulWidget {
  const DriverLogin({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<DriverLogin> {
  final 
  @override
  Widget build(BuildContext context) {
    var style = Styles(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   backgroundColor: primaryColor,
        //   elevation: 0,
        //   title: Image.asset(
        //     Assets.imagesLogoWhite,
        //     height: 50,
        //   ),
        // ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    Assets.imagesLogin,
                    width: style.width * .6,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  'Driver Login'.toUpperCase(),
                  style: style.title(color: primaryColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: secondaryColor,
                  indent: 15,
                  endIndent: 15,
                  thickness: 2,
                ),
                const SizedBox(
                  height: 22,
                ),
                CustomTextFields(
                  label: 'Driver Id',
                  hintText: 'Enter Driver Id',
                  prefixIcon: Icons.person,
                  onSaved: (id) {},
                  validator: (id) {
                    if (id == null || id.isEmpty) {
                      return 'Driver id is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 22,
                ),
                CustomTextFields(
                    label: 'Driver Password',
                    hintText: 'Enter Password',
                    prefixIcon: Icons.lock,
                    obscureText: ,
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
