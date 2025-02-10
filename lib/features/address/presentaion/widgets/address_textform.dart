import 'package:flutter/material.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';
import 'package:nutra_nest/utity/colors.dart';

class AddressTextform extends StatelessWidget {
  final String headline;
  int? maxLength;
  TextInputType? keyboardType;
  final String? Function(String?) validator;
  TextEditingController controller = TextEditingController();
  AddressTextform(
      {super.key,
      required this.headline,
      required this.validator,
      required this.controller,
      this.keyboardType,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Text(
          headline,
          style: TextStyle(color: customTextTheme(context), fontSize: 14),
        ),
      ),
      TextFormField(
          keyboardType: keyboardType,
          maxLines: maxLength,
          controller: controller,
          style: TextStyle(color: customTextTheme(context), fontSize: 13),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            hintText: 'Type here',
            labelStyle:
                TextStyle(color: customTextTheme(context), fontSize: 13),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: CustomColors.green, // Default border color
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: CustomColors.green, // Border color when focused
                width: 1.5, // Thicker when focused
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.red, // Border color when validation fails
                width: 2.0,
              ),
            ),
          ),
          validator: validator),
      const SizedBox(
        height: 5,
      )
    ]);
  }
}
