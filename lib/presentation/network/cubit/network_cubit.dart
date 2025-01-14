import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkCubit extends Cubit<bool> {
  final Connectivity _connectivity = Connectivity();
  NetworkCubit() : super(true) {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      log(result.toString());
      emit(_hasInternet(result));
    });
  }

  bool _hasInternet(ConnectivityResult result) {
    return result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi;
  }
}
