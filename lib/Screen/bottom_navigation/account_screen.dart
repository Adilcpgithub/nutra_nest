import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/screen/auth_screens/login_screen.dart';
import 'package:nutra_nest/screen/user/edit_profile.dart';
import 'package:nutra_nest/screen/user/manage_address.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    UserStatus userStatus = UserStatus();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 41,
              ),
              Row(
                children: [
                  Container(
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
                  const SizedBox(
                    width: 70,
                  ),
                  const Expanded(
                    child: Text(
                      'Hey! Nutra-Nest',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 17,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await authService.signOut();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => LoginScreen()),
                              (Route<dynamic> route) => false);
                        },
                        child: Container(
                            height: 41,
                            width: 41,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Image.asset(
                                'assets/image copy 6.png',
                                width: 20.0,
                              ),
                            )),
                      ),
                      const Text(
                        'Logout',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
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
                    decoration: BoxDecoration(
                        color: const Color(0xFFAFB5BB),
                        borderRadius: BorderRadius.circular(10)),
                    width: double.maxFinite,
                    height: 60,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 19,
                        ),
                        Image.asset(
                          'assets/image.png',
                          height: 25,
                        ),
                        const SizedBox(
                            width: 59), // Space between icon and text
                        const Expanded(
                          child: Text(
                            'Edit Profile', // Example with longer text
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                            overflow: TextOverflow
                                .ellipsis, // Ellipsis if text is too long
                          ),
                        ),
                        const SizedBox(
                            width: 16), // Space between text and arrow
                        Image.asset(
                          'assets/image copy 2.png',
                          height: 13,
                        ),
                        const SizedBox(
                          width: 22,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const ManageAddress(),
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
                    decoration: BoxDecoration(
                        color: const Color(0xFFAFB5BB),
                        borderRadius: BorderRadius.circular(10)),
                    width: double.maxFinite,
                    height: 60,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 19,
                        ),
                        Image.asset(
                          'assets/image copy.png',
                          height: 24,
                        ),
                        const SizedBox(
                            width: 59), // Space between icon and text
                        const Expanded(
                          child: Text(
                            'Update Address', // Example with longer text
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                            overflow: TextOverflow
                                .ellipsis, // Ellipsis if text is too long
                          ),
                        ),
                        const SizedBox(
                            width: 16), // Space between text and arrow
                        Image.asset(
                          'assets/image copy 2.png',
                          height: 13,
                        ),
                        const SizedBox(
                          width: 22,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFAFB5BB),
                      borderRadius: BorderRadius.circular(10)),
                  width: double.maxFinite,
                  height: 60,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 19,
                      ),
                      Image.asset(
                        'assets/image copy 3.png',
                        height: 21,
                      ),
                      const SizedBox(width: 59), // Space between icon and text
                      const Expanded(
                        child: Text(
                          'Purchase History', // Example with longer text
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                          overflow: TextOverflow
                              .ellipsis, // Ellipsis if text is too long
                        ),
                      ),
                      const SizedBox(width: 16), // Space between text and arrow
                      Image.asset(
                        'assets/image copy 2.png',
                        height: 13,
                      ),
                      const SizedBox(
                        width: 22,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFAFB5BB),
                      borderRadius: BorderRadius.circular(10)),
                  width: double.maxFinite,
                  height: 60,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 19,
                      ),
                      Image.asset(
                        'assets/image copy 4.png',
                        height: 21,
                      ),
                      const SizedBox(width: 59), // Space between icon and text
                      const Expanded(
                        child: Text(
                          'Frequently Asked Questions', // Example with longer text
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                          overflow: TextOverflow
                              .ellipsis, // Ellipsis if text is too long
                        ),
                      ),
                      const SizedBox(width: 16), // Space between text and arrow
                      Image.asset(
                        'assets/image copy 2.png',
                        height: 13,
                      ),
                      const SizedBox(
                        width: 22,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFAFB5BB),
                      borderRadius: BorderRadius.circular(10)),
                  width: double.maxFinite,
                  height: 60,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 19,
                      ),
                      Image.asset(
                        'assets/image copy 5.png',
                        height: 21,
                      ),
                      const SizedBox(width: 59), // Space between icon and text
                      const Expanded(
                        child: Text(
                          'Help and Support', // Example with longer text
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                          overflow: TextOverflow
                              .ellipsis, // Ellipsis if text is too long
                        ),
                      ),
                      const SizedBox(width: 16), // Space between text and arrow
                      Image.asset(
                        'assets/image copy 2.png',
                        height: 13,
                      ),
                      const SizedBox(
                        width: 22,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
