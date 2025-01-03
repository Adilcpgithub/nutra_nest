import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutra_nest/blocs/cycle_bloc/bloc/cycle_bloc.dart';
import 'package:nutra_nest/blocs/search_bloc/bloc/search_bloc_bloc.dart';
import 'package:nutra_nest/utity/card.dart';
import 'package:nutra_nest/utity/colors.dart';
import 'package:nutra_nest/widgets/textformfield.dart';

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
              sizedBox10(),
              buildHeader(context),
              sizedBox10(),
              buildSearchBar(),
              sizedBox10(),
              showCycleList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget sizedBox10() {
    return const SizedBox(height: 10);
  }

  Widget buildHeader(
    BuildContext context,
  ) {
    var event = LoadCycleByType(widget.cycleTypeNumber);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            final searchBarBloc = context.read<SearchBlocBloc>();
            if (searchBarBloc.state is SearchBarVisible) {
              searchBarBloc.add(ToggleSearchBarEvent());
            }
          },
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
        Material(
          color: Colors.transparent, // Keeps the background transparent
          child: Ink(
            decoration: BoxDecoration(
              color: CustomColors.black,
              borderRadius:
                  BorderRadius.circular(10), // Match the rounded corners
              border: Border.all(color: CustomColors.green, width: 1.5),
            ),
            child: InkWell(
              borderRadius:
                  BorderRadius.circular(10), // Match the border radius
              splashColor: Colors.grey.withOpacity(0.3), // Splash effect
              highlightColor: Colors.grey.withOpacity(0.1), // Highlight effect
              onTap: () {
                log('pressed');
                context.read<SearchBlocBloc>().add(ToggleSearchBarEvent());
              },
              child: const SizedBox(
                height: 39,
                width: 39,
                child: Icon(
                  Icons.search,
                  size: 29,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSearchBar() {
    final TextEditingController searchCountroller = TextEditingController();
    return BlocBuilder<SearchBlocBloc, SearchBlocState>(
      builder: (context, state) {
        if (state is SearchBarVisible) {
          return FadeInDown(
            duration: const Duration(milliseconds: 500),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: SizedBox(
                    height: 68,
                    child: CustomTextFormField(
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 20, right: 23),
                        child: Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      controller: searchCountroller,
                      labelText: 'Search',
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget showCycleList() {
    return BlocBuilder<CycleBloc, CycleState>(
      builder: (context, state) {
        if (state is CycleLoadedState) {
          if (state.cycles.isNotEmpty) {
            return Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 0.7,
                ),
                itemCount: state.cycles.length,
                itemBuilder: (context, index) {
                  final cycle = state.cycles[index];

                  return SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: cycleProductCard(
                      context: context,
                      id: cycle.id,
                      imagUrl: cycle.imageUrl[0],
                      funtion: () {},
                      cycleName: cycle.name,
                      price: cycle.price,
                    ),
                  );
                },
              ),
            );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: CustomColors.green, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/No Data Found.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            );
          }
        } else if (state is CycleLoadingState) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: const Center(
              child: CircularProgressIndicator(
                color: CustomColors.green,
              ),
            ),
          );
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
              '404',
              style: TextStyle(color: Colors.red),
            ),
          );
        }
      },
    );
  }
}
