import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
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
                      'assets/image.png',
                      height: 25,
                    ),
                    const SizedBox(width: 59), // Space between icon and text
                    const Expanded(
                      child: Text(
                        'Edit Profile', // Example with longer text
                        style: TextStyle(fontSize: 15, color: Colors.black),
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
                      'assets/image copy.png',
                      height: 21,
                    ),
                    const SizedBox(width: 59), // Space between icon and text
                    const Expanded(
                      child: Text(
                        'Update Address', // Example with longer text
                        style: TextStyle(fontSize: 15, color: Colors.black),
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
                      'assets/image copy 3.png',
                      height: 21,
                    ),
                    const SizedBox(width: 59), // Space between icon and text
                    const Expanded(
                      child: Text(
                        'Purchase History', // Example with longer text
                        style: TextStyle(fontSize: 15, color: Colors.black),
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
                        style: TextStyle(fontSize: 15, color: Colors.black),
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
                        style: TextStyle(fontSize: 15, color: Colors.black),
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
    );
  }
}
