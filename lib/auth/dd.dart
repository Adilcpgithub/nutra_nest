import 'package:flutter/material.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/auth/cloudinary_service.dart';

class Dee extends StatefulWidget {
  Dee({super.key});

  @override
  State<Dee> createState() => _DeeState();
}

class _DeeState extends State<Dee> {
  String? imageUrl;
  final userStatus = UserStatus();

  @override
  Widget build(BuildContext context) {
    CloudinaryService cloudinaryService = CloudinaryService();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () async {
                  imageUrl = await cloudinaryService.uploadImage('121');
                },
                child: const Text('upload')),
            TextButton(
                onPressed: () async {
                  await cloudinaryService.updateImage('121');
                },
                child: const Text('update')),
            TextButton(
              onPressed: () async {
                //   cloudinaryService.getImageUrl('1231');
              },
              child: const Text('get'),
            ),
            TextButton(
              onPressed: () async {
                await cloudinaryService.deleteImage('1231');
              },
              child: const Text('deleted'),
            )
          ],
        ),
      ),
    );
  }
}
