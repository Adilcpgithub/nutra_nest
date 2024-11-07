import 'package:flutter/material.dart';
import 'package:nutra_nest/screen/bottom_navigation/account_screen.dart';
import 'package:nutra_nest/screen/bottom_navigation/cart_screen.dart';
import 'package:nutra_nest/screen/bottom_navigation/home_screen.dart';
import 'package:nutra_nest/screen/bottom_navigation/whish_list_screen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0; // To track the selected tab
  List<Widget> _screens = [
    HomeScreen(),
    CartScreen(),
    WhishListScreen(),
    AccountScreen(),
  ]; // List of screens to switch between

  // Function to handle tab change
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex, // Set the currently selected index
        onTap: _onItemTapped, // Handle the tap event
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.home),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Whish list',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
