import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutra_nest/Blocs/Splash/bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 248, 255, 251),
        body: Center(
          child:
              BlocBuilder<SplashBloc, SplashState>(builder: (builder, state) {
            return AnimatedContainer(
              transform: Matrix4.rotationZ(state.rotate),
              duration: const Duration(milliseconds: 1800),
              width: state.imageSize,
              height: state.imageSize,
              curve: Curves.easeInOut,
              alignment: Alignment.center,
              child: Opacity(
                opacity: state.opacity,
                child: Image.asset(
                  'assets/NutraNest.png',
                ),
              ),
            );
          }),
        ));
  }
}
