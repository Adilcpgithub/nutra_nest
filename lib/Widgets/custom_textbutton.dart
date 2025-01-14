import 'package:flutter/material.dart';
import 'package:nutra_nest/utity/colors.dart';

class CustomTextbutton extends StatelessWidget {
  final String buttomName;
  final VoidCallback voidCallBack;
  final Color color;
  const CustomTextbutton(
      {super.key,
      required this.buttomName,
      required this.voidCallBack,
      this.color = CustomColors.black});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 57, // Fixed height for button
      child: TextButton(
        style: TextButton.styleFrom(
          minimumSize: const Size(double.infinity, 57),
          shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2, color: CustomColors.green),
              borderRadius: BorderRadius.circular(
                15,
              )),
          backgroundColor: color,
        ),
        onPressed: voidCallBack,
        child: Text(
          buttomName,
          style: TextStyle(
              color: Theme.of(context).textTheme.bodySmall!.color,
              fontSize: 18),
        ),
      ),
    );
  }
}
