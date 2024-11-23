import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> offerImages = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ97LQR6VpYTM9B2O-xR5TeoQ11BjnHOVQeDZPLL_vrhcebI5FbmpMwxzv7k5MIpKYQF7I&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZnPSfjT2pxqBnDiFMoI5NjIoalAgmkOqwTg&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxJvN-EDXpF4r34NX2iErtZUyk3ejpzm9avg&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4RTB6zR976YBjgeDDugVT3FsCNUL4mhl6mA&s'
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: double.infinity,
      height: 190, // Adjust height as needed
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: false, // Makes the center image larger
          aspectRatio: 15 / 10, // Aspect ratio of the slider
          autoPlayInterval: const Duration(seconds: 3), // Time for each slide
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          viewportFraction: 1.0, // Visible portion of each image
        ),
        items: offerImages.map((imageUrl) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
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
    ));
  }
}
