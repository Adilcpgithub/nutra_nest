// import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';

// class AuthService {
//   final _auth = FirebaseAuth.instance;

//   Future<UserCredential?> createUserWithEmailAndPassword(
//       {required String email, required String password}) async {
//     try {
//       final cred = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       return cred;
//     } catch (_) {
//       log('somethinf went wrong');
//     }
//     return null;
//   }

//   Future<UserCredential?> logInUserWithEmailAndPassword(
//       {required String email, required String password}) async {
//     try {
//       final cred = await _auth.signInWithEmailAndPassword(
//           email: email, password: password);
//       return cred;
//     } catch (_) {
//       log('something went wrong');
//     }
//     return null;
//   }

//   Future<void> signOut() async {
//     try {
//       await _auth.signOut();
//     } catch (e) {
//       log('sign out success');
//     }
//   }
// }
