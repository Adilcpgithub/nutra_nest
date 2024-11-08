import 'package:flutter/material.dart';

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
            ],
          ),
        ),
      ),
    );
  }
}
