import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cycle_product_detail_bloc_event.dart';
part 'cycle_product_detail_bloc_state.dart';

class CycleProductDetailBlocBloc extends Bloc<CycleProductDetailBlocEvent, CycleProductDetailBlocState> {
  CycleProductDetailBlocBloc() : super(CycleProductDetailBlocInitial()) {
    on<CycleProductDetailBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
