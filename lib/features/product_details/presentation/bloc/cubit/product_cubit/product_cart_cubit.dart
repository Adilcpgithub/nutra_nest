import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:nutra_nest/auth/auth_service.dart';

part 'product_cart_cubit_state.dart';

class ProductCartCubit extends Cubit<ProductCartState> {
  ProductCartCubit() : super(ProductCartState.initial());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void increaseCount() {
    emit(state.copyWith(productCount: state.productCount + 1));
  }

  void decreaseCount() {
    if (state.productCount > 1) {
      emit(state.copyWith(productCount: state.productCount - 1));
    }
  }

  void addToCart(String productId) async {
    emit(state.copyWith(isAddedToCart: true));

    try {
      log('message 1');
      final userId = await UserStatus().getUserId();

      final snapshot =
          await _firestore.collection('cartCollection').doc(userId).get();
      log('message 2');
      if (snapshot.exists) {
        List<Map<String, dynamic>> cartData =
            List<Map<String, dynamic>>.from(snapshot.data()?['cart'] ?? {});
        log('message 3');
        int index =
            cartData.indexWhere((item) => item['productId'] == productId);

        if (index == -1) {
          log('message 4');
          cartData.add(
              {'productId': productId, 'productCount': state.productCount});
          log('product id added to cart collection1');
          await _firestore
              .collection('cartCollection')
              .doc(userId)
              .set({'cart': cartData});
          log('message 5');
        } else {
          if (cartData[index]['productCount'] != state.productCount) {
            cartData[index]['productCount'] = state.productCount;
            try {
              await _firestore
                  .collection('cartCollection')
                  .doc(userId)
                  .set({'cart': cartData});
            } catch (e) {
              log('log from after checking $e');
            }
          }
        }
      }
    } catch (e) {
      log('message 6');
      log(e.toString());
      // emit((state.copyWith(isAddedToCart: false)));
    }
  }

  void removeFromCart(String productId) async {
    emit(state.copyWith(isAddedToCart: false));
    try {
      log('message 1');
      final userId = await UserStatus().getUserId();

      final snapshot =
          await _firestore.collection('cartCollection').doc(userId).get();
      log('message 2');
      if (snapshot.exists) {
        List<Map<String, dynamic>> cartData =
            List<Map<String, dynamic>>.from(snapshot.data()?['cart'] ?? {});
        log('message 3');
        int index =
            cartData.indexWhere((item) => item['productId'] == productId);

        if (index != -1) {
          log('message 4');
          cartData.removeAt(index);
          log('product id removed to cart collection1');
          await _firestore
              .collection('cartCollection')
              .doc(userId)
              .set({'cart': cartData});
          log('cart removed successfully ');
        } else {
          log('no data with product id ');
        }
      }
    } catch (e) {
      log('message 6');
      log(e.toString());
      // emit((state.copyWith(isAddedToCart: false)));
    }
  }
}
