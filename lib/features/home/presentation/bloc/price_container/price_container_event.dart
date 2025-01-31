part of 'price_container_bloc.dart';

sealed class PriceContainerEvent extends Equatable {
  const PriceContainerEvent();

  @override
  List<Object> get props => [];
}

class ToggleContainerEvent extends PriceContainerEvent {
  final int selectedIndex; // Index of the tapped container

  const ToggleContainerEvent(this.selectedIndex);
  @override
  List<Object> get props => [selectedIndex];
}
