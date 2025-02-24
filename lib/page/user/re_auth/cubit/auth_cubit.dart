import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutra_nest/auth/auth_service.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
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
        await deleteUserData(_auth.currentUser!.uid);
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

  deleteUserData(String userId) async {
    try {
      await firestore.collection('users').doc(userId).delete();
      await firestore.collection('favoriteCollection').doc(userId).delete();
      await firestore.collection('cartCollection').doc(userId).delete();
    } catch (e) {
      log(e.toString());
    }
  }
}
