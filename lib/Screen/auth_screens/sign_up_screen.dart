import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutra_nest/Widgets/custom_textbutton.dart';
import 'package:nutra_nest/Widgets/textformfield.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/blocs/signUp/bloc/sign_up_bloc.dart';
import 'package:nutra_nest/screen/auth_screens/login_screen.dart';
import 'package:nutra_nest/screen/sign_success.dart';
import 'package:nutra_nest/utity/app_logo.dart';
import 'package:nutra_nest/utity/colors.dart';
import 'package:nutra_nest/utity/navigation.dart';
import 'package:nutra_nest/utity/scaffol_message.dart';
import '../../core/theme/app_theme.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String selectedCountryCode = '+91';
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    // double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: appTheme(context),
      body: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          final signUpBloc = context.read<SignUpBloc>();
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                    //  height: 10,
                    ),
                SizedBox(
                  height: deviceHeight / 3,
                  child: FadeInLeft(
                    child: Center(
                        child: Image.asset(
                      appLogo(context),
                      width: 300,
                    )),
                  ),
                ),
                SingleChildScrollView(
                  child: Form(
                    autovalidateMode: state.activateValidation
                        ? AutovalidateMode.onUserInteraction
                        : null,
                    key: _formKey,
                    child: Container(
                      decoration: BoxDecoration(
                        border: const Border(
                            top: BorderSide(
                                width: 5, color: CustomColors.green)),
                        color: isDark(context) ? Colors.black : Colors.white,
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
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: customTextTheme(context),
                                    fontSize: 34,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            //1///////////////////////
                            SizedBox(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: deviceHeight * 0.002),
                                child: CustomTextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Name';
                                    }
                                    return null;
                                  },
                                  controller: _nameController,
                                  onChanged: (name) =>
                                      signUpBloc.add(NameChanged(name)),
                                  labelText: ' Name  ',
                                ),
                              ),
                            ),
                            //2//////////////////
                            SizedBox(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: deviceHeight * 0.002),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Phone';
                                        }
                                        final mobileRegex =
                                            RegExp(r'^[0-9]{7,10}$');
                                        if (!mobileRegex.hasMatch(value)) {
                                          return 'Please enter a valid mobile number (7 to 10 digits)';
                                        }
                                        return null;
                                      },
                                      controller: _phoneController,
                                      labelText: 'Phone Number',
                                      keyboardType: TextInputType.number,
                                      onChanged: (phone) =>
                                          signUpBloc.add(PhoneChanged(phone)),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //3///////////////////
                            SizedBox(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: deviceHeight * 0.002),
                                child: CustomTextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Email';
                                    }
                                    final emailRegex =
                                        RegExp(r'^[^@]+@[^@]+\.[^@]+');
                                    if (!emailRegex.hasMatch(value)) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                  controller: _emailController,
                                  labelText: ' Email  ',
                                  onChanged: (email) =>
                                      signUpBloc.add(EmailChanged(email)),
                                ),
                              ),
                            ),
                            //4////////////////////////
                            SizedBox(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: deviceHeight * 0.002),
                                child: CustomTextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Password';
                                    }
                                    if (value.length < 6) {
                                      return 'Password must be 6 or more numbers';
                                    }
                                    return null;
                                  },
                                  controller: _passwordController,
                                  labelText: ' Password  ',
                                  onChanged: (password) =>
                                      signUpBloc.add(PasswordChanged(password)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: deviceHeight * 0.002),
                              child: CustomTextbutton(
                                buttomName: 'SIGN UP',
                                voidCallBack: () async {
                                  await _submittion(context);
                                },
                                color: isDark(context)
                                    ? CustomColors.black
                                    : CustomColors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton.icon(
                              onPressed: () async {
                                bool data = false;
                                log('calling form sign up');
                                AuthService authService = AuthService();
                                data = await authService.signInWithGoogle();

                                if (data) {
                                  if (context.mounted) {
                                    CustomNavigation.pushAndRemoveUntil(
                                        context, const SignSuccess());
                                  }
                                } else {
                                  if (context.mounted) {
                                    showUpdateNotification(
                                        icon: Icons.error,
                                        context: context,
                                        message: 'google auth',
                                        color: Colors.red);
                                  }
                                }
                              },
                              icon: Image.asset(
                                'assets/7123025_logo_google_g_icon.png',
                                height: 40,
                              ), // Google icon
                              label: Text(
                                'Sign up with Google',
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
                                    borderRadius: BorderRadius.circular(12)),
                                backgroundColor: appTheme(context),
                                minimumSize: const Size(double.infinity, 53),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: deviceHeight * 0.002),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: deviceHeight * 0.02),
                                    child: Text(
                                      'Already having an account?   ',
                                      style: TextStyle(
                                          color: customTextTheme(context),
                                          fontSize: 11),
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                          color: customTextTheme(context),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              const LoginScreen(),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            var curvedAnimation =
                                                CurvedAnimation(
                                              parent: animation,
                                              curve: Curves
                                                  .easeInOut, // Choose any curve here
                                            );

                                            return FadeTransition(
                                              opacity: curvedAnimation,
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'By continuing, you agree to Perfect match’s',
                                        style: TextStyle(
                                            color: customTextTheme(context),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        'Terms of Service, Privacy Policy',
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:
                                                customTextTheme(context),
                                            decorationThickness: 1.5,
                                            color: customTextTheme(context),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _submittion(BuildContext context) async {
    final signUpBloc = context.read<SignUpBloc>();
    signUpBloc.add(ActivateValidation());

    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Show loading dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          // ignore: deprecated_member_use
          builder: (_) => WillPopScope(
            onWillPop: () async => false, // Prevent back button dismissal
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );

        // Perform sign up
        final response = await authService.createUserWithEmailAndPassword(
          name: _nameController.text.trim(),
          phoneNumber: selectedCountryCode + _phoneController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Always close the dialog first
        if (context.mounted) {
          Navigator.of(context, rootNavigator: true).pop();
        }

        // Handle the response
        if (response.success) {
          _clearFormFields();

          // Navigate to success screen
          if (context.mounted) {
            CustomNavigation.pushAndRemoveUntil(context, const SignSuccess());
          }
        } else if (context.mounted) {
          // Show error message if registration failed
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.errorMessage ?? 'Registration failed'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        // Ensure to close the dialog in case of an error
        if (context.mounted) {
          Navigator.of(context, rootNavigator: true).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('An unexpected error occurred'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  void _clearFormFields() {
    _nameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _passwordController.text = ''; // Use this for password fields
  }
}
