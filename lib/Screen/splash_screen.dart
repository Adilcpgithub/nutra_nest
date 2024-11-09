import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutra_nest/Blocs/Splash/bloc/splash_bloc.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/screen/auth_screens/login_screen.dart';
import 'package:nutra_nest/screen/bottom_navigation/bottom_navigation_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool status = false;
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) async {
        if (state.opacity == 1.0) {
          UserStatus userStatus = UserStatus();
          bool loggedInStatus = await userStatus.isUserLoggedIn();

          status = loggedInStatus;

          await Future.delayed(const Duration(milliseconds: 1500));

          if (status) {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    MyHomePage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  // For example, a fade transition
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          } else {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const LoginScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  // For example, a fade transition
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          }
          // ignore: use_build_context_synchronously
        }
      },
      child: Scaffold(body: Center(
        child: BlocBuilder<SplashBloc, SplashState>(builder: (builder, state) {
          return AnimatedContainer(
            transform: Matrix4.rotationZ(state.rotate),
            duration: const Duration(milliseconds: 1500),
            width: state.imageSize,
            height: state.imageSize,
            curve: Curves.easeInOut,
            alignment: Alignment.center,
            child: Opacity(
              opacity: state.opacity,
              child: Image.asset(
                'assets/NutraNestPo.png',
              ),
            ),
          );
        }),
      )),
    );
  }
}
