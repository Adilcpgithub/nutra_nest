import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/blocs/image_bloc/bloc/image_bloc.dart';
import 'package:nutra_nest/features/home/data/models/review_model.dart';
import 'package:nutra_nest/features/home/presentation/bloc/cubit/product_cubit/product_cart_cubit.dart';
import 'package:nutra_nest/features/home/presentation/bloc/cycle_list_bloc/bloc/cycle_list_bloc.dart';
import 'package:nutra_nest/features/home/presentation/bloc/review/review_bloc.dart';
import 'package:nutra_nest/features/home/presentation/widgets/product_details_widget.dart';
import 'package:nutra_nest/model/cycle.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';
import 'package:nutra_nest/page/bottom_navigation/bottom_navigation_screen.dart';
import 'package:nutra_nest/utity/app_logo.dart';
import 'package:nutra_nest/utity/colors.dart';
import 'package:nutra_nest/utity/navigation.dart';
import 'package:nutra_nest/utity/scaffol_message.dart';
import 'package:nutra_nest/widgets/custom_textbutton.dart';
import 'package:nutra_nest/widgets/icons_widget.dart';

// ignore: must_be_immutable
class ProductDetails extends StatefulWidget {
  double? count;
  final Cycle cycle;
  final bool fromCart;
  Cycle? cycleFromCart;
  String productId;
  bool iscartAdded;

  ProductDetails(
      {super.key,
      required this.cycle,
      required this.fromCart,
      this.cycleFromCart,
      required this.productId,
      this.count,
      this.iscartAdded = false});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late PageController _pageController;
  late Cycle currentCycle;

  final int rating = 4;

  //! here the for sample remove with actual data
  bool favorite = false;
  late ScrollController scrollController;
  bool isAtBottom = false;
  int data = 1;

  //!-----------------------------------------

