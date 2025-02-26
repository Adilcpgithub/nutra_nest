part of 'user_order_bloc.dart';

abstract class UserOrderEvent extends Equatable {
  const UserOrderEvent();
  @override
  List<Object> get props => [];
}

// Event to place an order
class PlaceUserOrder extends UserOrderEvent {
  final String orderId;
  final Map<String, dynamic> address;
  final List<MyCartModel> products;
  final double totalPrice;

  const PlaceUserOrder({
    required this.orderId,
    required this.address,
    required this.products,
    required this.totalPrice,
  });

  @override
  List<Object> get props => [orderId, address, products, totalPrice];
}

// Event to fetch user orders
class FetchUserOrders extends UserOrderEvent {
  const FetchUserOrders();
}
