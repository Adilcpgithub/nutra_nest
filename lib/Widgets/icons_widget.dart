import 'package:flutter/material.dart';
import 'package:nutra_nest/utity/colors.dart';

// ignore: must_be_immutable
class CustomIcon extends StatelessWidget {
  final VoidCallback onTap;
  IconData? icon;
  double? iconSize;
  Widget? widget;
  CustomIcon(
      {super.key, required this.onTap, this.icon, this.iconSize, this.widget});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          // color: CustomColors.black,
          borderRadius: BorderRadius.circular(10),
          //  border: Border.all(color: CustomColors.green, width: 1.5),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10), // Match the border radius
          // ignore: deprecated_member_use
          splashColor: Colors.grey.withOpacity(0.3), // Splash effect
          // ignore: deprecated_member_use
          highlightColor: Colors.grey.withOpacity(0.1),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: CustomColors.green),
                // color: CustomColors.green,
                borderRadius: BorderRadius.circular(10)),
            height: 39,
            width: 39,
            child: icon != null
                ? Icon(
                    icon,
                    size: iconSize ?? 26,
                    color: Theme.of(context).textTheme.bodySmall!.color,
                  )
                : widget ?? const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
