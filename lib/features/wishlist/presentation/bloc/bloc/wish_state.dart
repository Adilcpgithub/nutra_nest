part of 'wish_bloc.dart';

class WishState extends Equatable {
  final List<WishModel> wishItems;
  const WishState({required this.wishItems});

  @override
  List<Object> get props => [wishItems];
}

class CartLoading extends WishState {
  const CartLoading({required super.wishItems});
}

class CartLoaded extends WishState {
  const CartLoaded({required super.wishItems});
}
