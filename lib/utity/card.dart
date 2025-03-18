import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';
import 'package:nutra_nest/features/home/presentation/bloc/cycle_list_bloc/bloc/cycle_list_bloc.dart';
import 'package:nutra_nest/model/cycle.dart';
import 'package:nutra_nest/utity/app_logo.dart';
import 'package:nutra_nest/utity/colors.dart';

Widget cycleProductCard(
    {required String imagUrl,
    required VoidCallback funtion,
    required String cycleName,
    required int price,
    required BuildContext context,
    required String id,
    required Cycle cycle}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4, left: 3, right: 3),
    child: Stack(children: [
      GestureDetector(
        onTap: funtion,
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: isDark(context) ? Colors.grey[800] : CustomColors.lightWhite,
            borderRadius: BorderRadius.circular(15),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(appLogo(context))),
                    ),
                    height: 120,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: Stack(children: [
                        Image.network(
                          imagUrl,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                      height: 120,
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
                        ),
                      ]),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              cycleName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: customTextTheme(context),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                size: 23,
                                Icons.star,
                                color: Color.fromARGB(255, 238, 216, 20),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                '4.9',
                                style: TextStyle(
                                    color: customTextTheme(context),
                                    fontSize: 14),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              '₹ $price.00',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: customTextTheme(context),
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
        ),
      ),
      Positioned(
          top: 0,
          right: 0,
          child: BlocBuilder<CycleBloc, CycleState>(
            builder: (context, state) {
              bool favorite = false;
              if (state is CycleLoadedState) {
                favorite = state.favorites.contains(id);
              }

              return InkWell(
                onTap: () async {
                  log('favorite pressed');
                  var userStatus = await UserStatus().getUserId();
                  if (context.mounted) {
                    context
                        .read<CycleBloc>()
                        .add(ToggleFavoriteEvent(id, userStatus));
                  }
                },
                splashColor: Colors.transparent,
                // ignore: deprecated_member_use
                highlightColor: Colors.green.withOpacity(0.4),
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: const BoxDecoration(
                      color: CustomColors.green,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12))),
                  child: AnimatedPadding(
                    duration: const Duration(milliseconds: 300),
                    padding: EdgeInsets.all(favorite ? 6 : 8),
                    child: favorite
                        ? Image.asset('assets/heart.png')
                        : Image.asset('assets/clipart44480.png'),
                  ),
                ),
              );
            },
          )),
    ]),
  );
}
