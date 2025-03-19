import 'package:flutter/material.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';
import 'package:nutra_nest/page/bottom_navigation/account_screen.dart';
import 'package:nutra_nest/features/cart/presentation/pages/cart_screen.dart';
import 'package:nutra_nest/features/home/presentation/pages/home_screen.dart';
import 'package:nutra_nest/features/wishlist/presentation/pages/wish_list_screen.dart';
import 'package:nutra_nest/utity/colors.dart';

class MyHomePage extends StatefulWidget {
  final int setIndex;
  const MyHomePage({super.key, this.setIndex = 0});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0; // To track the selected tab

  final List<Widget> _screens = [
    const HomeScreen(),
    const CartScreen(
      fromBottomNav: true,
    ),
    const WhishListScreen(),
    const AccountScreen(),
  ]; // List of screens to switch between

  // Function to handle tab change
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _selectedIndex = widget.setIndex;
    super.initState();
  }

  bool isMobile() {
    return MediaQuery.of(context).size.width <= 600;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme(context),
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: Container(
        color: Colors.transparent, // Background color for the bar
        child: Padding(
          padding: EdgeInsets.only(
              top: 6,
              left: isMobile() ? 5 : MediaQuery.of(context).size.width / 4,
              right: isMobile() ? 5 : MediaQuery.of(context).size.width / 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home,
                label: 'Home',
                index: 0,
                blackImag: 'assets/image copy 7.png',
                whiteImg: 'assets/image copy 8.png',
              ),
              _buildNavItem(
                icon: Icons.search,
                label: 'Cart',
                index: 1,
                blackImag: 'assets/image copy 9.png',
                whiteImg: 'assets/image copy 10.png',
                imageHeight: 22,
              ),
              _buildNavItem(
                icon: Icons.notifications,
                label: 'Wish list',
                index: 2,
                blackImag: 'assets/image copy 11.png',
                whiteImg: 'assets/image copy 12.png',
                imageHeight: 22,
              ),
              _buildNavItem(
                icon: Icons.account_circle,
                label: 'Account',
                index: 3,
                blackImag: 'assets/image copy 13.png',
                whiteImg: 'assets/image copy 14.png',
                imageHeight: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build each custom nav item with animation and alignment
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required String whiteImg,
    required String blackImag,
    double? imageHeight,
  }) {
    final isSelected = _selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTapped(index), // Update selected index on tap
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
            left: 2,
            right: 2,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            height: 68,
            decoration: BoxDecoration(
              color: isSelected
                  ? CustomColors.green
                  : Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[800]
                      : CustomColors.lightWhite,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 350),
                    tween:
                        Tween<double>(begin: 1.0, end: isSelected ? 1.2 : 1.0),
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: Image.asset(
                          isDark(context)
                              ? isSelected
                                  ? whiteImg
                                  : whiteImg
                              : isSelected
                                  ? whiteImg
                                  : blackImag,

                          // isSelected ? whiteImg : blackImag,
                          height: isSelected ? 20 : 22,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 4), // Space between icon and text
                  Text(
                    label,
                    style: TextStyle(
                      color: isDark(context)
                          ? isSelected
                              ? Colors.white
                              : Colors.white
                          : isSelected
                              ? Colors.white
                              : Colors.black,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
