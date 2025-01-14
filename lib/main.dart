import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutra_nest/Blocs/LoginBloc/bloc/login_bloc.dart';
import 'package:nutra_nest/Blocs/Splash/bloc/splash_bloc.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/blocs/LoginBloc/bloc/profil_bloc/bloc/profil_bloc.dart';
import 'package:nutra_nest/blocs/image_bloc/bloc/image_bloc.dart';
import 'package:nutra_nest/blocs/search_bloc/bloc/search_bloc_bloc.dart';
import 'package:nutra_nest/blocs/signUp/bloc/sign_up_bloc.dart';
import 'package:nutra_nest/features/product_details/presentation/bloc/cycle_list_bloc/bloc/cycle_list_bloc.dart';
import 'package:nutra_nest/presentation/network/cubit/network_cubit.dart';
import 'package:nutra_nest/presentation/theme/app_theme.dart';
import 'package:nutra_nest/presentation/theme/cubit/theme_cubit.dart';
import 'package:nutra_nest/screen/auth_screens/login_screen.dart';
import 'package:nutra_nest/screen/bottom_navigation/bottom_navigation_screen.dart';

void main() async {
  // await FirebaseAppCheck.instance.activate(
  // webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
  // androidProvider: AndroidProvider.debug,
  //  appleProvider: AppleProvider.appAttest,
  //);
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  // await FirebaseAppCheck.instance.activate(
  //   // webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
  //   androidProvider: AndroidProvider.debug,
  //   //  appleProvider: AppleProvider.appAttest,
  // );

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

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyApp> {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => SplashBloc()..add(StartAnimationEvent())),
          BlocProvider(create: (context) => LoginBloc()),
          BlocProvider(create: (context) => SignUpBloc()),
          BlocProvider(create: (context) => ProfilBloc()),
          BlocProvider(create: (context) => CycleBloc()),
          BlocProvider(create: (context) => SearchBlocBloc()),
          BlocProvider(create: (context) => ImageBloc()),
          BlocProvider(create: (context) => ThemeCubit()..isDartMode()),
          BlocProvider(create: (context) => NetworkCubit()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeMode,
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
                  // const SplashScreen()

                  // Dee(),
                  status ? const MyHomePage() : const LoginScreen(),
            );
          },
        ));
  }
}
//  BlocBuilder<ThemeCubit, ThemeMode>(
//           builder: (context, themeMode) {
//             return MaterialApp(
//               theme: ThemeData.light(),
//               darkTheme: ThemeData.dark(),
//               themeMode: themeMode,
//               debugShowCheckedModeBanner: false,
//               home: //SplashScreen()
//                   //SignSuccess(),
//                   // OtpVerificationScreen()
//                   //  OtpVerificationScreen()
//                   //  MyHomePage()
//                   // EditProfile(),
//                   // const AddAddress(),
//                   //SignUpScreen(),
//                   // const ManageAddress(),
//                   // const DeleteScreen()
//                   // const SplashScreen()

//                   // Dee(),
//                   status ? const MyHomePage() : const LoginScreen(),
//             );
//           },
//         ));