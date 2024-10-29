import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutra_nest/Blocs/LoginBloc/bloc/login_bloc.dart';
import 'package:nutra_nest/Blocs/Splash/bloc/splash_bloc.dart';
import 'package:nutra_nest/blocs/signUp/bloc/sign_up_bloc.dart';
import 'package:nutra_nest/screen/login_screen.dart';
import 'package:nutra_nest/screen/sign_up_screen.dart';
import 'package:nutra_nest/screen/splash_screen.dart';

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
    print("Firebase initialization error: $e");
  }
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

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
              // SignUpScreen(),
              const LoginScreen(),
        ));
  }
}
