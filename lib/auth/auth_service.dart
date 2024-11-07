import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthResponse {
  final bool success;
  final String? errorMessage;

  AuthResponse({required this.success, this.errorMessage});
}

class AuthService {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//--------------------------------------------------------------
  Future<AuthResponse> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String phoneNumber,
    required String name,
  }) async {
    try {
      log('Checking if phone number exists...');

      // Perform the Firestore query and await the result
      final querySnapshot = await _firestore
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get(); // This will return a QuerySnapshot

      // Now you can access the `docs` property from the `QuerySnapshot`
      if (querySnapshot.docs.isNotEmpty) {
        log('Phone number already exists');
        return AuthResponse(
            success: false, errorMessage: 'Phone number already exists');
      }

      log('Creating user with email and password...');
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential != null) {
        log(userCredential.toString());
      }

      log('Saving user data to Firestore...');
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
      }).timeout(const Duration(seconds: 30));

      log('User data saved successfully. Returning true.');
      return AuthResponse(success: true); // Successful completion
    } on TimeoutException catch (_) {
      log('Firestore operation timed out.');
      return AuthResponse(success: false, errorMessage: 'Operation timed out');
    } on FirebaseAuthException catch (e) {
      String errorMessage = switch (e.code) {
        'email-already-in-use' => 'Email already registered',
        'weak-password' => 'Password is too weak',
        'invalid-email' => 'Invalid email format',
        _ => 'Registration failed: ${e.message}'
      };
      return AuthResponse(success: false, errorMessage: errorMessage);
    } catch (e) {
      log('An error occurred during sign-up: $e');
      return AuthResponse(
          success: false, errorMessage: 'An unexpected error occurred');
    }
  }

//------------------------------------------------------------
  Future<bool> logInUserWithEmailAndPassword(
      {String? email, String? phoneNumber, required String password}) async {
    if (email != null && phoneNumber == null) {
      try {
        final cred = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        log("Signed in withemail and password ");
        return true;
      } catch (e) {
        log('something went wrong when login $e');
      }
    }
    if (email == null && phoneNumber != null) {
      try {
        final querysnapshot = await _firestore
            .collection('users')
            .where('phoneNumber', isEqualTo: phoneNumber)
            // .where('password', isEqualTo: password)
            .get();
        if (querysnapshot.docs.isEmpty) {
          throw Exception('Invalid phone number or password.');
        }

        final userData = querysnapshot.docs.first.data();
        String newEmail = userData['email'];
        await _auth.signInWithEmailAndPassword(
            email: newEmail, password: password);
        log("Signed in with phone number and password ");
        return true;
      } catch (e) {
        log("Error during sign in: $e");
      }
    }
    return false;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log('sign out success');
    }
  }
  //  String _verificationId = "";
  //---------------------------------------------------------------------------

  // // Method for sending OTP to the phone number
  // Future<void> sendOTP(
  //   String phoneNumber,
  //   // String name, String email, String password
  // ) async {
  //   await _auth.verifyPhoneNumber(
  //     phoneNumber: phoneNumber,
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       // Automatically signs in the user when verification is completed (rare)
  //       await _auth.signInWithCredential(credential);
  //       // Save user data if needed
  //       // await _saveUserData(_auth.currentUser, name, email, phoneNumber, password);
  //       log(' first step verification successfull with phone number');
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       log("Verification failed: ${e.message}");
  //       throw e; // Handle error
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       log("Verification code sent to $phoneNumber.");
  //       // Store verificationId to use it later in confirmOTP
  //       _verificationId = verificationId;
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       _verificationId = verificationId;
  //     },
  //   );
  // }

  // Future<void> _saveUserData(User? user, String name, String email,
  //     String phoneNumber, String password) async {
  //   if (user != null) {
  //     await _firestore.collection('users').doc(user.uid).set({
  //       'name': name,
  //       'email': email,
  //       'phoneNumber': phoneNumber,
  //       'password': password, // Avoid storing plain passwords in production
  //     });
  //   }
  // }

  // Future<void> confirmOTP(String smsCode, String name, String email,
  //     String phoneNumber, String password) async {
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //     verificationId: _verificationId,
  //     smsCode: smsCode,
  //   );

  //   UserCredential userCredential =
  //       await _auth.signInWithCredential(credential);
  //   log('mobile signup successfull');
  //   // Save the user data to Firestore
  //   await _saveUserData(
  //       userCredential.user, name, email, phoneNumber, password);
  // }
}
