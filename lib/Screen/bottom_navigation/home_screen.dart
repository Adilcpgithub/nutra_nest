import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutra_nest/utity/colors.dart';
import 'package:nutra_nest/widgets/image_carousel.dart';
import 'package:nutra_nest/widgets/textformfield.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(),
                _buildSerchBar(),
                _builCarousel(),
                _buildTypeofCycles()
              ],
            ),
          ),
        ),
      ),
    );
  }
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
              'Nutra-Nest',
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
                    height: 41,
                    width: 41,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.5, color: Color.fromARGB(54, 8, 208, 98)),
                      color: const Color.fromARGB(148, 27, 94, 31),
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
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: CustomColors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        '1',
                        style: TextStyle(color: Colors.white),
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
Widget _buildSerchBar() {
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

Widget _builCarousel() {
  return FadeInUp(
    child: Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Wheel Deals',
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

Widget _buildTypeofCycles() {
  return Column(
    children: [
      Row(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
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
                  _cycleContainer('Mountain\n     Bikes', Icons.terrain, () {}),
                  _cycleContainer('Road Bikes', Icons.directions_bike, () {}),
                  _cycleContainer('Hybrid Bikes', Icons.commute, () {}),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _cycleContainer('Electric Bikes', Icons.electric_bike, () {}),
                  _cycleContainer("Kids' Bikes", Icons.child_care, () {}),
                  _cycleContainer('Folding Bikes', Icons.merge_type, () {}),
                ],
              ),
            )
          ],
        ),
      )
    ],
  );
}

Widget _cycleContainer(String cycleName, IconData icon, VoidCallback function) {
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
