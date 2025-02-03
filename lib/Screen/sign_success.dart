import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';
import 'package:nutra_nest/screen/bottom_navigation/bottom_navigation_screen.dart';
import 'package:nutra_nest/utity/colors.dart';
import 'package:nutra_nest/utity/navigation.dart';
import 'package:nutra_nest/widgets/custom_textbutton.dart';

class SignSuccess extends StatelessWidget {
  const SignSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Stack(children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: deviceWidth(context) / 2,
                  child: Center(
                      child: LottieBuilder.asset(
                          'assets/Animation - 1736831368600.json')),
                ),
                Text(
                  ' Successful!',
                  style: TextStyle(
                      color: customTextTheme(context),
                      fontSize: 27,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 120,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 55,
            left: 5,
            right: 5,
            child: CustomTextbutton(
                color: CustomColors.green,
                buttomName: 'START SHOPPING',
                nameColor: customTextTheme(context),
                voidCallBack: () async {
                  CustomNavigation.pushAndRemoveUntil(
                      context, const MyHomePage());
                }),
          )
        ]),
      ),
    );
  }
}
