import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

//! conveting numbers into indias my format
NumberFormat formate() {
  return NumberFormat("#,##,##0");
}

closeKeyBord() async {
  await Future.delayed(const Duration(milliseconds: 300));
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}
