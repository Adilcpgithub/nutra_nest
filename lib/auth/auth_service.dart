import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthResponse {
  final bool success;
  final String? errorMessage;

  AuthResponse({required this.success, this.errorMessage});
}

class AuthService {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserStatus userStatus = UserStatus();

//--------------------------------------------------------------
  Future<AuthResponse> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String phoneNumber,
    required String name,
  }) async {
    try {
      log('Creating user with email and password...');

      // Perform the email/password sign-up
      final UserCredential credential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      userStatus.saveUsersSession(credential.user!.uid);

      log(credential.toString());

      // Skip saving user data to Firestore and return a successful response
      log('User created successfully.');
      String userId = credential.user!.uid;
      storeDataToFirebase(
          email: email, userId: userId, phoneNumber: phoneNumber, name: name);
      // Save additional data to Firestore

      return AuthResponse(success: true); // Successful completion
    } on TimeoutException catch (_) {
      log('Operation timed out.');
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

  Future<void> storeDataToFirebase({
    required String email,
    required String userId,
    required String phoneNumber,
    required String name,
  }) async {
    await _firestore.collection('users').doc(userId).set({
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
    });
  }

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      // Fetch the user document from Firestore
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();

      // Check if the document exists and return the data
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>;
      } else {
        print('User not found in Firestore');
        return null;
      }
    } catch (e) {
      print('Error retrieving user data: $e');
      return null;
    }
  }

  //----------------------------------------
  Future<AuthResponse> logInUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Sign in with Firebase Authentication using email and password
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      log("Successfully signed in with email and password");

      userStatus.saveUsersSession(credential.user!.uid);

      return AuthResponse(success: true);
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      // Handle specific FirebaseAuth errors
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email format';
          break;
        case 'invalid-credential':
          errorMessage = 'something went worng ';
          break;
        default:
          errorMessage = 'Login failed: ${e.message}';
      }
      log('FirebaseAuthException occurred: $errorMessage');
      return AuthResponse(success: false, errorMessage: errorMessage);
    } catch (e) {
      // Handle any other unexpected errors
      log("Unexpected error during sign in: $e");
      return AuthResponse(
          success: false, errorMessage: 'An unexpected error occurred');
    }
  }

  Future<void> signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.setBool('is_logged_in', false);
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
  // Future<AuthResponse> createUserWithEmailAndPassword({
  //   required String email,
  //   required String password,
  //   required String phoneNumber,
  //   required String name,
  // }) async {
  //   try {
  //     log('Checking if phone number exists...');

  //     // Perform the Firestore query and await the result
  //     final querySnapshot = await _firestore
  //         .collection('users')
  //         .where('phoneNumber', isEqualTo: phoneNumber)
  //         .get(); // This will return a QuerySnapshot

  //     // Now you can access the `docs` property from the `QuerySnapshot`
  //     if (querySnapshot.docs.isNotEmpty) {
  //       log('Phone number already exists');
  //       return AuthResponse(
  //           success: false, errorMessage: 'Phone number already exists');
  //     }

  //     log('Creating user with email and password...');
  //     UserCredential userCredential = await _auth
  //         .createUserWithEmailAndPassword(email: email, password: password);

  //     log(userCredential.toString());

  //     log('Saving user data to Firestore...');
  //     // await _firestore.collection('users').doc(userCredential.user!.uid).set({
  //     //   'name': name,
  //     //   'email': email,
  //     //   'phoneNumber': phoneNumber,
  //     // }).timeout(const Duration(seconds: 30));

  //     log('User data saved successfully. Returning true.');
  //     return AuthResponse(success: true); // Successful completion
  //   } on TimeoutException catch (_) {
  //     log('Firestore operation timed out.');
  //     return AuthResponse(success: false, errorMessage: 'Operation timed out');
  //   } on FirebaseAuthException catch (e) {
  //     String errorMessage = switch (e.code) {
  //       'email-already-in-use' => 'Email already registered',
  //       'weak-password' => 'Password is too weak',
  //       'invalid-email' => 'Invalid email format',
  //       _ => 'Registration failed: ${e.message}'
  //     };
  //     return AuthResponse(success: false, errorMessage: errorMessage);
  //   } catch (e) {
  //     log('An error occurred during sign-up: $e');
  //     return AuthResponse(
  //         success: false, errorMessage: 'An unexpected error occurred');
  //   }
  // }

//------------------------------------------------------------
  // Future<AuthResponse> logInUserWithEmailAndPassword(
  //     {required String email,
  //     String? phoneNumber,
  //     required String password}) async {
  //   UserStatus userStatus = UserStatus();

  //   try {
  //     // final querysnapshot = await _firestore
  //     //     .collection('users')
  //     //     .where('phoneNumber', isEqualTo: phoneNumber)
  //     //     // .where('password', isEqualTo: password)
  //     //     .get();
  //     // if (querysnapshot.docs.isEmpty) {
  //     //   return AuthResponse(success: false,errorMessage:'Invalid phone number or password.' )
  //     //   throw Exception('Invalid phone number or password.');
  //     // }

  //     // final userData = querysnapshot.docs.first.data();
  //     // String newEmail = userData['email'];
  //     await _auth.signInWithEmailAndPassword(email: email, password: password);
  //     log("Signed in with phone number and password ");
  //     log('2');
  //     return AuthResponse(success: true);
  //   } on FirebaseAuthException catch (e) {
  //     String errorMessage = switch (e.code) {
  //       'email-already-in-use' => 'Email already registered',
  //       'weak-password' => 'Password is too weak',
  //       'invalid-email' => 'Invalid email format',
  //       _ => 'Registration failed: ${e.message}'
  //     };
  //     log('3');
  //     return AuthResponse(success: false, errorMessage: errorMessage);
  //   } catch (e) {
  //     log("Error during sign in: $e");
  //     log('4');
  //     return AuthResponse(
  //         success: false, errorMessage: 'something went wrong ');
  //   }
  // }
}

class UserStatus {
  Future<void> saveUsersSession(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userId);
    await prefs.setBool('is_logged_in', true);
  }

  Future<bool> isUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_logged_in') ?? false;
  }

  Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id') ?? '';
  }
}
