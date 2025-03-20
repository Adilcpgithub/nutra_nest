import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> imageUrls = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  // Function to fetch images from Firestore
  Future<void> fetchImages() async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('features').doc('1231').get();

      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;

        if (data.containsKey('imageUrls')) {
          var urls = data['imageUrls'];

          if (urls is List<dynamic>) {
            setState(() {
              imageUrls = List<String>.from(urls); // Convert list properly
              isLoading = false;
            });
          } else if (urls is String) {
            setState(() {
              imageUrls = [urls]; // Convert single string to list
              isLoading = false;
            });
          } else {
            log("Invalid data format for imageUrls");
          }
        } else {
          log("Field 'imageUrls' not found in document");
        }
      } else {
        log("Document does not exist");
      }
    } catch (e) {
      log("Error fetching images: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 190,
        child: isLoading
            ? const Center(child: CircularProgressIndicator()) // Show loader
            : imageUrls.isEmpty
                ? const Center(child: Text("No images found"))
                : CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: false,
                      aspectRatio: 15 / 10,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      viewportFraction: 1.0,
                    ),
                    items: imageUrls.map((imageUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              image: DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
      ),
    );
  }
}
