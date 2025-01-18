import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';
import 'package:nutra_nest/screen/auth_screens/login_screen.dart';
import 'package:nutra_nest/screen/user/edit_profile.dart';
import 'package:nutra_nest/screen/user/re_auth/cubit/auth_cubit.dart';
import 'package:nutra_nest/utity/colors.dart';
import 'package:nutra_nest/utity/navigation.dart';
import 'package:nutra_nest/widgets/icons_widget.dart';
import 'package:nutra_nest/widgets/small_text_buttom.dart';
import 'package:nutra_nest/widgets/textformfield.dart';

class DeleteScreen extends StatelessWidget {
  const DeleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: BlocListener<AuthCubit, AuthState>(
            listenWhen: (previous, current) {
              return current is AuthFailure || current is AuthSuccess;
            },
            listener: (context, state) {
              if (state is AuthFailure) {
                showUpdateNotification(
                    context: context,
                    message: 'Account deletion failed ',
                    color: Colors.red,
                    icon: Icons.error_outline);
              } else if (state is AuthSuccess) {
                showUpdateNotification(
                  context: context,
                  message: 'Account deleted  ',
                );
                CustomNavigation.pushAndRemoveUntil(
                    context, const LoginScreen());
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 57,
                ),
                Row(
                  children: [
                    CustomIcon(
                        onTap: () {
                          CustomNavigation.pushReplacement(
                              context, const EditProfile());
                        },
                        icon: Icons.arrow_back,
                        iconSize: 26),
                    const SizedBox(
                      width: 85.5,
                    ),
                    const Expanded(
                      child: Text(
                        'Delete Account',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: Colors.red),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 65,
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(46, 183, 28, 28),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Padding(
                    padding:
                        EdgeInsets.only(top: 15, right: 8, bottom: 15, left: 8),
                    child: Column(
                      children: [
                        Text(
                          ' Are you sure you want to delete your    \n  account?\n',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(181, 244, 67, 54)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'All your personal information, order history, and saved items '
                          'will be permanently removed',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(181, 244, 67, 54)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'You will no longer be able to access your account or any associated data.',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(181, 244, 67, 54)),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: SmallTextbutton(
                          textColor: customTextTheme(context),
                          width: 1.5,
                          buttomColor: appTheme(context),
                          buttomName: 'CANCEL',
                          voidCallBack: () {
                            Navigator.of(context).pop(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const EditProfile(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
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
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: SmallTextbutton(
                          width: 1.5,
                          buttomColor: appTheme(context),
                          buttomName: 'DELETE ACCOUNT',
                          textColor: customTextTheme(context),
                          voidCallBack: () async {
                            showModelDeletingRule(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showDeleteAccountBottomSheet(BuildContext rootContext) {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  showModalBottomSheet(
    context: rootContext,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: appTheme(context),
            border: const Border(
              top: BorderSide(width: 3, color: CustomColors.green),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    'Verify Account Deletion',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: customTextTheme(context),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Email';
                      }
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    controller: emailController,
                    labelText: ' Email',
                  ),
                  const SizedBox(height: 10),
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
                    controller: passwordController,
                    labelText: ' Password  ',
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const CircularProgressIndicator(
                          color: CustomColors.green,
                        );
                      } else if (state is AuthFailure) {
                        return const CircularProgressIndicator(
                          color: Colors.red,
                        );
                      } else {
                        return SmallTextbutton(
                          buttomName: 'Delete Account',
                          voidCallBack: () {
                            if (formKey.currentState?.validate() ?? false) {
                              context.read<AuthCubit>().deleteUserAccount(
                                  emailController.text.trim(),
                                  passwordController.text.trim());
                              Navigator.of(context).pop();
                            }
                          },
                          buttomColor: CustomColors.green,
                          textColor: Colors.white,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void showModelDeletingRule(BuildContext context) async {
  showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: deviceWidth(context) - deviceWidth(context) / 4,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: CustomColors.gray),
              color: Colors.black87,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 30),
                const Text(
                  'Verification!',
                  style: TextStyle(
                    decorationThickness: 0,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Flexible(
                  child: Text(
                    'Please confirm your identity by entering your email address and password to delete your account. ',
                    style: TextStyle(
                      decorationThickness: 0,
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: SmallTextbutton(
                          textColor: CustomColors.white,
                          buttomName: 'CANCEL',
                          fontweight: 16,
                          voidCallBack: () {
                            Navigator.of(context).pop(false);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: SmallTextbutton(
                          textColor: CustomColors.white,
                          buttomName: 'Next',
                          fontweight: 16,
                          voidCallBack: () async {
                            log('true pressed');
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).then((result) {
    if (result == true) {
      // Navigator.of(context).pop();
      showDeleteAccountBottomSheet(context);
    }
  });
}

void showUpdateNotification({
  required BuildContext context,
  required String message,
  Color? color = CustomColors.green,
  IconData icon = Icons.check_circle,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Text(
            message,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(30),
      duration: const Duration(seconds: 2),
    ),
  );
}
