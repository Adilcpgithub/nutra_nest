import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nutra_nest/core/network/cubit/network_cubit.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';
import 'package:nutra_nest/utity/colors.dart';

class WhishListScreen extends StatelessWidget {
  const WhishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocBuilder<NetworkCubit, bool>(
      builder: (context, isConnected) {
        if (isConnected) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  sizedBoxHeight(10),
                  Center(child: buildHeader(context)),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return wishContainer(context);
                      },
                    ),
                  )
                ],
              ));
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
                  color: customTextTheme(context),
                ),
              )
            ],
          ));
        }
      },
    ));
  }
}

Widget sizedBoxHeight(double height) {
  return SizedBox(height: height);
}

Widget buildHeader(
  BuildContext context,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Wishlist',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: customTextTheme(context),
          ),
        ),
        Text(
          '5 Items', // Make this dynamic based on your list length
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    ),
  );
}

Widget wishContainer(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: SingleChildScrollView(
      child: Stack(children: [
        Container(
          height: 160,
          decoration: BoxDecoration(
            color: CustomColors.lightWhite,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              // Product Image
              Container(
                width: deviceWidth(context) / 3.0,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                    image: AssetImage('assets/NutraNest.png'), // Add your image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Product Details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Product Name and Remove Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Mountain Bike X-Series',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      // Product Details
                      Text(
                        'Color: Metallic Blue',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Price and Add to Cart
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 15,
          bottom: 15,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '₹24,999',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: CustomColors.green,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  // Add to cart logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 6,
                  ),
                ),
                child: Text(
                  'Add to Cart',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            child: Container(
              height: 30,
              width: 30,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(231, 204, 199, 199),
                  shape: BoxShape.circle),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: customTextTheme(context),
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    ),
  );
}
