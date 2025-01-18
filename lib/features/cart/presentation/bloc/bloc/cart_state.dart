part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<MyCartModel> items;
  const CartState({this.items = const []});

  CartState copyWith({List<MyCartModel>? items}) {
    return CartState(
      items: items ?? this.items,
    );
  }

  @override
  List<Object> get props => [items];
}

class CartLoading extends CartState {}
