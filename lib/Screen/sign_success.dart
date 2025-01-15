import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nutra_nest/presentation/theme/app_theme.dart';
import 'package:nutra_nest/screen/bottom_navigation/bottom_navigation_screen.dart';
import 'package:nutra_nest/utity/navigation.dart';
import 'package:nutra_nest/widgets/custom_textbutton.dart';

class SignSuccess extends StatelessWidget {
  const SignSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 160,
            ),
            SizedBox(
              height: deviceWidth(context) / 2,
              child: Center(
                  child: LottieBuilder.asset(
                      'assets/Animation - 1736831368600.json')),
            ),
            const Text(
              ' Successful!',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 27,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 120,
            ),
            CustomTextbutton(
                color: Colors.black,
                buttomName: 'START SHOPPING',
                voidCallBack: () async {
                  CustomNavigation.pushAndRemoveUntil(
                      context, const MyHomePage());
                }),
          ],
        ),
      ),
    );
  }
}
