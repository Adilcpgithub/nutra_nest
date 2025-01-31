import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/core/network/cubit/network_cubit.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';
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
      backgroundColor: appTheme(context),
      body: SafeArea(
        child: BlocBuilder<NetworkCubit, bool>(
          builder: (context, isConnected) {
            if (isConnected) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildhead(context),
                      const SizedBox(
                        height: 70,
                      ),
                      buildNameContainer(
                        context: context,
                        containerName: 'Edit Profile',
                        iconImage: 'assets/image.png',
                        function: () {
                          Navigator.of(context).push(
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
                          CustomNavigation.push(context, const EditProfile());
                        },
                      ),
                      buildNameContainer(
                        context: context,
                        containerName: 'Update Address',
                        iconImage: 'assets/image copy.png',
                        function: () {
                          CustomNavigation.push(context, const ManageAddress());
                        },
                      ),
                      buildNameContainer(
                        context: context,
                        containerName: 'Purchase History',
                        iconImage: 'assets/image copy 3.png',
                        function: () {},
                      ),
                      // buildNameContainer(
                      //   context: context,
                      //   containerName: 'Frequently Asked Questions',
                      //   iconImage: 'assets/image copy 4.png',
                      //   function: () {},
                      // ),
                      buildNameContainer(
                        context: context,
                        containerName: 'Help and Support',
                        iconImage: 'assets/image copy 5.png',
                        function: () {},
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/Animation - 1736755470091.json',
                      height: 110),
                  Text(
                    'No internet connection!',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodySmall!.color,
                    ),
                  )
                ],
              ));
            }
          },
        ),
      ),
    );
  }
}

Widget buildNameContainer(
    {required VoidCallback function,
    required BuildContext context,
    required String iconImage,
    required String containerName}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: GestureDetector(
      onTap: function,
      child: Container(
        decoration: BoxDecoration(
            color:
                isDark(context) ? CustomColors.white : CustomColors.lightWhite,
            borderRadius: BorderRadius.circular(10)),
        width: double.maxFinite,
        height: 60,
        child: Row(
          children: [
            const SizedBox(
              width: 19,
            ),
            Image.asset(
              iconImage,
              height: 21,
            ),
            const SizedBox(width: 59), // Space between icon and text
            Expanded(
              child: Text(
                containerName, // Example with longer text
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: CustomColors.black),
                overflow: TextOverflow.ellipsis, // Ellipsis if text is too long
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
  );
}

Widget _buildhead(BuildContext context) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // const Expanded(
          //   child: Text(
          //     'Rider Spot',
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //         fontSize: 19,
          //         fontWeight: FontWeight.w600,
          //         color: Colors.white),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: CustomIcon(
              onTap: () {
                customShowDialog(context);
              },
              icon: Icons.logout_sharp,
            ),
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
            width: deviceWidth(context) - deviceWidth(context) / 3,
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
                  'You Want Log Out?',
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
                          width: 1,
                          buttomColor: CustomColors.black,
                          textColor: CustomColors.white,
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
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: SmallTextbutton(
                          width: 1,
                          buttomColor: CustomColors.black,
                          textColor: CustomColors.white,
                          buttomName: 'LOG OUT',
                          voidCallBack: () async {
                            await authService.signOut();

                            Navigator.pushAndRemoveUntil(
                                // ignore: use_build_context_synchronously
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => const LoginScreen()),
                                (Route<dynamic> route) => false);
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
      });
}
