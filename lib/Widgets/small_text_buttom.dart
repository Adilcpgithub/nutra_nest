import 'package:flutter/material.dart';

class SmallTextbutton extends StatelessWidget {
  final String buttomName;
  final VoidCallback voidCallBack;
  final Color buttomColor;
  final Color textColor;
  final Color borderColor;
  final double width;
  final double fontweight;
  const SmallTextbutton(
      {super.key,
      this.borderColor = Colors.green,
      required this.buttomName,
      required this.voidCallBack,
      this.buttomColor = Colors.black,
      this.textColor = Colors.white,
      this.width = 0,
      this.fontweight = 12});

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
      child: TextButton(
        style: TextButton.styleFrom(
          minimumSize: const Size(double.infinity, 57),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
      ),
    );
  }
}
