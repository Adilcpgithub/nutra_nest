import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:nutra_nest/presentation/network/cubit/network_cubit.dart';

class WhishListScreen extends StatelessWidget {
  const WhishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocBuilder<NetworkCubit, bool>(
      builder: (context, isConnected) {
        if (isConnected) {
          return const Center(child: Text('Whish Screen'));
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
    ));
  }
}
