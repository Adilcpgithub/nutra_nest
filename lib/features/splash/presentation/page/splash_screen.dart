import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';
import 'package:nutra_nest/features/splash/presentation/blocs/Splash/bloc/splash_bloc.dart';
import 'package:nutra_nest/page/auth_screens/login_screen.dart';
import 'package:nutra_nest/page/bottom_navigation/bottom_navigation_screen.dart';
import 'package:nutra_nest/utity/app_logo.dart';
import 'package:nutra_nest/utity/navigation.dart';

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
            if (context.mounted) {
              CustomNavigation.pushAndRemoveUntil(context, MyHomePage());
            }
          } else {
            if (context.mounted) {
              CustomNavigation.pushAndRemoveUntil(context, LoginScreen());
            }
          }
        }
      },
      child: Stack(children: [
        Scaffold(
            backgroundColor: appTheme(context),
            body: Center(
              child: BlocBuilder<SplashBloc, SplashState>(
                  builder: (builder, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 1300),
                        width: state.imageSize,
                        height: state.imageSize,
                        curve: Curves.easeInOut,
                        alignment: Alignment.center,
                        child: Opacity(
                          opacity: state.opacity,
                          child: FadeInLeft(
                            child: Image.asset(
                              appLogo(context),
                              height: deviceHeight(context) / 3,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ],
                );
              }),
            )),
        Positioned(
            bottom: deviceHeight(context) / 2 - 90,
            left: deviceWidth(context) / 2 - 65,
            child: FadeInUp(
              delay: const Duration(seconds: 1),
              child: Text(
                'Rider Spot',
                style: TextStyle(
                    color: customTextTheme(context),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decorationThickness: 0),
              ),
            ))
      ]),
    );
  }
}
