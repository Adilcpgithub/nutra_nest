part of 'wish_bloc.dart';

class WishEvent extends Equatable {
  const WishEvent();

  @override
  List<Object> get props => [];
}

class LoadwishList extends WishEvent {}

class AddWishToCart extends WishEvent {
  final WishModel wishModel;
  final String productId;
  const AddWishToCart(this.productId, this.wishModel);
  @override
  List<Object> get props => [productId, wishModel];
}

class RemoveFromWish extends WishEvent {
  final String productId;
  const RemoveFromWish(this.productId);
  @override
  List<Object> get props => [productId];
}
