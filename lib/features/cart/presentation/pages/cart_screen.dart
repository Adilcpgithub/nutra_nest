import 'dart:developer';
import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nutra_nest/core/network/cubit/network_cubit.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';
import 'package:nutra_nest/features/cart/presentation/bloc/bloc/cart_bloc.dart';
import 'package:nutra_nest/features/home/presentation/pages/product_details_page.dart';
import 'package:nutra_nest/model/cycle.dart';
import 'package:nutra_nest/utity/app_logo.dart';
import 'package:nutra_nest/utity/colors.dart';
import 'package:nutra_nest/utity/navigation.dart';
import 'package:nutra_nest/utity/number_format.dart';
import 'package:nutra_nest/widgets/custom_textbutton.dart';

class CartScreen extends StatefulWidget {
  final bool fromBottomNav;
  const CartScreen({super.key, required this.fromBottomNav});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    context.read<CartBloc>().add(LoadCart());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme(context),
      body: SafeArea(child: BlocBuilder<NetworkCubit, bool>(
        builder: (context, isConnected) {
          if (isConnected) {
            return Stack(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Stack(children: [
                  Column(
                    children: [
                      sizedBoxHeight(10),
                      buildHeader(context),
                      sizedBoxHeight(20),
                      buildCartContainer(),
                      buildTotalContainer(context)
                    ],
                  ),
                  buildCheckOutButton(),
                ]),
              ),
            ]);
          } else {
            return Expanded(
              child: Center(
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
              )),
            );
          }
        },
      )),
    );
  }
}

Widget sizedBoxHeight(double height) {
  return SizedBox(height: height);
}

Widget buildHeader(
  BuildContext context,
) {
  return Text(
    'My Cart',
    textAlign: TextAlign.center,
    style: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: customTextTheme(context),
    ),
  );
}

Widget buildCartContainer() {
  return BlocBuilder<CartBloc, CartState>(
    builder: (context, state) {
      final cartItems = state.cartItems;
      if (cartItems.isNotEmpty) {
        //log('${state.products.length}');
        return SizedBox(
          height: deviceHeight(context) / 2.4,
          child: FadeInDown(
            duration: const Duration(milliseconds: 600),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.fast),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Padding(
                  key: ValueKey(item.id),
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: isDark(context)
                                ? CustomColors.white
                                : CustomColors.lightWhite,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align content vertically
                          children: [
                            GestureDetector(
                              onTap: () async {
                                Cycle? cycle = await getProductById(item.id);
                                if (cycle != null) {
                                  CustomNavigation.push(
                                      // ignore: use_build_context_synchronously
                                      context,
                                      ProductDetails(
                                        cycle: cycle,
                                        fromCart: true,
                                        cycleFromCart: cycle,
                                        productId: item.id,
                                        iscartAdded: true,
                                      ));
                                } else {
                                  log('false');
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                        image: AssetImage(appLogo(context))),
                                  ),
                                  height: 130,
                                  width: 130,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                    child: Stack(children: [
                                      Image.network(
                                        item.imageUrl,
                                        height: double.infinity,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
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
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w600,
                                        color: CustomColors.black),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    item.brand,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        color: CustomColors.black),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '₹${item.price}.00',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: CustomColors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: () => context
                              .read<CartBloc>()
                              .add(RemoveFromCart(item.id)),
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
                      Positioned(
                        right: 15,
                        bottom: 15,
                        child: Container(
                          key: ValueKey(item.id),
                          height: 30,
                          width: 75,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromARGB(231, 33, 30, 30)),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    context
                                        .read<CartBloc>()
                                        .add(DecreaseProductCount(item.id));
                                  },
                                  splashColor: Colors.grey.withOpacity(0.3),
                                  highlightColor: Colors.grey.withOpacity(0.1),
                                  child: const Center(
                                    child: Text(
                                      '-',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    '${item.productCount}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    context
                                        .read<CartBloc>()
                                        .add(IncreaseProductCount(item.id));
                                  },
                                  splashColor: Colors.grey.withOpacity(0.3),
                                  highlightColor: Colors.grey.withOpacity(0.1),
                                  child: const Center(
                                    child: Text(
                                      '+',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        );
      } else {
        // log('${state.products.length}');
        return Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/Animation - 1737089245188 (1).json',
                ),
                Text(
                  'Cart is empty',
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

buildTotalContainer(BuildContext context) {
  return BlocBuilder<CartBloc, CartState>(
    builder: (context, state) {
      if (state.cartItems.isNotEmpty) {
        return FadeInUp(
          duration: const Duration(milliseconds: 500),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity, // Full width
                height: 0.1, // Only 2 pixels height
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 179, 188, 183)
                        .withOpacity(0.3),
                    blurRadius: 3,
                    spreadRadius: 4,
                  ),
                ]),
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 10.0, sigmaY: 10.0), //  Blur effect
                    child: Container(
                      color: const Color.fromARGB(169, 0, 0, 0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    cartText(context, 'Subtotal'),
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (state is ProductTotal) {
                          return cartText(
                              context, '${formate().format(state.total)}.00');
                        } else {
                          return cartText(context, '0');
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    cartText(context, 'Shipping'),
                    cartText(context, '560.00'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    cartText(context, 'Total'),
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (state is ProductTotal) {
                          //! set the Shipping amount
                          return cartText(context,
                              '${formate().format(state.total + 560)}.00');
                        } else {
                          return cartText(context, '0.00');
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      } else {
        return SizedBox.fromSize();
      }
    },
  );
}

Future<Cycle?> getProductById(String productId) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  log('calling');
  log('product id is $productId');
  try {
    // Reference to the specific document in the 'products' collection
    var docSnapshot = await firestore.collection('cycles').doc(productId).get();

    // Fetch the document

    log('sssssssss');
    // Check if the document exists
    if (docSnapshot.exists) {
      // Convert the document data to a Cycle object
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      return Cycle.fromMap(data);
    } else {
      log('not existiong ');

      return null;
    }
  } catch (e) {
    log('Error fetching product: $e');
    return null;
  }
}

Widget cartText(BuildContext context, String data) {
  return Text(
    data,
    style: TextStyle(
        color: customTextTheme(context),
        fontSize: 20,
        fontWeight: FontWeight.bold),
  );
}

buildCheckOutButton() {
  return BlocBuilder<CartBloc, CartState>(
    builder: (context, state) {
      if (state.cartItems.isNotEmpty) {
        return Positioned(
          bottom: 16,
          left: 20,
          right: 20,
          child: FadeInUp(
            child: CustomTextbutton(
              color: CustomColors.green,
              nameColor: Colors.white,
              buttomName: 'PROCEED TO CHECKOUT',
              voidCallBack: () {},
            ),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    },
  );
}
