import 'package:cloudinary_url_gen/transformation/region.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutra_nest/blocs/image_bloc/bloc/image_bloc.dart';
import 'package:nutra_nest/utity/colors.dart';
import 'package:nutra_nest/widgets/icons_widget.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({super.key});

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
              SizedBox(
                height: 230,
                child: Expanded(
                  child: BlocBuilder<ImageBloc, ImageState>(
                      builder: (context, state) {
                    if (state is ImageIndexUpdated) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (_pageController.hasClients &&
                            _pageController.page != state.currentIndex) {
                          _pageController.animateToPage(state.currentIndex,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.ease);
                        }
                      });
                    }
                    return PageView.builder(
                        onPageChanged: (index) {
                          context
                              .read<ImageBloc>()
                              .add(PageChangedEvent(index));
                        },
                        controller: _pageController,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 230,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: CustomColors.green, width: 2),
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    images[index],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        });
                  }),
                ),
              ),
              customSizedBox(10),
              BlocBuilder<ImageBloc, ImageState>(builder: (context, state) {
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
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              })
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
