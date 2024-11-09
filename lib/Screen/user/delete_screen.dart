import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/screen/auth_screens/login_screen.dart';
import 'package:nutra_nest/screen/user/edit_profile.dart';
import 'package:nutra_nest/widgets/small_text_buttom.dart';
import 'package:nutra_nest/widgets/textformfield.dart';

class DeleteScreen extends StatelessWidget {
  const DeleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 57,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const EditProfile(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var curvedAnimation = CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeInOut, // Choose any curve here
                            );

                            return FadeTransition(
                              opacity: curvedAnimation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
                        height: 39,
                        width: 39,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 26,
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(
                    width: 92.5,
                  ),
                  const Expanded(
                    child: Text(
                      'Delete Account',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 65,
              ),
              const Text(
                'Are you sure you want to delete your account?\n'
                '            This action cannot be undone.',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                '• All your personal information, order history, and saved items\n'
                '   will be permanently removed',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                '•You will no longer be able to access your account or any \n'
                'associated data.',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                'Are you sure you want to delete your account?\n'
                '            This action cannot be undone.',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: SmallTextbutton(
                        buttomName: 'DELETE ACCOUNT',
                        voidCallBack: () async {
                          _showDeleteAccountBottomSheet(context);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: SmallTextbutton(
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
                                  curve:
                                      Curves.easeInOut, // Choose any curve here
                                );

                                return FadeTransition(
                                  opacity: curvedAnimation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        buttomColor: Colors.white,
                        textColor: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showDeleteAccountBottomSheet(BuildContext context) {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  showModalBottomSheet(
    backgroundColor: Colors.black,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            const Text(
              'Delete Account',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 20),
            Flexible(
              child: CustomTextFormField(
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
            ),
            SizedBox(height: 10),
            Flexible(
              child: CustomTextFormField(
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
              ),
            ),
            SizedBox(height: 20),
            Flexible(
              child: SmallTextbutton(
                buttomName: 'DELETE',
                voidCallBack: () {
                  AuthService authService = AuthService();
                  authService.deleteUserAccount(
                      emailController.text, passwordController.text);
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const LoginScreen(), // Your destination page
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var curvedAnimation = CurvedAnimation(
                          parent: animation,
                          curve:
                              Curves.easeInOut, // Choose the curve you prefer
                        );
                        return FadeTransition(
                          opacity: curvedAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                buttomColor: const Color.fromARGB(255, 92, 90, 90),
                textColor: Colors.white,
              ),
            )
          ],
        ),
      );
    },
  );
}
