import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';
import 'package:nutra_nest/core/theme/cubit/theme_cubit.dart';
import 'package:nutra_nest/features/home/presentation/pages/product_list_page.dart';
import 'package:nutra_nest/core/network/cubit/network_cubit.dart';
import 'package:nutra_nest/utity/colors.dart';
import 'package:nutra_nest/utity/navigation.dart';
import 'package:nutra_nest/utity/number_format.dart';
import 'package:nutra_nest/widgets/image_carousel.dart';
import 'package:nutra_nest/widgets/textformfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    log('haeijioeejoi1;1');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme(context),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: BlocBuilder<NetworkCubit, bool>(
            builder: (context, isConnected) {
              log('is connected is $isConnected');
              if (isConnected) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: isMobile(context)
                            ? 20
                            : MediaQuery.of(context).size.width / 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(context),
                        _buildSearchBar(context),
                        _buildFeaturedSection(context),
                        _buildSparePartsSection(context),
                        _buildCycleTypesGrid(context),
                      ],
                    ),
                  ),
                );
              } else {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/Animation - 1736755470091.json',
                        height: 110),
                    Text(
                      'No internet connection!',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodySmall!.color,
                      ),
                    )
                  ],
                ));
              }
            },
          ),
        ),
      ),
    );
  }
}

bool isMobile(BuildContext context) {
  return MediaQuery.of(context).size.width <= 600;
}

Widget _buildHeader(BuildContext context) {
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
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
            Text(
              'Rider-Spot',
              style: GoogleFonts.poppins(
                color: Theme.of(context).textTheme.bodySmall!.color,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Column(
              children: [
                const SizedBox(height: 17),
                GestureDetector(
                  onTap: () => context.read<ThemeCubit>().toggleTheme(),
                  child: Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark(context)
                          ? Colors.grey[800]
                          : CustomColors.lightWhite,
                    ),
                    child: Icon(
                      isDark(context) ? Icons.wb_sunny : Icons.nightlight_round,
                      size: 26,
                      color: isDark(context) ? Colors.amber[400] : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
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
                          border:
                              Border.all(width: 1.5, color: CustomColors.green),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Icon(
                            Icons.notifications,
                            color: Theme.of(context).textTheme.bodySmall!.color,
                          ),
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
                              border: Border.all(
                                  width: 1, color: CustomColors.green)),
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            '1',
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodySmall!.color,
                            ),
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
      ],
    ),
  );
}

//adfashskdflasdhf
Widget _buildSearchBar(BuildContext context) {
  final TextEditingController searchCountroller = TextEditingController();
  FocusNode focusNode = FocusNode();
  return FadeInDown(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: SizedBox(
            height: 68,
            child: CustomTextFormField(
              focusNode: focusNode,
              autofocus: false,
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 20, right: 23),
                child: Icon(
                  Icons.search,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
              controller: searchCountroller,
              labelText: 'Search for Cycles, Spare Parts, and More...',
              labelTextColor: Colors.grey,
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

Widget _buildFeaturedSection(BuildContext context) {
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
                    color: Theme.of(context).textTheme.bodySmall!.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ],
        ),
        const Stack(children: [ImageCarousel()]),
        const SizedBox(
          height: 10,
        )
      ],
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
                  color: Theme.of(context).textTheme.bodySmall!.color,
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
                  _cycleContainer('Mountain\n     Bikes', Icons.terrain,
                      () async {
                    log('button pressed 1');

                    closeKeyBord();

                    CustomNavigation.push(
                        context,
                        const CycleListPage(
                          cycleTypeNumber: 1,
                        ));
                  }, context),
                  _cycleContainer('Road Bikes', Icons.directions_bike, () {
                    log('button pressed 2');
                    closeKeyBord();
                    CustomNavigation.push(
                        context,
                        const CycleListPage(
                          cycleTypeNumber: 2,
                        ));
                  }, context),
                  _cycleContainer('Hybrid Bikes', Icons.commute, () {
                    log('button pressed 3');
                    closeKeyBord();
                    CustomNavigation.push(
                        context,
                        const CycleListPage(
                          cycleTypeNumber: 3,
                        ));
                  }, context),
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
                    closeKeyBord();
                    CustomNavigation.push(
                        context,
                        const CycleListPage(
                          cycleTypeNumber: 4,
                        ));
                  }, context),
                  _cycleContainer("Kids' Bikes", Icons.child_care, () {
                    log('button pressed 5');
                    closeKeyBord();
                    CustomNavigation.push(
                        context,
                        const CycleListPage(
                          cycleTypeNumber: 5,
                        ));
                  }, context),
                  _cycleContainer('Folding Bikes', Icons.merge_type, () {
                    log('button pressed 6');
                    closeKeyBord();
                    CustomNavigation.push(
                        context,
                        const CycleListPage(
                          cycleTypeNumber: 6,
                        ));
                  }, context),
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

Widget _cycleContainer(String cycleName, IconData icon, VoidCallback function,
    BuildContext context) {
  return GestureDetector(
    onTap: () => function(),
    child: Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[800]
              : CustomColors.lightWhite,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            size: 30,
            icon,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(cycleName,
              style: GoogleFonts.lato(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 11))
        ],
      ),
    ),
  );
}

Widget _buildSparePartsSection(BuildContext context) {
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
              color: Theme.of(context).textTheme.bodySmall!.color,
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
          color: isDark(context) ? Colors.grey[800] : CustomColors.lightWhite,
          borderRadius: BorderRadius.circular(17),
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
                    //  color: Color.fromARGB(116, 8, 208, 98),
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
                      color: customTextTheme(context),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text(
                        '₹ 200',
                        style: TextStyle(
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
                          color: customTextTheme(context),
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
