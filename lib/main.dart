import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutra_nest/Blocs/LoginBloc/bloc/login_bloc.dart';
import 'package:nutra_nest/Blocs/SignUp/bloc/sign_up_bloc.dart';
import 'package:nutra_nest/Blocs/Splash/bloc/splash_bloc.dart';
import 'package:nutra_nest/screen/sign_up_screen.dart';
import 'package:nutra_nest/screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
              SignUpScreen(),
          //const LoginScreen(),
        ));
  }
}
