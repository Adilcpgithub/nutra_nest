part of 'user_order_bloc.dart';

abstract class UserOrderState extends Equatable {
  const UserOrderState();

  @override
  List<Object> get props => [];
}

// Initial state
class UserOrderInitial extends UserOrderState {}

// Loading state
class UserOrderLoading extends UserOrderState {}

// Success state (list of orders)
class UserOrderSuccess extends UserOrderState {
  final List<OrderModel> orders;

  const UserOrderSuccess({required this.orders});
}

// Error state
class UserOrderError extends UserOrderState {
  final String message;

  const UserOrderError({required this.message});
}
