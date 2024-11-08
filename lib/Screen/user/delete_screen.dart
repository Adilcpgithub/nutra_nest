import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nutra_nest/widgets/small_text_buttom.dart';

class DeleteScreen extends StatelessWidget {
  const DeleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  children: [
                    SmallTextbutton(
                      buttomName: 'DELETE ACCOUNT',
                      voidCallBack: () {},
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    SmallTextbutton(
                      buttomName: 'CANCEL',
                      voidCallBack: () {},
                      buttomColor: Colors.white,
                      textColor: Colors.black,
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
