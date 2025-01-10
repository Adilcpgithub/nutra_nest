import 'dart:developer';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/blocs/image_bloc/bloc/image_bloc.dart';
import 'package:nutra_nest/features/product_details/presentation/bloc/cycle_list_bloc/bloc/cycle_list_bloc.dart';
import 'package:nutra_nest/model/cycle.dart';

import 'package:nutra_nest/utity/colors.dart';
import 'package:nutra_nest/widgets/custom_textbutton.dart';
import 'package:nutra_nest/widgets/icons_widget.dart';

class ProductDetails extends StatefulWidget {
  final Cycle cycle;
  const ProductDetails({super.key, required this.cycle});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late PageController _pageController;
  final List<String> images = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ97LQR6VpYTM9B2O-xR5TeoQ11BjnHOVQeDZPLL_vrhcebI5FbmpMwxzv7k5MIpKYQF7I&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZnPSfjT2pxqBnDiFMoI5NjIoalAgmkOqwTg&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxJvN-EDXpF4r34NX2iErtZUyk3ejpzm9avg&s',
  ];
  final int rating = 4;
  bool isExpanded = false;
  String sampleData =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Why do we use it?It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).Where does it come from?Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sy";

  //! here the for sample remove with actual data
  bool favorite = false;
  late ScrollController scrollController;
  bool isAtBottom = false;
  int data = 1;

  //!-----------------------------------------
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

  @override
  void initState() {
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
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Stack(children: [
            SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  customSizedBox(10),
                  buildHeader(context),
                  customSizedBox(30),
                  buildCycleImages(_pageController, images),
                  customSizedBox(10),
                  buildImageIconsAndFavorite(context, images, widget.cycle.id),
                  customSizedBox(20),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.cycle.name,
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
                          Container(
                            height: 30,
                            width: 75,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: CustomColors.green2,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      if (data >= 2) {
                                        setState(() {
                                          data = data - 1;
                                        });
                                      }
                                      print('Minus tapped');
                                    },
                                    splashColor: Colors.grey.withOpacity(0.3),
                                    highlightColor:
                                        Colors.grey.withOpacity(0.1),
                                    child: const Center(
                                      child: Text(
                                        '-',
                                        style: TextStyle(
                                          color: CustomColors.gray2,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      '$data',
                                      style: const TextStyle(
                                        color: CustomColors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        data = data + 1;
                                      });
                                    },
                                    splashColor: Colors.grey.withOpacity(0.3),
                                    highlightColor:
                                        Colors.grey.withOpacity(0.1),
                                    child: const Center(
                                      child: Text(
                                        '+',
                                        style: TextStyle(
                                          color: CustomColors.gray2,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
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
                                'Brand : ${widget.cycle.name}',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
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
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  top: 1, bottom: 1, left: 2, right: 2),
                              child: Text(
                                ' in stock ',
                                style: TextStyle(
                                  color: CustomColors.white,
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
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 1, bottom: 1, left: 2, right: 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    'rating ',
                                    style: TextStyle(
                                      color: CustomColors.white,
                                    ),
                                  ),
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
                            ),
                          ),
                        ],
                      ),
                      customSizedBox(3),
                      const Row(
                        children: [
                          Text(
                            'Weight : 25 Kg',
                            style: TextStyle(
                              color: CustomColors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      customSizedBox(3),
                      Row(
                        children: [
                          Text(
                            textAlign: TextAlign.left,
                            '₹${widget.cycle.price}.00',
                            style: const TextStyle(
                                color: CustomColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      customSizedBox(5),
                      const Row(
                        children: [
                          Text(
                            'Description',
                            style: TextStyle(
                              color: CustomColors.white,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                      customSizedBox(3),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              maxLines: 40,
                              sampleData,
                              style: const TextStyle(
                                color: CustomColors.white,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
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
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(
                                  width: 1, color: CustomColors.green2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 2, bottom: 2, left: 3, right: 3),
                              child: Text(
                                isAtBottom ? 'Show less' : 'Show more',
                                style: const TextStyle(
                                  color: CustomColors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Stack(alignment: Alignment.center, children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.5),
                                blurRadius: 15,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                        ),
                        CustomTextbutton(
                            color: CustomColors.green,
                            buttomName: 'START SHOPPING',
                            voidCallBack: () async {}),
                      ]),
                    ],
                  ),
                ))
          ]),
        ),
      ),
    );
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
      CustomIcon(onTap: () {}, icon: Icons.search, iconSize: 29)
    ],
  );
}

Widget buildCycleImages(PageController pageController, List<String> images) {
  return SizedBox(
    height: 230,
    child: Expanded(
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
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3, shadowColor: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  //  elevation: 7,
                  //   shadowColor: Colors.red,
                  //   color: Colors.white,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: 230,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      //border: Border.all(color: CustomColors.green, width: 2),
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(
                          images[index],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            });
      }),
    ),
  );
}

Widget buildImageIconsAndFavorite(
    BuildContext contex, List<String> images, String id) {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Expanded(
      child: BlocBuilder<ImageBloc, ImageState>(builder: (context, state) {
        int currentIdex = 0;
        if (state is ImageIndexUpdated) {
          currentIdex = state.currentIndex;
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            images.length,
            (index) => GestureDetector(
              onTap: () {
                context.read<ImageBloc>().add(PageChangedEvent(index));
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 6),
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1.5,
                      color: currentIdex == index
                          ? CustomColors.white
                          : CustomColors.black),
                  color: CustomColors.black,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    width: 9,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    ),
    BlocBuilder<CycleBloc, CycleState>(
      builder: (context, state) {
        bool favorite = false;
        if (state is CycleLoadedState) {
          favorite = state.favorites.contains(id);
        }

        return InkWell(
          onTap: () async {
            log('favorite pressed');
            var userStatus = await UserStatus().getUserId();

            // ignore: use_build_context_synchronously
            context.read<CycleBloc>().add(ToggleFavoriteEvent(id, userStatus));
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.green.withOpacity(0.4),
          child: Container(
            height: 39,
            width: 39,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: CustomColors.green),
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
