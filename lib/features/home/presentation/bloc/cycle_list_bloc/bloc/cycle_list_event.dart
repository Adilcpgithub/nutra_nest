part of 'cycle_list_bloc.dart';

sealed class CycleEvent extends Equatable {
  const CycleEvent();

  @override
  List<Object> get props => [];
}

class LoadCycleByType extends CycleEvent {
  static List<String> cycleTypeList = [
    'Mountain Bike',
    'Road Bike',
    'Hybrid',
    'Electric Bikes',
    "Kids' Bikes",
    'Folding Bikes'
  ];
  final String type;
  final int typeNumber;

  LoadCycleByType(
    this.typeNumber,
  ) : type = cycleTypeList[typeNumber - 1];
  @override
  List<Object> get props => [type, typeNumber, cycleTypeList];
}

class ToggleFavoriteEvent extends CycleEvent {
  final String productId;
  final String userId;

  const ToggleFavoriteEvent(this.productId, this.userId);

  @override
  List<Object> get props => [productId];
}

// ignore: must_be_immutable
class SearchCycles extends CycleEvent {
  static List<String> cycleTypeList = [
    'Mountain Bike',
    'Road Bike',
    'Hybrid',
    'Electric Bikes',
    "Kids' Bikes",
    'Folding Bikes'
  ];
  static List<String> priceList = ['under-₹10k', '₹10k-₹20k', 'above-₹30k'];
  final String category;
  final int typeNumber;
  String? cycleNameOrBrand;
  String? priceRange;
  int? pricetypeNumber;

  SearchCycles(
      {required this.typeNumber,
      required this.cycleNameOrBrand,
      this.pricetypeNumber})
      : category = cycleTypeList[typeNumber - 1],
        priceRange = pricetypeNumber != null &&
                pricetypeNumber >= 0 &&
                pricetypeNumber < priceList.length
            ? priceList[pricetypeNumber]
            : null;
  @override
  List<Object> get props => [cycleTypeList, category, typeNumber];
  @override
  String toString() {
    return 'SearchCycles(category: $category, typeNumber: $typeNumber, cycleNameOrBrand: $cycleNameOrBrand, priceRange: $priceRange, pricetypeNumber: $pricetypeNumber)';
  }
}
