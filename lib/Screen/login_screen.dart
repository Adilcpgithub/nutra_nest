import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 200,
            width: 200,
            color: Colors.black,
          ),
          Container(
            height: 200,
            width: 200,
            color: Colors.red,
          )
        ],
      ),
    );
  }
}
