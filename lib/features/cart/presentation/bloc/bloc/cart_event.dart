part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {}

class UpdateCartItemCount extends CartEvent {
  final String productId;
  final int count;

  const UpdateCartItemCount({required this.productId, required this.count});
  @override
  List<Object> get props => [productId, count];
}
