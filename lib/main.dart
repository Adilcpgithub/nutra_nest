import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutra_nest/Blocs/LoginBloc/bloc/login_bloc.dart';
import 'package:nutra_nest/Blocs/Splash/bloc/splash_bloc.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/blocs/signUp/bloc/sign_up_bloc.dart';
import 'package:nutra_nest/screen/auth_screens/login_screen.dart';
import 'package:nutra_nest/screen/bottom_navigation/bottom_navigation_screen.dart';
import 'package:nutra_nest/screen/bottom_navigation/home_screen.dart';
import 'package:nutra_nest/screen/sign_success.dart';
import 'package:nutra_nest/screen/auth_screens/sign_up_screen.dart';
import 'package:nutra_nest/screen/splash_screen.dart';
import 'package:nutra_nest/screen/user/add_address.dart';
import 'package:nutra_nest/screen/user/delete_screen.dart';
import 'package:nutra_nest/screen/user/edit_profile.dart';
import 'package:nutra_nest/screen/user/manage_address.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyCPhgJ67PJp0-rEJPz82wFpAUVavdaV77M",
              authDomain: "nutranest-a6417.firebaseapp.com",
              projectId: "nutranest-a6417",
              storageBucket: "nutranest-a6417.appspot.com",
              messagingSenderId: "544605270040",
              appId: "1:544605270040:web:ebe8021bc66785c5fc536d",
              measurementId: "G-KEXM8FGNPN"));
    } else {
      await Firebase.initializeApp();
    }
  } catch (e) {
    // ignore: avoid_print
    print("Firebase initialization error: $e");
  }
  runApp(const MyWidget());
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool status = false;
  @override
  void initState() {
    log('intitstate calling ');
    super.initState();
    _checkUserStatus();
  }

  Future<void> _checkUserStatus() async {
    UserStatus userStatus = UserStatus();
    bool loggedInStatus = await userStatus.isUserLoggedIn();
    setState(() {
      status = loggedInStatus;
      print(status);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => SplashBloc()..add(StartAnimationEvent())),
          BlocProvider(create: (context) => LoginBloc()),
          BlocProvider(create: (context) => SignUpBloc())
        ],
        child: MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: const Color.fromARGB(255, 248, 255, 251),
          ),
          debugShowCheckedModeBanner: false,
          home: //SplashScreen()
              //SignSuccess(),
              // OtpVerificationScreen()
              //  OtpVerificationScreen()
              //  MyHomePage()
              // EditProfile(),
              // const AddAddress(),
              //SignUpScreen(),
              // const ManageAddress(),
              // const DeleteScreen()

              status ? MyHomePage() : const LoginScreen(),
        ));
  }
}
