part of 'price_container_bloc.dart';

class PriceContainerState extends Equatable {
  final int? selectedIndex;
  const PriceContainerState({this.selectedIndex});
  PriceContainerState copyWith({int? selectedIndex}) {
    return PriceContainerState(selectedIndex: selectedIndex);
  }

  @override
  List<Object?> get props => [selectedIndex];
}

final class PriceContainerInitial extends PriceContainerState {
  const PriceContainerInitial() : super(selectedIndex: null);
}
