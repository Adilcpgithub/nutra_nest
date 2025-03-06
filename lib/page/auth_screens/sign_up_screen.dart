import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutra_nest/Widgets/custom_textbutton.dart';
import 'package:nutra_nest/Widgets/textformfield.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/blocs/signUp/bloc/sign_up_bloc.dart';
import 'package:nutra_nest/page/auth_screens/login_screen.dart';
import 'package:nutra_nest/page/sign_success.dart';
import 'package:nutra_nest/page/user/privacy_policy_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    // double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: appTheme(context),
      body: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess || state is GoogleSignUpSuccess) {
            CustomNavigation.pushAndRemoveUntil(context, const SignSuccess());
            _clearFormFields();
            return;
          }
          if (state is SignUpFailed) {
            showUpdateNotification(
                context: context, message: 'SignUp failed', color: Colors.red);
            return;
          }
          if (state is GoogleSignUpFailed) {
            showUpdateNotification(
                context: context,
                message: state.errorMessage,
                color: Colors.red);
            return;
          }
        },
        child: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width:
                      deviceWidth(context) > 400 ? 600 : deviceWidth(context),
                  child: Column(
                    children: [
                      const SizedBox(
                          //  height: 10,
                          ),
                      SizedBox(
                        width: deviceWidth(context) > 400
                            ? 600
                            : deviceWidth(context),
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
                              color:
                                  isDark(context) ? Colors.black : Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 20),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomTextFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter Phone';
                                              }
                                              final mobileRegex =
                                                  RegExp(r'^[0-9]{7,10}$');
                                              if (!mobileRegex
                                                  .hasMatch(value)) {
                                                return 'Please enter a valid mobile number (7 to 10 digits)';
                                              }
                                              return null;
                                            },
                                            controller: _phoneController,
                                            labelText: 'Phone Number',
                                            keyboardType: TextInputType.number,
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
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),

                                  BlocBuilder<SignUpBloc, SignUpState>(
                                    builder: (context, state) {
                                      bool data = true;
                                      if (state is SignUpLoading) data = false;
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: deviceHeight * 0.002),
                                        child: CustomTextbutton(
                                          showButtonName: data,
                                          buttomName: 'SIGN UP',
                                          voidCallBack: () async {
                                            await _submittion(context);
                                          },
                                          color: isDark(context)
                                              ? CustomColors.black
                                              : CustomColors.white,
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  BlocBuilder<SignUpBloc, SignUpState>(
                                    builder: (context, state) {
                                      bool data = false;

                                      if (state is GoogleSignUpLoading) {
                                        data = true;
                                      }

                                      return ElevatedButton.icon(
                                        onPressed: () async {
                                          context
                                              .read<SignUpBloc>()
                                              .add(GoogleSignUp());
                                        },
                                        icon: data
                                            ? SizedBox(
                                                height: 25,
                                                width: 25,
                                                child:
                                                    CircularProgressIndicator(
                                                  color:
                                                      customTextTheme(context),
                                                ),
                                              )
                                            : Image.asset(
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
                                                  color:
                                                      customTextTheme(context)),
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
                                    padding: EdgeInsets.symmetric(
                                        vertical: deviceHeight * 0.002),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                pageBuilder: (context,
                                                        animation,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'By continuing, you agree to Perfect match’s',
                                              style: TextStyle(
                                                  color:
                                                      customTextTheme(context),
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                CustomNavigation.push(context,
                                                    PrivacyPolicyPage());
                                              },
                                              child: Text(
                                                'Terms of Service, Privacy Policy',
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    decorationColor:
                                                        customTextTheme(
                                                            context),
                                                    decorationThickness: 1.5,
                                                    color: customTextTheme(
                                                        context),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
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
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _submittion(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<SignUpBloc>().add(SubmitToSignUp(
          name: _nameController.text.trim(),
          phoneNumber: _phoneController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim()));
    }
  }

  void _clearFormFields() {
    _nameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _passwordController.text = '';
  }
}
