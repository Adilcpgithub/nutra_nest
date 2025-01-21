part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<MyCartModel> cartItems;
  const CartState({required this.cartItems});

  CartState copyWith({List<MyCartModel>? cartItems}) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
    );
  }

  @override
  List<Object> get props => [cartItems];
}

class CartLoaded extends CartState {
  const CartLoaded({required super.cartItems});
}

class CartLoading extends CartState {
  const CartLoading({required super.cartItems});
}