  @override
  void initState() {
    log('ssss ${widget.iscartAdded}');
    if (widget.fromCart) {
      if (widget.cycleFromCart != null) {
        currentCycle = widget.cycleFromCart!;
      }
    } else {
      currentCycle = widget.cycle;
    }
    log('product id is 1111111 ${widget.productId}');
    // context.read<ProductCartCubit>().add(ProductCartState(productCount: c, isAddedToCart: isAddedToCart));
    _pageController = PageController();
    scrollController = ScrollController();
    scrollController.addListener(scrollerListner);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme(context),
      body: BlocProvider(
        create: (context) => ProductCartCubit(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Stack(children: [
              SingleChildScrollView(
                controller: scrollController,
                child: BlocListener<ProductCartCubit, ProductCartState>(
                  listenWhen: (previous, current) => current.isAddedToCart,
                  listener: (context, state) {
                    showUpdateNotification(
                      context: context,
                      message: 'Product added to cart',
                      color: CustomColors.green,
                    );
                  },
                  child: Column(
                    children: [
                      customSizedBox(10),
                      buildHeader(context),
                      customSizedBox(30),
                      buildCycleImages(_pageController, currentCycle),
                      customSizedBox(10),
                      buildImageIconsAndFavorite(context, currentCycle.id,
                          currentCycle, widget.productId),
                      customSizedBox(20),
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  currentCycle.name,
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Brand : ${currentCycle.brand}',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .color,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: CustomColors.green2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 1, bottom: 1, left: 2, right: 2),
                                  child: Text(
                                    ' ${currentCycle.stock} In stock ',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .color,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //!------------------------------
                          // Row(
                          //   children: [
                          //     Container(
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(5),
                          //       ),
                          //       child: Padding(
                          //         padding: const EdgeInsets.only(
                          //             top: 1, bottom: 1, left: 2, right: 2),
                          //         child: Row(
                          //           mainAxisAlignment:
                          //               MainAxisAlignment.spaceEvenly,
                          //           children: [
                          //             // Text(
                          //             //   'Rating ',
                          //             //   style: TextStyle(
                          //             //     fontSize: 15,
                          //             //     color: Theme.of(context)
                          //             //         .textTheme
                          //             //         .bodySmall!
                          //             //         .color,
                          //             //   ),
                          //             // ),

                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          //   customSizedBox(3),
                          // Row(
                          //   children: [
                          //     Text(
                          //       'Weight : ${currentCycle.weight} Kg',
                          //       style: TextStyle(
                          //         color: Theme.of(context)
                          //             .textTheme
                          //             .bodySmall!
                          //             .color,
                          //         fontSize: 15,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          customSizedBox(3),
                          Row(
                            children: [
                              Text(
                                textAlign: TextAlign.left,
                                'Price : ₹${currentCycle.price}.00',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .color,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          customSizedBox(5),
                          Row(
                            children: [
                              Text(
                                'Description',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .color,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          customSizedBox(3),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  child: Text(
                                    currentCycle.description,
                                    maxLines: 40,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .color,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //! comment section
                          Divider(
                            thickness: 0.2,
                            color: customTextTheme(context),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ratings & Reviews',
                                style: TextStyle(
                                  color: customTextTheme(context),
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              ProductDetailsWidget.rateProdcutButton(
                                context,
                                () {
                                  CustomNavigation.push(
                                      context,
                                      ReviewWidget(
                                        productId: widget.productId,
                                      ));
                                },
                              )
                            ],
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    Icons.star,
                                    color: index < rating
                                        ? Colors.yellow
                                        : Colors.grey,
                                    size: 21,
                                  );
                                }),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          Divider(
                            thickness: 0.2,
                            color: customTextTheme(context),
                          ),

                          Container(
                            height: 200,
                            width: double.infinity,
                            color: Colors.amberAccent,
                          ),
                          // //!
                          const SizedBox(
                            height: 120,
                          )
                        ],
                      ),
                      if (currentCycle.description.length < 360)
                        const SizedBox(
                          height: 80,
                        ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: [
                        if (currentCycle.description.length > 60)
                          GestureDetector(
                            onTap: () {
                              if (isAtBottom) {
                                scrollController.animateTo(0,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut);
                              } else {
                                scrollController.animateTo(
                                    scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white ==
                                          Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .color
                                      ? Colors.black
                                      : Colors.white,
                                  border: Border.all(
                                    color: CustomColors.green,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 2, bottom: 2, left: 3, right: 3),
                                  child: Text(
                                    isAtBottom ? 'Show less' : 'Show more',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .color),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        BlocProvider(
                          create: (context) => ProductCartCubit()
                            ..isCartAdded(widget.iscartAdded),
                          child:
                              BlocListener<ProductCartCubit, ProductCartState>(
                            listener: (context, state) {
                              log('Listener triggered: isAddedToCart = ${state.isAddedToCart}');
                            },
                            child:
                                BlocBuilder<ProductCartCubit, ProductCartState>(
                              builder: (context, state) {
                                return CustomTextbutton(
                                  color: CustomColors.green,
                                  buttomName: state.isAddedToCart
                                      ? 'Remove From CART'
                                      : 'ADD TO CART',
                                  voidCallBack: () {
                                    if (state.isAddedToCart) {
                                      context
                                          .read<ProductCartCubit>()
                                          .removeFromCart(widget.productId);
                                    } else {
                                      context
                                          .read<ProductCartCubit>()
                                          .addToCart(
                                              widget.productId, currentCycle);
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ]),
          ),
        ),
      ),
    );
  }

  void scrollerListner() {
    if (scrollController.offset >= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
      // User reached the bottom
      setState(() {
        isAtBottom = true;
      });
    } else {
      // User hasn't reached the bottom
      setState(() {
        isAtBottom = false;
      });
    }
    //User reached the bottom
    if (scrollController.position.pixels == 0) {
      setState(() {
        isAtBottom = false;
      });
    }
  }
}

//! All  widget are here --------------
Widget customSizedBox(double height) {
  return SizedBox(height: height);
}

Widget buildHeader(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomIcon(
          onTap: () {
            Navigator.of(context).pop();
          },
          icon: Icons.arrow_back,
          iconSize: 26),
      const Expanded(child: SizedBox.shrink()),
      CustomIcon(
          onTap: () {
            CustomNavigation.push(
                context,
                const MyHomePage(
                  setIndex: 1,
                ));
          },
          widget: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Image.asset(isDark(context)
                ? 'assets/image copy 10.png'
                : 'assets/image copy 9.png'),
          ),
          iconSize: 25)
    ],
  );
}

Widget buildCycleImages(PageController pageController, Cycle cycle) {
  return SizedBox(
    height: 230,
    child: BlocBuilder<ImageBloc, ImageState>(builder: (context, state) {
      if (state is ImageIndexUpdated) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (pageController.hasClients &&
              pageController.page != state.currentIndex) {
            pageController.animateToPage(state.currentIndex,
                duration: const Duration(milliseconds: 200),
                curve: Curves.ease);
          }
        });
      }
      return PageView.builder(
          onPageChanged: (index) {
            context.read<ImageBloc>().add(PageChangedEvent(index));
          },
          controller: pageController,
          itemCount: cycle.imageUrl.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                height: 230,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: Image.network(
                    cycle.imageUrl[index],
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return ClipRRect(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                                height: double.maxFinite,
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
                    errorBuilder: (context, error, stackTrace) {
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
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          });
    }),
  );
}

Widget buildImageIconsAndFavorite(
    BuildContext contex, String id, Cycle cycle, String productid) {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Expanded(
      child: BlocBuilder<ImageBloc, ImageState>(builder: (context, state) {
        int currentIdex = 0;

        if (state is ImageIndexUpdated) {
          currentIdex = state.currentIndex;
        }
        return Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: cycle.imageUrl.length > 1
                  ? List.generate(cycle.imageUrl.length, (index) {
                      return Stack(
                        children: [
                          // GestureDetector(
                          //   onTap: () {
                          //     context
                          //         .read<ImageBloc>()
                          //         .add(PageChangedEvent(index));
                          //   },
                          //   child: Container(
                          //     height: 20,
                          //     width: 20,
                          //     color: Colors.amber,
                          //   ),
                          //   // child: AnimatedContainer(
                          //   //   duration: const Duration(milliseconds: 300),
                          //   //   margin: const EdgeInsets.symmetric(horizontal: 6),
                          //   //   width: index == currentIdex ? 18 : 9,
                          //   //   height: index == currentIdex ? 18 : 9,
                          //   //   decoration: BoxDecoration(
                          //   //       color: index == currentIdex
                          //   //           ? Theme.of(context)
                          //   //               .textTheme
                          //   //               .bodySmall!
                          //   //               .color
                          //   //           : Theme.of(context)
                          //   //               .textTheme
                          //   //               .displaySmall!
                          //   //               .color,
                          //   //       borderRadius: BorderRadius.circular(15)),
                          //   // ),
                          // ),
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<ImageBloc>()
                                  .add(PageChangedEvent(index));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 100),
                                width: index == currentIdex ? 18 : 11,
                                height: index == currentIdex ? 18 : 11,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    })
                  : []),
        );
      }),
    ),
    BlocBuilder<CycleBloc, CycleState>(
      builder: (context, state) {
        bool favorite = false;
        if (state is CycleLoadedState) {
          favorite = state.favorites.contains(productid);
        }

        return InkWell(
          onTap: () async {
            log('favorite pressed');
            var userStatus = await UserStatus().getUserId();

            // ignore: use_build_context_synchronously
            context
                .read<CycleBloc>()
                .add(ToggleFavoriteEvent(productid, userStatus));
          },
          splashColor: Colors.transparent,
          // ignore: deprecated_member_use
          highlightColor: Colors.green.withOpacity(0.4),
          child: Container(
            height: 39,
            width: 39,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: CustomColors.green),
              // ignore: deprecated_member_use
              color: Colors.green.withOpacity(0.4),
            ),
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 300),
              //! here the for sample datas  named favorite, remove with actual data
              padding: EdgeInsets.all(favorite ? 6 : 8),
              child: favorite
                  ? Image.asset('assets/heart.png')
                  : Image.asset('assets/clipart44480.png'),
              //!------------------------------
            ),
          ),
        );
      },
    ),
  ]);
}

class StarRatingBar extends StatelessWidget {
  final double rating;
  final double maxRating;

  const StarRatingBar(
      {super.key, required this.rating, required this.maxRating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.green, size: 20), // Star Icon
        const SizedBox(width: 8), // Spacing
        SizedBox(
          width: 90,
          child: Expanded(
            child: LinearProgressIndicator(
              value: rating / maxRating, // Normalize value (0 to 1)
              backgroundColor: Colors.grey[300], // Background bar
              color: Colors.green, // Progress color
              minHeight: 7, // Adjust thickness
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),

        Text("$rating/$maxRating"), // Show numeric value
      ],
    );
  }
}

//!-aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
class ReviewWidget extends StatefulWidget {
  final String productId;

  const ReviewWidget({super.key, required this.productId});

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  @override
  void initState() {
    context.read<ReviewBloc>().add(FetchReviewsEvent(widget.productId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 800,
          color: Colors.white,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  context.read<ReviewBloc>().add(AddReviewEvent(
                      widget.productId,
                      Review(
                          userId: widget.productId,
                          userName: 'userName',
                          comment: 'comment',
                          rating: 2,
                          date: DateTime.now())));
                },
                child: Container(
                  height: 100,
                  color: CustomColors.lightWhite,
                ),
              ),
              SizedBox(
                height: 500,
                width: double.infinity,
                child: BlocBuilder<ReviewBloc, ReviewState>(
                  builder: (context, state) {
                    if (state is ReviewLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ReviewsLoaded) {
                      return SingleChildScrollView(
                        child: Column(
                          children: state.reviews.map((review) {
                            return ListTile(
                              leading:
                                  const Icon(Icons.star, color: Colors.orange),
                              title: Text(review.userName),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(review.comment),
                                  Text(review.date.toString(),
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.grey)),
                                ],
                              ),
                              trailing: Text(review.rating.toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            );
                          }).toList(),
                        ),
                      );
                    } else if (state is ReviewError) {
                      return Center(child: Text(state.message));
                    } else {
                      log('no reveviw');
                      return const Text(
                        'aaaaa',
                        style: TextStyle(color: Colors.amber),
                      );
                    }
                  },
                ),
              ),
              GestureDetector(
                child: const Text('sssssssssssss'),
                onTap: () {
                  log('onTap dcalled');
                  context.read<ReviewBloc>().add(AddReviewEvent(
                      widget.productId,
                      Review(
                          userId: widget.productId,
                          userName: 'userName',
                          comment: 'comment',
                          rating: 2,
                          date: DateTime.now())));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
