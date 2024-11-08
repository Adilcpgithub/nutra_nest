import 'package:flutter/material.dart';

class SmallTextbutton extends StatelessWidget {
  final String buttomName;
  final VoidCallback voidCallBack;
  final Color buttomColor;
  final Color textColor;
  const SmallTextbutton(
      {super.key,
      required this.buttomName,
      required this.voidCallBack,
      this.buttomColor = Colors.black,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1.4),
      decoration: BoxDecoration(
        color: buttomColor,
        border: Border.all(width: 1.4),
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
          style: TextStyle(
              color: textColor,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1),
        ),
      ),
    );
  }
}
