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

class SearchCycles extends CycleEvent {
  final String query;
  const SearchCycles(this.query);
  @override
  List<Object> get props => [query];
}

class ToggleFavoriteEvent extends CycleEvent {
  final String productId;
  final String userId;

  const ToggleFavoriteEvent(this.productId, this.userId);

  @override
  List<Object> get props => [productId];
}
