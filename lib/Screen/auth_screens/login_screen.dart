import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nutra_nest/Blocs/LoginBloc/bloc/login_bloc.dart';
import 'package:nutra_nest/Widgets/custom_textbutton.dart';
import 'package:nutra_nest/Widgets/textformfield.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/presentation/theme/app_theme.dart';
import 'package:nutra_nest/screen/auth_screens/sign_up_screen.dart';
import 'package:nutra_nest/screen/bottom_navigation/bottom_navigation_screen.dart';
import 'package:nutra_nest/utity/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailorPhoneNumberController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String selectedCountryCode = '+91';

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: deviceHeight / 2,
                  child: Center(
                    child: Image.asset(
                      'assets/NutraNestPo.png',
                      height: 180,
                    ),
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
                      border: Border.all(width: 2, color: CustomColors.green),
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
                            padding: EdgeInsets.only(top: 20, bottom: 5),
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
                            controller: _emailorPhoneNumberController,
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
                            keyboardType: state.isEmailVisible
                                ? TextInputType.text
                                : TextInputType.number,
                            prefixIcon: state.isEmailVisible
                                ? null
                                : Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CountryCodePicker(
                                          onChanged: (countryCode) {
                                            selectedCountryCode =
                                                countryCode.dialCode!;
                                            print(selectedCountryCode);
                                            context
                                                .read<LoginBloc>()
                                                .add(ToggleEmailVisibility());
                                          },
                                          initialSelection: 'IN',
                                          favorite: const ['+1', 'IN'],
                                          showFlag: false,
                                          showCountryOnly: false,
                                          showOnlyCountryWhenClosed: false,
                                          alignLeft: false,
                                          textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
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

                          Padding(
                            padding: EdgeInsets.only(
                                top: deviceHeight * 0.01,
                                bottom: deviceHeight * 0.01),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '      Forgot Password ? ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ],
                            ),
                          ),

                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              bool data = true;
                              return CustomTextbutton(
                                showButtonName: data,
                                buttomName: 'LOG IN',
                                voidCallBack: () async {
                                  data = false;
                                  await _submittion(
                                      context, state.isEmailVisible);
                                },
                                color: appTheme(context),
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
                                    Navigator.of(context).push(
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            SignUpScreen(),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          var curvedAnimation = CurvedAnimation(
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
                            padding:
                                EdgeInsets.only(bottom: deviceHeight * 0.012),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Login as',
                                  style: TextStyle(
                                      color: customTextTheme(context),
                                      fontSize: 12),
                                ),
                                GestureDetector(
                                  child: Text(
                                    ' Guest',
                                    style: TextStyle(
                                        color: customTextTheme(context),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 100,
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
    );
  }

  Future<void> _submittion(BuildContext context, bool isEmailVisible) async {
    context.read<LoginBloc>().add(ActivateValidation());

    AuthResponse response;
    if (_formKey.currentState?.validate() ?? false) {
      response = await authService.logInUserWithEmailAndPassword(
          email: _emailorPhoneNumberController.text.trim(),
          password: _passwordController.text.trim());

      if (response.success) {
        log('login  success');
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const MyHomePage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              );

              return FadeTransition(
                opacity: curvedAnimation,
                child: child,
              );
            },
          ),
        );

        _emailorPhoneNumberController.clear();
        _passwordController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.errorMessage ?? 'Registration failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
