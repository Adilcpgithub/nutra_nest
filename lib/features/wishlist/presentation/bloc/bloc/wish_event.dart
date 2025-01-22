part of 'wish_bloc.dart';

class WishEvent extends Equatable {
  const WishEvent();

  @override
  List<Object> get props => [];
}

class Loadwish extends WishEvent {}

class AddWishToCart extends WishEvent {
  final WishModel product;
  const AddWishToCart(this.product);
  @override
  List<Object> get props => [product];
}
