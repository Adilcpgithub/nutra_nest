import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutra_nest/blocs/cycle_bloc/bloc/cycle_bloc.dart';
import 'package:nutra_nest/utity/card.dart';
import 'package:nutra_nest/utity/colors.dart';

class CycleListPage extends StatefulWidget {
  final int cycleTypeNumber;
  const CycleListPage({super.key, required this.cycleTypeNumber});
  @override
  State<CycleListPage> createState() => _CycleListPageState();
}

class _CycleListPageState extends State<CycleListPage> {
  @override
  void initState() {
    context.read<CycleBloc>().add(LoadCycleByType(widget.cycleTypeNumber));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 10),
              _buildHeader(
                context,
              ),
              _showCycleList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
  ) {
    var event = LoadCycleByType(widget.cycleTypeNumber);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            height: 39,
            width: 39,
            decoration: BoxDecoration(
              color: CustomColors.black,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: CustomColors.green, width: 1.5),
            ),
            child: const Icon(
              Icons.arrow_back,
              size: 26,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: Text(
            event.type,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 19,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            height: 39,
            width: 39,
            decoration: BoxDecoration(
              color: CustomColors.black,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: CustomColors.green, width: 1.5),
            ),
            child: const Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _showCycleList() {
    return BlocBuilder<CycleBloc, CycleState>(builder: (context, state) {
      if (state is CycleLoadedState && state.cycles.isNotEmpty) {
        return Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 9,
              mainAxisSpacing: 9,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              final cycle = state.cycles[index];
              return SizedBox(
                height: 100,
                width: double.infinity,
                child: ProductCard(
                    imagUrl: cycle.imageUrl[0],
                    funtion: () {},
                    cycleName: cycle.name,
                    price: cycle.price,
                    deleteFunction: () {},
                    editFuntion: () {}),
              );
            },
            itemCount: state.cycles.length,
          ),
        );
      } else if (state is CycleLoadedState && state.cycles.isEmpty) {
        log('cycle is empty ');
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: CustomColors.green, width: 2)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  8,
                ),
                child: Image.asset(
                  'assets/No Data Found.jpg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );
      } else if (state is CycleLoadingState) {
        return SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: const Center(
                child: CircularProgressIndicator(
              color: CustomColors.green,
            )));
      } else if (state is CycleErrorState) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                state.error,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      } else {
        return const Center(
            child: Text(
          'ddkkkkkk',
          style: TextStyle(color: Colors.red),
        ));
      }
    });
  }
}
