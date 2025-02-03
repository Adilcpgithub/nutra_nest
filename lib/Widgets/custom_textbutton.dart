import 'package:flutter/material.dart';
import 'package:nutra_nest/utity/colors.dart';

// ignore: must_be_immutable
class CustomTextbutton extends StatelessWidget {
  final String buttomName;
  final bool showButtonName;
  final VoidCallback voidCallBack;
  final Color color;
  Color? nameColor;
  CustomTextbutton({
    super.key,
    this.showButtonName = true,
    required this.buttomName,
    required this.voidCallBack,
    this.nameColor,
    this.color = CustomColors.black,
  });

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
          child: showButtonName
              ? Text(
                  buttomName,
                  style: TextStyle(
                      color: nameColor == null
                          ? Theme.of(context).textTheme.bodySmall!.color
                          : nameColor!,
                      fontSize: 18),
                )
              : const CircularProgressIndicator(
                  color: Colors.green,
                )),
    );
  }
}
