import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/blocs/cycle_bloc/bloc/cycle_bloc.dart';
import 'package:nutra_nest/utity/colors.dart';

Widget cycleProductCard({
  required String imagUrl,
  required VoidCallback funtion,
  required String cycleName,
  required String price,
  required BuildContext context,
  required String id,
}) {
  return Card(
    elevation: 5,
    color: CustomColors.gray,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: CustomColors.green, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
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
                                'assets/NutraNestPo.png',
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
                    return const Center(
                        child: Icon(
                      Icons.error,
                      color: Colors.red,
                    ));
                  },
                ),
                Positioned(
                    top: 8,
                    right: 8,
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

                            context
                                .read<CycleBloc>()
                                .add(ToggleFavoriteEvent(id, userStatus));
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.green.withOpacity(0.4),
                          child: Container(
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: CustomColors.green),
                                color: const Color.fromARGB(134, 8, 208, 98),
                                borderRadius: BorderRadius.circular(15)),
                            child: AnimatedPadding(
                              duration: const Duration(milliseconds: 300),
                              padding: EdgeInsets.all(favorite ? 3 : 5),
                              child: favorite
                                  ? Image.asset('assets/heart.png')
                                  : Image.asset('assets/clipart44480.png'),
                            ),
                          ),
                        );
                      },
                    ))
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 4),
                    child: Text(
                      cycleName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      '₹ $price',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: CustomColors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: funtion,
                    child: Container(
                      decoration: BoxDecoration(
                          color: CustomColors.black,
                          borderRadius: BorderRadius.circular(6),
                          border:
                              Border.all(color: CustomColors.green, width: 1)),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 8, right: 8, top: 2, bottom: 2),
                        child: Text(
                          'View Product',
                          style: TextStyle(
                            fontSize: 14,
                            color: CustomColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
