import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutra_nest/Blocs/Splash/bloc/splash_bloc.dart';
import 'package:nutra_nest/Screen/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) async {
        if (state.opacity == 1.0) {
          await Future.delayed(const Duration(milliseconds: 1500));
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (Route<dynamic> rout) => false);
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
