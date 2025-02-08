import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutra_nest/Blocs/LoginBloc/bloc/login_bloc.dart';
import 'package:nutra_nest/Widgets/custom_textbutton.dart';
import 'package:nutra_nest/Widgets/textformfield.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';
import 'package:nutra_nest/screen/auth_screens/sign_up_screen.dart';
import 'package:nutra_nest/screen/bottom_navigation/bottom_navigation_screen.dart';
import 'package:nutra_nest/utity/app_logo.dart';
import 'package:nutra_nest/utity/colors.dart';
import 'package:nutra_nest/utity/navigation.dart';
import 'package:nutra_nest/utity/scaffol_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailrController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: appTheme(context),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess || state is GoogleLoginSuccess) {
              CustomNavigation.pushAndRemoveUntil(context, const MyHomePage());
              _emailrController.clear();
              _passwordController.clear();
              return;
            }
            if (state is LoginFailed) {
              showUpdateNotification(
                  context: context, message: 'login failed', color: Colors.red);
              return;
            }
            if (state is GoogleLoginFailed) {
              showUpdateNotification(
                  context: context,
                  message: state.errorMessage,
                  color: Colors.red);
              return;
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: deviceHeight / 2,
                    child: FadeInLeft(
                      child: Center(
                          child: Image.asset(
                        appLogo(context),
                        width: 300,
                      )),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    autovalidateMode: state.activateValidation
                        ? AutovalidateMode.onUserInteraction
                        : null,
                    child: Container(
                      width: deviceWidth > 400 ? 600 : deviceWidth,
                      decoration: BoxDecoration(
                        border: const Border(
                            top: BorderSide(
                                width: 5, color: CustomColors.green)),
                        color: appTheme(context),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 5),
                              child: Flexible(
                                child: Text(
                                  'Log In',
                                  style: TextStyle(
                                      color: customTextTheme(context),
                                      fontSize: 34,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            ///////1
                            CustomTextFormField(
                              controller: _emailrController,
                              labelText: state.isEmailVisible
                                  ? ' Email'
                                  : 'Phone Number',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return state.isEmailVisible
                                      ? 'Please enter Email'
                                      : 'Please enter Number';
                                }
                                if (state.isEmailVisible) {
                                  final emailRegex =
                                      RegExp(r'^[^@]+@[^@]+\.[^@]+');
                                  if (!emailRegex.hasMatch(value)) {
                                    return 'Please enter a valid email address';
                                  }
                                }
                                if (!state.isEmailVisible) {
                                  final mobileRegex = RegExp(r'^[0-9]{7,10}$');
                                  if (!mobileRegex.hasMatch(value)) {
                                    return 'Please enter a valid mobile number (7 to 10 digits)';
                                  }
                                }

                                return null;
                              },
                              keyboardType: TextInputType.text,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),

                            CustomTextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be 6 or more numbers';
                                }
                                return null;
                              },
                              controller: _passwordController,
                              labelText: ' Password  ',
                            ),

                            GestureDetector(
                              onTap: () {
                                TextEditingController emailController =
                                    TextEditingController();
                                final emailformKey = GlobalKey<FormState>();

                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: const Color.fromARGB(
                                            0, 121, 50, 50),
                                        content: SingleChildScrollView(
                                          child: FadeInUp(
                                            child: SizedBox(
                                              width: deviceWidth / 2,
                                              child: Container(
                                                // width: deviceWidth / 2,
                                                // height: deviceHeight / 4,
                                                padding:
                                                    const EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 0.5,
                                                      color: CustomColors.gray),
                                                  color: Colors.black87,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: SizedBox(
                                                  //height: deviceHeight / 4,
                                                  width: deviceWidth / 2,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      const SizedBox(
                                                          height: 30),
                                                      const Text(
                                                        "Forgot Password ?",
                                                        style: TextStyle(
                                                          decorationThickness:
                                                              0,
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 30),
                                                      Form(
                                                        key: emailformKey,
                                                        child: TextFormField(
                                                          validator: (value) {
                                                            final emailRegex =
                                                                RegExp(
                                                                    r'^[^@]+@[^@]+\.[^@]+');
                                                            if (value!
                                                                .isNotEmpty) {
                                                              if (!emailRegex
                                                                  .hasMatch(
                                                                      value)) {
                                                                return 'Please enter a valid email address';
                                                              }
                                                            }
                                                            return null;
                                                          },
                                                          controller:
                                                              emailController,
                                                          decoration:
                                                              const InputDecoration(
                                                            labelText:
                                                                "Enter your email",
                                                            border: OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10),
                                                        child: TextButton(
                                                          style: TextButton
                                                              .styleFrom(
                                                            minimumSize:
                                                                const Size(
                                                                    double
                                                                        .infinity,
                                                                    50),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                                    side: const BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .white),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      10,
                                                                    )),
                                                          ),
                                                          onPressed: () async {
                                                            if (emailformKey
                                                                    .currentState
                                                                    ?.validate() ??
                                                                false) {
                                                              log('validation completed');
                                                              try {
                                                                AuthService
                                                                    authService =
                                                                    AuthService();

                                                                await authService
                                                                    .resetPassword(
                                                                        emailController
                                                                            .text
                                                                            .trim());
                                                                if (context
                                                                    .mounted) {
                                                                  showUpdateNotification(
                                                                      context:
                                                                          context,
                                                                      message:
                                                                          'Password reset link sent to your email!');
                                                                }
                                                              } catch (e) {
                                                                if (context
                                                                    .mounted) {
                                                                  showUpdateNotification(
                                                                      color: Colors
                                                                          .red,
                                                                      context:
                                                                          context,
                                                                      message:
                                                                          'something went wrong'
                                                                              .toString());
                                                                }
                                                              }

                                                              log('function fininshed');
                                                            } else {
                                                              log('validation failed');
                                                            }

                                                            if (context
                                                                .mounted) {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            }
                                                          },
                                                          child: const SizedBox(
                                                            height: 20,
                                                            child: Text(
                                                              "Reset Password",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: deviceHeight * 0.01,
                                    bottom: deviceHeight * 0.01),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Forgot Password ? ',
                                      style: TextStyle(
                                          color: customTextTheme(context),
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                bool data = true;
                                if (state is LoginLoading) data = false;

                                return CustomTextbutton(
                                  showButtonName: data,
                                  buttomName: 'LOG IN',
                                  voidCallBack: () async {
                                    data = false;
                                    await _submittion(context);
                                  },
                                  color: appTheme(context),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                bool data = false;

                                if (state is GoogleLoginLoading) {
                                  data = true;
                                }

                                return ElevatedButton.icon(
                                  onPressed: () async {
                                    context
                                        .read<LoginBloc>()
                                        .add(GoogleLogin());
                                  },
                                  icon: data
                                      ? const SizedBox(
                                          height: 25,
                                          width: 25,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : Image.asset(
                                          'assets/7123025_logo_google_g_icon.png',
                                          height: 40,
                                        ), // Google icon
                                  label: Text(
                                    'Sign in with Google',
                                    style: TextStyle(
                                      color: customTextTheme(context),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 1,
                                            color: customTextTheme(context)),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    backgroundColor: appTheme(context),
                                    minimumSize:
                                        const Size(double.infinity, 53),
                                  ),
                                );
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: deviceHeight * 0.019,
                                  bottom: deviceHeight * 0.019),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Don’t have an account?  ',
                                    style: TextStyle(
                                        color: customTextTheme(context),
                                        fontSize: 13),
                                  ),
                                  GestureDetector(
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          color: customTextTheme(context),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onTap: () {
                                      if (context.mounted) {
                                        CustomNavigation.push(
                                            context, SignUpScreen());
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              height: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _submittion(
    BuildContext context,
  ) async {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginBloc>().add(SubmitToLogin(
          _emailrController.text.trim(), _passwordController.text.trim()));
    }
  }
}
