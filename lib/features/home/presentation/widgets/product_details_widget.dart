import 'package:flutter/material.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';

class ProductDetailsWidget {
  static rateProdcutButton(BuildContext context, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, top: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(width: 1, color: customTextTheme(context))),
          child: Text(
            textAlign: TextAlign.center,
            'Rate product',
            style: TextStyle(
                color: customTextTheme(context),
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
