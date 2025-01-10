import 'package:flutter/material.dart';
import 'package:nutra_nest/screen/bottom_navigation/bottom_navigation_screen.dart';
import 'package:nutra_nest/utity/navigation.dart';
import 'package:nutra_nest/widgets/custom_textbutton.dart';

class SignSuccess extends StatelessWidget {
  const SignSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

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
              height: deviceHeight / 2,
              child: Center(
                child: Image.asset(
                  'assets/image copy 19.png',
                  height: 90,
                ),
              ),
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
