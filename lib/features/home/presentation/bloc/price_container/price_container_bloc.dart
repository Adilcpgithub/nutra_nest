import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'price_container_event.dart';
part 'price_container_state.dart';

class PriceContainerBloc
    extends Bloc<PriceContainerEvent, PriceContainerState> {
  PriceContainerBloc() : super(const PriceContainerInitial()) {
    on<ToggleContainerEvent>((event, emit) {
      final currentSelectedIndex = state.selectedIndex;
      // If the same container is tapped, deselect it
      final newSelectedIndex = currentSelectedIndex == event.selectedIndex
          ? null
          : event.selectedIndex;
      emit(state.copyWith(selectedIndex: newSelectedIndex));
    });
  }
}
