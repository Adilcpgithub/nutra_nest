import 'package:flutter/material.dart';

class CustomTextbutton extends StatelessWidget {
  final String buttomName;
  final VoidCallback voidCallBack;
  final Color color;
  const CustomTextbutton(
      {super.key,
      required this.buttomName,
      required this.voidCallBack,
      this.color = const Color.fromARGB(255, 92, 90, 90)});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 57, // Fixed height for button
      child: TextButton(
        style: TextButton.styleFrom(
          minimumSize: const Size(double.infinity, 57),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
          backgroundColor: color,
        ),
        onPressed: voidCallBack,
        child: Text(
          buttomName,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
