import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/screen/auth_screens/login_screen.dart';
import 'package:nutra_nest/screen/user/edit_profile.dart';
import 'package:nutra_nest/screen/user/manage_address.dart';
import 'package:nutra_nest/utity/colors.dart';
import 'package:nutra_nest/utity/navigation.dart';
import 'package:nutra_nest/widgets/icons_widget.dart';
import 'package:nutra_nest/widgets/small_text_buttom.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildhead(context),
                const SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
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
                      decoration: BoxDecoration(
                          color: Colors.white,
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
                      CustomNavigation.push(context, const ManageAddress());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
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
                        color: Colors.white,
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
                        const SizedBox(
                            width: 59), // Space between icon and text
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
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
                        const SizedBox(
                            width: 59), // Space between icon and text
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
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
                        const SizedBox(
                            width: 59), // Space between icon and text
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildhead(BuildContext context) {
  AuthService authService = AuthService();

  UserStatus userStatus = UserStatus();
  return Column(
    children: [
      Row(
        children: [
          const SizedBox(
            width: 90,
          ),
          const Expanded(
            child: Text(
              'Hey! Nutra-Nest',
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 17,
              ),
              CustomIcon(
                onTap: () {
                  customShowDialog(context);
                },
                widget: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Image.asset(
                    'assets/image copy 6.png',
                    width: 20.0,
                  ),
                ),
              ),
              const Text(
                'Log out',
                style: TextStyle(
                    color: CustomColors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ],
      ),
    ],
  );
}

customShowDialog(BuildContext context) {
  AuthService authService = AuthService();
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 30),
                Text(
                  'Are You Sure ?',
                  style: GoogleFonts.radioCanada(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: SmallTextbutton(
                          buttomColor: CustomColors.green,
                          textColor: CustomColors.white,
                          buttomName: 'LOG OUT',
                          voidCallBack: () async {
                            await authService.signOut();

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => const LoginScreen()),
                                (Route<dynamic> route) => false);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: SmallTextbutton(
                          buttomColor: CustomColors.black,
                          textColor: CustomColors.green,
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
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
