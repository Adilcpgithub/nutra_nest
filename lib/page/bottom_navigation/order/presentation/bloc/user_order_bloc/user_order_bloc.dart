import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/features/cart/presentation/model/my_cart_model.dart';
import 'package:nutra_nest/page/bottom_navigation/order/data/models/order_model.dart';
import 'package:nutra_nest/page/bottom_navigation/order/data/repository/order_repository.dart';

part 'user_order_event.dart';
part 'user_order_state.dart';

class UserOrderBloc extends Bloc<UserOrderEvent, UserOrderState> {
  final OrderRepository orderRepository;
  UserStatus userStatus = UserStatus();

  UserOrderBloc({required this.orderRepository}) : super(UserOrderInitial()) {
    // Placing an order
    on<PlaceUserOrder>((event, emit) async {
      emit(UserOrderLoading());
      try {
        final userId = await userStatus.getUserId();
        final order = OrderModel(
          orderId: event.orderId,
          userId: userId,
          address: event.address,
          items: event.products,
          totalPrice: event.totalPrice,
          status: "In Progress",
          createdAt: Timestamp.now(),
        );

        await orderRepository.placeOrder(order);

        // Fetch orders again after placing a new one
        add(FetchUserOrders());
      } catch (e) {
        log('order fething error is $e');
        emit(UserOrderError(message: "Failed to place order: $e"));
      }
    });

    // Fetching user orders
    on<FetchUserOrders>((event, emit) async {
      final userId = await userStatus.getUserId();
      emit(UserOrderLoading());
      try {
        var ordersStream = orderRepository.getUserOrders(userId);
        await emit.forEach(
          ordersStream,
          onData: (orders) => UserOrderSuccess(orders: orders),
        );
      } catch (e) {
        emit(UserOrderError(message: "Failed to load user orders"));
      }
    });
  }
}
