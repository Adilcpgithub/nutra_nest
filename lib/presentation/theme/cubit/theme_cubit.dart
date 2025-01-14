import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void isDartMode() async {
    log('cheching Mode');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isdart = preferences.getBool('isDartMode') ?? false;
    if (isdart) {
      emit(ThemeMode.dark);
      log('dark');
    } else {
      emit(ThemeMode.light);
      log('light');
    }
  }

  void toggleTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
      preferences.setBool('isDartMode', true);
    } else {
      emit(ThemeMode.light);
      preferences.setBool('isDartMode', false);
    }
  }
}
