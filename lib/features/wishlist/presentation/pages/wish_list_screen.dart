import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nutra_nest/core/network/cubit/network_cubit.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';
import 'package:nutra_nest/features/wishlist/presentation/bloc/bloc/wish_bloc.dart';
import 'package:nutra_nest/features/wishlist/presentation/model/wish_model.dart';
import 'package:nutra_nest/utity/app_logo.dart';
import 'package:nutra_nest/utity/colors.dart';
import 'package:nutra_nest/utity/number_format.dart';
import 'package:nutra_nest/utity/scaffol_message.dart';

class WhishListScreen extends StatefulWidget {
  const WhishListScreen({super.key});

  @override
  State<WhishListScreen> createState() => _WhishListScreenState();
}

class _WhishListScreenState extends State<WhishListScreen> {
  @override
  void initState() {
    context.read<WishBloc>().add(LoadwishList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme(context),
      body: BlocListener<WishBloc, WishState>(
        listener: (context, state) {
          if (state is WishDataAddSuccessful) {
            return showUpdateNotification(
              context: context,
              message: state.message,
              color: CustomColors.green,
            );
          }
        },
        child: SafeArea(child: BlocBuilder<NetworkCubit, bool>(
          builder: (context, isConnected) {
            if (isConnected) {
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      sizedBoxHeight(10),
                      buildHeader(context),
                      builWishList(context)
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
        )),
      ),
    );
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
        BlocBuilder<WishBloc, WishState>(
          builder: (context, state) {
            int count;
            if (state.wishItems.isNotEmpty) {
              count = state.wishItems.length;
            } else {
              count = 0;
            }
            return Text(
              '$count Items', // Make this dynamic based on your list length
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            );
          },
        ),
      ],
    ),
  );
}

Widget builWishList(BuildContext context) {
  return BlocBuilder<WishBloc, WishState>(
    builder: (context, state) {
      if (state.wishItems.isNotEmpty) {
        return Expanded(
          child: FadeInDown(
            child: ListView.builder(
              itemCount: state.wishItems.length,
              itemBuilder: (context, index) {
                final wishModelData = state.wishItems[index];
                final price = wishModelData.price;
                final formatedPrice = formate().format(price);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SingleChildScrollView(
                    child: Stack(children: [
                      Container(
                        height: 160,
                        decoration: BoxDecoration(
                          color: isDark(context)
                              ? CustomColors.white
                              : CustomColors.lightWhite,
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

                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)),
                                height: 130,
                                width: 130,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  child: Stack(children: [
                                    Image.network(
                                      wishModelData.imageUrl,
                                      height: double.infinity,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12),
                                          ),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              SizedBox(
                                                  height: double.infinity,
                                                  width: double.maxFinite,
                                                  child: Image.asset(
                                                    appLogo(context),
                                                    fit: BoxFit.cover,
                                                  )),
                                              const CircularProgressIndicator(
                                                color: CustomColors.green,
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const SizedBox(
                                          height: double.maxFinite,
                                          width: double.maxFinite,
                                          child: Center(
                                              child: Icon(
                                            size: 50,
                                            Icons.image_not_supported,
                                            color: Colors.grey,
                                          )),
                                        );
                                      },
                                    ),
                                  ]),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            wishModelData.name,
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    // Product Details
                                    Text(
                                      'Brand : ${wishModelData.brand}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: customTextTheme(context),
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
                            //   return cartText(context,
                            //   '${formate().format(state.total + 560)}.00');

                            Text(
                              '₹${formatedPrice.toString()}.00',
                              style: GoogleFonts.aBeeZee(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: customTextTheme(context),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                context.read<WishBloc>().add(AddWishToCart(
                                    wishModelData.id, wishModelData));
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
                          onTap: () {
                            context
                                .read<WishBloc>()
                                .add(RemoveFromWish(wishModelData.id));
                          },
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
              },
            ),
          ),
        );
      } else {
        return Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/Animation - 1737606612185.json',
                ),
                Text(
                  'Wishlist is empty',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: customTextTheme(context),
                  ),
                )
              ],
            ),
          ),
        );
      }
    },
  );
}
