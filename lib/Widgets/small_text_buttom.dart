import 'package:flutter/material.dart';
import 'package:nutra_nest/utity/colors.dart';

class SmallTextbutton extends StatelessWidget {
  final String buttomName;
  final VoidCallback voidCallBack;
  final Color buttomColor;
  final Color textColor;
  final Color borderColor;
  final double width;
  final double fontweight;
  final bool? showcircleavatar;
  const SmallTextbutton(
      {super.key,
      this.borderColor = Colors.green,
      required this.buttomName,
      required this.voidCallBack,
      this.buttomColor = Colors.black,
      this.textColor = Colors.white,
      this.width = 0,
      this.fontweight = 12,
      this.showcircleavatar});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: buttomColor,
          border: Border.all(width: width, color: borderColor),
          borderRadius: BorderRadius.circular(9),
        ),
        height: 41,
        width: 150, // Fixed height for button
        child: showcircleavatar == true
            ? const SizedBox(
                height: 10,
                width: 10,
                child: Center(
                  child: CircularProgressIndicator(
                    color: CustomColors.green,
                  ),
                ),
              )
            : TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, 57),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: voidCallBack,
                child: Text(
                  buttomName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontweight,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ));
  }
}
