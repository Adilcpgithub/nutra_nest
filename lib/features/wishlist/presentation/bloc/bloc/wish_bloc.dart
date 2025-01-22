import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutra_nest/features/wishlist/presentation/model/wish_model.dart';

part 'wish_event.dart';
part 'wish_state.dart';

class WishBloc extends Bloc<WishEvent, WishState> {
  WishBloc() : super(const WishState(wishItems: [])) {
    on<WishEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
