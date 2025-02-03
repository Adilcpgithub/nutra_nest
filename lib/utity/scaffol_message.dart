import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nutra_nest/utity/colors.dart';

void showUpdateNotification({
  required BuildContext context,
  required String message,
  Color? color = CustomColors.green,
  IconData icon = Icons.check_circle,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(icon, color: CustomColors.white),
          const SizedBox(width: 12),
          Text(
            message,
            style: GoogleFonts.poppins(
              color: CustomColors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(30),
      duration: const Duration(seconds: 2),
    ),
  );
}
