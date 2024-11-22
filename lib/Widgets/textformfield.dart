import 'package:flutter/material.dart';

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
  final Color? borderColor;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.borderColor,
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
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: const TextStyle(fontSize: 18, color: Colors.white),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 18, color: Colors.grey),
          hintText: hintText,
          prefixIcon: prefixIcon,

          errorText: errorText, // Show error text here
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: borderColor ?? Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
                color:
                    borderColor ?? Colors.grey), // Keep color same as enabled
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
                color:
                    borderColor ?? Colors.grey), // Keep color same as enabled
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
                color:
                    borderColor ?? Colors.grey), // Keep color same as enabled
          ),
        ),
        validator: validator,
      ),
    );
  }
}
