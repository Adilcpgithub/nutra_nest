import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutra_nest/features/product_details/presentation/pages/product_list_page.dart';
import 'package:nutra_nest/utity/colors.dart';
import 'package:nutra_nest/utity/navigation.dart';
import 'package:nutra_nest/widgets/image_carousel.dart';
import 'package:nutra_nest/widgets/textformfield.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isMobile(context)
                    ? 20
                    : MediaQuery.of(context).size.width / 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                _buildSearchBar(),
                _buildFeaturedSection(),
                _buildSparePartsSection(),
                _buildCycleTypesGrid(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bool isMobile(BuildContext context) {
  return MediaQuery.of(context).size.width <= 600;
}

Widget _buildHeader() {
  return FadeInDown(
    duration: const Duration(milliseconds: 500),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              'Welcome to',
              style: GoogleFonts.poppins(
                color: Colors.grey[400],
                fontSize: 16,
              ),
            ),
            Text(
              'Rider-Spot',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 17),
            GestureDetector(
              onTap: () async {},
              child: Stack(
                children: [
                  Container(
                    height: 39,
                    width: 39,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5, color: CustomColors.green),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(7.0),
                      child: Icon(Icons.notifications, color: Colors.white),
                    ),
                  ),
                  Positioned(
                    top: -1,
                    right: 5,
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: CustomColors.green,
                          shape: BoxShape.circle,
                          // borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(width: 1, color: CustomColors.green)),
                      padding: const EdgeInsets.all(4),
                      child: const Text(
                        '1',
                        style: TextStyle(color: CustomColors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

//adfashskdflasdhf
Widget _buildSearchBar() {
  final TextEditingController _searchCountroller = TextEditingController();
  return FadeInDown(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: SizedBox(
            height: 68,
            child: CustomTextFormField(
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 20, right: 23),
                child: Icon(
                  Icons.search,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              controller: _searchCountroller,
              labelText: 'Search',
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    ),
  );
}

Widget _buildFeaturedSection() {
  return FadeInUp(
    child: Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Featured',
                style: GoogleFonts.nunito(
                    color: CustomColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ],
        ),
        ImageCarousel(),
        const SizedBox(
          height: 10,
        )
      ],
    ),
  );
}

Widget _categoryContainer(
    String categoryName, IconData icon, VoidCallback function) {
  return GestureDetector(
    onTap: () => function,
    child: Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
          color: Colors.grey[900], borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            size: 30,
            icon,
            color: CustomColors.green,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(categoryName,
              style: GoogleFonts.lato(
                  color: CustomColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11))
        ],
      ),
    ),
  );
}

Widget _buildCycleTypesGrid(BuildContext context) {
  return Column(
    children: [
      const SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Type of Cycles',
              style: GoogleFonts.nunito(
                  color: CustomColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        ],
      ),
      Container(
        width: double.maxFinite,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _cycleContainer('Mountain\n     Bikes', Icons.terrain, () {
                    log('button pressed 1');
                    CustomNavigation.push(
                        context,
                        const CycleListPage(
                          cycleTypeNumber: 1,
                        ));
                  }),
                  _cycleContainer('Road Bikes', Icons.directions_bike, () {
                    log('button pressed 2');
                    CustomNavigation.push(
                        context,
                        const CycleListPage(
                          cycleTypeNumber: 2,
                        ));
                  }),
                  _cycleContainer('Hybrid Bikes', Icons.commute, () {
                    log('button pressed 3');
                    CustomNavigation.push(
                        context,
                        const CycleListPage(
                          cycleTypeNumber: 3,
                        ));
                  }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _cycleContainer('Electric Bikes', Icons.electric_bike, () {
                    log('button pressed 4');
                    CustomNavigation.push(
                        context,
                        const CycleListPage(
                          cycleTypeNumber: 4,
                        ));
                  }),
                  _cycleContainer("Kids' Bikes", Icons.child_care, () {
                    log('button pressed 5');
                    CustomNavigation.push(
                        context,
                        const CycleListPage(
                          cycleTypeNumber: 5,
                        ));
                  }),
                  _cycleContainer('Folding Bikes', Icons.merge_type, () {
                    log('button pressed 6');
                    CustomNavigation.push(
                        context,
                        const CycleListPage(
                          cycleTypeNumber: 6,
                        ));
                  }),
                ],
              ),
            )
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}

Widget _cycleContainer(String cycleName, IconData icon, VoidCallback function) {
  return GestureDetector(
    onTap: () => function(),
    child: Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
          color: Colors.grey[900], borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            size: 30,
            icon,
            color: CustomColors.green,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(cycleName,
              style: GoogleFonts.lato(
                  color: CustomColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11))
        ],
      ),
    ),
  );
}

Widget _buildSparePartsSection() {
  return FadeInUp(
    duration: const Duration(milliseconds: 500),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'Spare Parts',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sparePartsList.length,
            itemBuilder: (context, index) {
              final part = sparePartsList[index];
              return SparePartCard(
                imagePath: part.image,
                title: part.name,
                price: part.price,
                rating: part.rating,
                onTap: () {},
              );
            },
          ),
        ),
      ],
    ),
  );
}

class SparePart {
  final String name;
  final String image;
  final double price;
  final double rating;

  SparePart({
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
  });
}

final List<SparePart> sparePartsList = [
  SparePart(
    name: 'Bike Chain',
    image: 'assets/NutraNest.png', // Add your image assets
    price: 29.99,
    rating: 4.5,
  ),
  SparePart(
    name: 'Brake Set',
    image: 'assets/NutraNest.png',
    price: 49.99,
    rating: 4.8,
  ),
  SparePart(
    name: 'Pedals',
    image: 'assets/NutraNest.png',
    price: 19.99,
    rating: 4.3,
  ),
  // Add more spare parts as needed
];

class SparePartCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final double price;
  final double rating;
  final VoidCallback onTap;

  const SparePartCard({
    required this.imagePath,
    required this.title,
    required this.price,
    required this.rating,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Modified Image Container
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(116, 8, 208, 98),
                ),
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '\$${price.toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          color: CustomColors.green,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        rating.toString(),
                        style: GoogleFonts.poppins(
                          color: Colors.grey[400],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
