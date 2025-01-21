import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/features/cart/presentation/model/my_cart_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState(cartItems: [])) {
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
          emit(CartLoaded(cartItems: mycartDats));
        }
      } catch (e) {
        log(e.toString());
      }
    });

    on<AddProductToCart>((event, emit) async {
      final userId = await UserStatus().getUserId();
      final existingIndex =
          state.cartItems.indexWhere((item) => item.id == event.product.id);
      List<MyCartModel> updatedCartItems = [];
      if (existingIndex != -1) {
        // If product already exists, increase the count
        updatedCartItems = List<MyCartModel>.from(state.cartItems);
        final existingItem = updatedCartItems[existingIndex];
        updatedCartItems[existingIndex] = existingItem.copyWith(
          productCount: existingItem.productCount + 1,
        );
        emit(state.copyWith(cartItems: updatedCartItems));
      } else {
        // If product doesn't exist, add it with a count of 1
        emit(state.copyWith(cartItems: [
          ...state.cartItems,
          event.product.copyWith(productCount: 1),
        ]));
      }
      await firestore
          .collection('cartCollection')
          .doc(userId)
          .set({'cart': updatedCartItems.map((item) => item.toMap()).toList()});
    });
    on<IncreaseProductCount>((event, emit) async {
      try {
        log('message');

        final updatedCartItems = state.cartItems.map((item) {
          if (item.id == event.productId) {
            return item.copyWith(productCount: item.productCount + 1);
          }
          return item;
        }).toList();

        emit(state.copyWith(cartItems: updatedCartItems));

        final userId = await UserStatus().getUserId();

        await firestore
            .collection('cartCollection')
            .doc(userId)
            .set({'cart': updatedCartItems.map((e) => e.toMap()).toList()});

        // List<Map<String, dynamic>> cartData = [];
        // if (snapshot.exists &&
        //     snapshot.data() != null &&
        //     snapshot.data()!['cart'] != null) {
        //   log('existes ');
        //   cartData = List<Map<String, dynamic>>.from(snapshot.data()!['cart']);
        //   log('message 3');
        //   List<MyCartModel> currentData =
        //       cartData.map((e) => MyCartModel.fromMap(e)).toList();
        //       int index=currentData.indexWhere((item)=>item.id==event.productId)
        //       updatatedCart
        // }
      } catch (e) {
        log(e.toString());
      }
    });
    on<DecreaseProductCount>((event, emit) async {
      try {
        final updatedCartItems = state.cartItems
            .map((item) {
              if (item.id == event.productId && item.productCount > 1) {
                return item.copyWith(productCount: item.productCount - 1);
              }
              return item;
            })
            .where((item) => item.productCount > 0) // Remove items with count 0
            .toList();

        emit(state.copyWith(cartItems: updatedCartItems));
        final userId = await UserStatus().getUserId();

        await firestore
            .collection('cartCollection')
            .doc(userId)
            .set({'cart': updatedCartItems.map((e) => e.toMap()).toList()});
      } catch (e) {
        log(e.toString());
      }
    });
    // on<UpdateCartItemCount>((event, emit) {
    //   final updatedItems = state.items.map((item) {
    //     if (item.id == event.productId) {
    //       log('id found ');
    //       log(event.productId.toString());

    //       return item.copyWith(productCount: event.count);
    //     } else {
    //       log('id not found  ');
    //     }

    //     return item;
    //   }).toList();
    //   emit(CartState(items: updatedItems));
    // }
    // );
  }
}
