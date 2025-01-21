part of 'cart_bloc.dart';

class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {}

class AddProductToCart extends CartEvent {
  final MyCartModel product;
  const AddProductToCart(this.product);
  @override
  List<Object> get props => [product];
}

class IncreaseProductCount extends CartEvent {
  final String productId;
  const IncreaseProductCount(this.productId);
  @override
  List<Object> get props => [productId];
}

class DecreaseProductCount extends CartEvent {
  final String productId;
  const DecreaseProductCount(this.productId);
  @override
  List<Object> get props => [productId];
}
