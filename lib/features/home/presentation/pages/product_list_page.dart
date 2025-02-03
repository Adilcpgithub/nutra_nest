import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:nutra_nest/blocs/search_bloc/bloc/search_bloc_bloc.dart';
import 'package:nutra_nest/features/home/presentation/bloc/cycle_list_bloc/bloc/cycle_list_bloc.dart';
import 'package:nutra_nest/features/home/presentation/bloc/price_container/price_container_bloc.dart';
import 'package:nutra_nest/features/home/presentation/pages/product_details_page.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';
import 'package:nutra_nest/utity/card.dart';
import 'package:nutra_nest/utity/colors.dart';
import 'package:nutra_nest/utity/navigation.dart';
import 'package:nutra_nest/widgets/icons_widget.dart';
import 'package:nutra_nest/widgets/textformfield.dart';

class CycleListPage extends StatefulWidget {
  final int cycleTypeNumber;
  const CycleListPage({super.key, required this.cycleTypeNumber});
  @override
  State<CycleListPage> createState() => _CycleListPageState();
}

class _CycleListPageState extends State<CycleListPage> {
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    context.read<CycleBloc>().add(LoadCycleByType(widget.cycleTypeNumber));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final searchBarBloc = context.read<SearchBlocBloc>();
    if (searchBarBloc.state is SearchBarVisible) {
      searchBarBloc.add(ToggleSearchBarEvent());
    }
    final pricecontainerbloc = context.read<PriceContainerBloc>();
    if (pricecontainerbloc.state.selectedIndex != null) {
      pricecontainerbloc
          .add((ToggleContainerEvent(pricecontainerbloc.state.selectedIndex!)));
    }
    searchController.clear();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              sizedBox10(),
              buildHeader(context),
              sizedBox10(),
              buildSearchBar(widget.cycleTypeNumber, context, searchController),
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
        CustomIcon(
            onTap: () {
              Navigator.of(context).pop();
              final searchBarBloc = context.read<SearchBlocBloc>();
              if (searchBarBloc.state is SearchBarVisible) {
                searchBarBloc.add(ToggleSearchBarEvent());
              }
              final pricecontainerbloc = context.read<PriceContainerBloc>();
              if (pricecontainerbloc.state.selectedIndex != null) {
                pricecontainerbloc.add((ToggleContainerEvent(
                    pricecontainerbloc.state.selectedIndex!)));
              }
            },
            icon: Icons.arrow_back,
            iconSize: 26),
        Expanded(
          child: Text(
            event.type,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 19,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.bodySmall!.color,
            ),
          ),
        ),
        CustomIcon(
            onTap: () {
              log('pressed');
              context.read<SearchBlocBloc>().add(ToggleSearchBarEvent());
              final pricecontainerbloc = context.read<PriceContainerBloc>();
              //this fountion for  romove price selected data when search feild cloased
              if (pricecontainerbloc.state.selectedIndex != null) {
                pricecontainerbloc.add((ToggleContainerEvent(
                    pricecontainerbloc.state.selectedIndex!)));
              }
              searchController.clear();
            },
            icon: Icons.search,
            iconSize: 29)
      ],
    );
  }

  Widget buildSearchBar(int cycleTypeNumber, BuildContext context,
      TextEditingController searchController) {
    return BlocBuilder<SearchBlocBloc, SearchBlocState>(
      builder: (context, state) {
        if (state is SearchBarVisible) {
          return FadeInDown(
            duration: const Duration(milliseconds: 500),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 68,
                          child: CustomTextFormField(
                            onChanged: (data) {
                              log('seach data is  $data');
                              if (data.isEmpty) {
                                context
                                    .read<CycleBloc>()
                                    .add(LoadCycleByType(cycleTypeNumber));
                              } else {
                                log('search data is not empty ');
                                final priceContainerState =
                                    context.read<PriceContainerBloc>().state;
                                final selectedPriceIndex =
                                    priceContainerState.selectedIndex;
                                log('selected price index :$selectedPriceIndex');
                                context.read<CycleBloc>().add(SearchCycles(
                                    typeNumber: cycleTypeNumber,
                                    pricetypeNumber: selectedPriceIndex,
                                    cycleNameOrBrand:
                                        searchController.text.trim()));
                              }
                            },
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 23),
                              child: Icon(
                                Icons.search,
                                size: 30,
                                color: customTextTheme(context),
                              ),
                            ),
                            controller: searchController,
                            labelText: 'Search',
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
                _buildActiveFilters(context),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildActiveFilters(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _filterChip(
            context,
            'under - ₹10k',
            0,
          ),
          _filterChip(
            context,
            '₹10k - ₹20k',
            1,
          ),
          _filterChip(
            context,
            'above - ₹30k',
            2,
          )
        ],
      ),
    );
  }

  Widget _filterChip(BuildContext context, String label, int index) {
    return BlocBuilder<PriceContainerBloc, PriceContainerState>(
      builder: (context, state) {
        log(' now state id  is  ${state.selectedIndex}');
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () {
              log('onTap form Seachselection controller index is $index');
              context
                  .read<PriceContainerBloc>()
                  .add(ToggleContainerEvent(index));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color:
                    state.selectedIndex != null && state.selectedIndex == index
                        ? CustomColors.green
                        : appTheme(context),
                //!changed button color to identify the selection
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: CustomColors.green),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: state.selectedIndex != null &&
                              state.selectedIndex == index
                          ? Colors.white
                          : CustomColors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
        );
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
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 5,
                  childAspectRatio: 0.76,
                ),
                itemCount: state.cycles.length,
                itemBuilder: (context, index) {
                  final cycle = state.cycles[index];

                  return SizedBox(
                    height: 180,
                    // width: double.infinity,
                    child: cycleProductCard(
                      cycle: cycle,
                      context: context,
                      id: cycle.id,
                      imagUrl: cycle.imageUrl[0],
                      funtion: () {
                        log('dddd');
                        CustomNavigation.push(
                            context,
                            ProductDetails(
                              cycle: cycle,
                              fromCart: false,
                              productId: cycle.id,
                            ));
                      },
                      cycleName: cycle.name,
                      price: cycle.price,
                    ),
                  );
                },
              ),
            );
          } else if (state is SearchIsEmpty) {
            return Container();
          } else {
            return Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          height: deviceHeight(context) / 2,
                          width: deviceWidth(context) / 3,
                          'assets/Animation - 1736829505158.json',
                        ),
                      ]),
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
        } else if (state is SearchIsEmpty) {
          return Expanded(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/Animation - 1738300675103.json',
                    height: deviceWidth(context) / 2),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'No result found!',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodySmall!.color,
                  ),
                )
              ],
            )),
          );
        } else {
          return const Expanded(
            child: Center(
              child: Text(
                'Something Went Wrong',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.red),
              ),
            ),
          );
        }
      },
    );
  }
}
