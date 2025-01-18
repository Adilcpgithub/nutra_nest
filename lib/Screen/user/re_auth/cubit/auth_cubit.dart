import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final UserStatus userStatus = UserStatus();
  Future<void> deleteUserAccount(String email, String password) async {
    emit(AuthLoading());
    log('loading ');
    //await Future.delayed(const Duration(milliseconds: 5000));

    try {
      log('sssssssss');
      if (_auth.currentUser != null) {
        log('checking auth ');
        AuthCredential credential = EmailAuthProvider.credential(
          email: email,
          password: password,
        );
        await _auth.currentUser!.reauthenticateWithCredential(credential);

        await _auth.currentUser!.delete();
      }
      emit(AuthSuccess());
      // await _firestore
      //     .collection('users')
      //     .doc(await userStatus.getUserId())
      //     .delete();
      // log('success');
      // //emit(AuthSuccess());
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.remove('user_id');
      // await prefs.setBool('is_logged_in', false);
    } catch (e) {
      log('faileeeeeeeeeeeeeeeeeeeeee $e');
      emit(AuthFailure(e.toString()));
      await Future.delayed(const Duration(milliseconds: 300));
      emit(AuthInitial());
      //return 'Failed to delete user account: $e';
      // print("Failed to delete user account: $e");
    }

    // return 'Verification failed try again';
  }
}
