import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/features/cart/presentation/model/my_cart_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    on<LoadCart>((event, emit) async {
      try {
        log('is calling ');
        final userId = await UserStatus().getUserId();

        final snapshot =
            await firestore.collection('cartCollection').doc(userId).get();
        log('is calling 2 ');
        if (snapshot.exists) {
          List<Map<String, dynamic>> cartData =
              List<Map<String, dynamic>>.from(snapshot.data()?['cart'] ?? []);
          log('is calling  4');
          log('cartData length is ${cartData.length}');
          List<MyCartModel> mycartDats =
              cartData.map((data) => MyCartModel.fromMap(data)).toList();
          log('mycartDats length is ${mycartDats.length}');
          log(mycartDats.toString());
          emit(CartState(items: mycartDats));
        }
      } catch (e) {
        log(e.toString());
      }
    });

    on<UpdateCartItemCount>((event, emit) {
      final updatedItems = state.items.map((item) {
        if (item.id == event.productId) {
          log('id found ');
          log(event.productId.toString());

          return item.copyWith(productCount: event.count);
        } else {
          log('id not found  ');
        }

        return item;
      }).toList();
      emit(CartState(items: updatedItems));
    });
  }
}
