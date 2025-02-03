import 'package:flutter/material.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';

String appLogo(BuildContext context) {
  return isDark(context)
      ? 'assets/applogo_blacktheme.png'
      : 'assets/applogo_whitetheme.png';
}
