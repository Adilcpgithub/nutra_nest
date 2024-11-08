import 'package:flutter/material.dart';

Widget modelTextFormFeild({required TextEditingController countroller}) {
  return TextFormField(
      controller: countroller,
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(132, 158, 158, 158),
        filled: true,
        hintText: "Type here",
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(width: 2, color: Colors.black),

          // Remove border for clean look
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(),
        ),
      ));
}
