import 'package:flutter/material.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';
import 'package:nutra_nest/utity/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Function(String)? onChanged;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final String? errorText;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText = '',
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.floatingLabelBehavior,
    this.errorText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextFormField(
          onChanged: onChanged,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          style: TextStyle(fontSize: 18, color: customTextTheme(context)),
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: labelText,

            labelStyle: TextStyle(
              fontSize: 18,
              color: Theme.of(context).textTheme.bodySmall!.color,
            ),
            hintText: hintText,
            prefixIcon: prefixIcon,

            errorText: errorText, // Show error text here
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(width: 1.5, color: CustomColors.green),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(width: 1.5, color: CustomColors.green),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(width: 1.5, color: CustomColors.green),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(width: 1.5, color: CustomColors.green),
              // Keep color same as enabled
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(width: 1.5, color: CustomColors.green),
            ),
          ),
          validator: validator,
        ),
      ),
    );
  }
}
