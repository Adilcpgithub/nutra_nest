import 'package:flutter/material.dart';
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
            SizedBox(
              height: 160,
            ),
            SizedBox(
              height: deviceHeight / 2,
              child: Center(
                child: Image.asset(
                  'assets/tick.png',
                  height: 90,
                ),
              ),
            ),
            Text(
              ' Successful!',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 27,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 120,
            ),
            CustomTextbutton(
                buttomName: 'START SHOPPING', voidCallBack: () async {}),
          ],
        ),
      ),
    );
  }
}