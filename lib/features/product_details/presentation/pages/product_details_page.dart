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
  //! here the for sample remove with actual data
  bool favorite = false;
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
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
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        height: 25,
                        width: 65,
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: CustomColors.green2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '-',
                              style: TextStyle(
                                color: CustomColors.gray2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '1',
                              style: TextStyle(
                                color: CustomColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '+',
                              style: TextStyle(
                                color: CustomColors.gray2,
                                fontWeight: FontWeight.bold,
                              ),
                            )
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
                          border:
                              Border.all(width: 1, color: CustomColors.green2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              top: 1, bottom: 1, left: 2, right: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                ' in stock ',
                                style: TextStyle(
                                  color: CustomColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //!------------------------------
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              top: 1, bottom: 1, left: 2, right: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                ' rating ',
                                style: TextStyle(
                                  color: CustomColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
                  elevation: 6, shadowColor: Colors.white,

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
