import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutra_nest/Blocs/Splash/bloc/splash_bloc.dart';
import 'package:nutra_nest/Screen/login_screen.dart';
import 'package:nutra_nest/Screen/sign_screen.dart';
import 'package:nutra_nest/Screen/splash_screen.dart';

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => SplashBloc()..add(StartAnimationEvent()))
        ],
        child: MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: const Color.fromARGB(255, 248, 255, 251),
          ),
          debugShowCheckedModeBanner: false,
          home: const SignScreen(),
          // const LoginScreen(),
        ));
  }
}
