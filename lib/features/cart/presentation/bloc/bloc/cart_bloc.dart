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
        if (userId.isEmpty) {
          log('user is not logged in !');
          emit(const CartLoaded(cartItems: []));
          return;
        }

        final snapshot =
            await firestore.collection('cartCollection').doc(userId).get();
        if (!snapshot.exists) {
          log('No wishlist found for this user');
          emit(const CartLoaded(cartItems: []));
          return;
        }

        List<Map<String, dynamic>> cartData =
            List<Map<String, dynamic>>.from(snapshot.data()?['cart'] ?? []);

        List<MyCartModel> mycartDats =
            cartData.map((data) => MyCartModel.fromMap(data)).toList();
        if (mycartDats.isEmpty) {
          log('No cart items found');
          emit(const CartLoaded(cartItems: []));
          return;
        }

        emit(CartLoaded(cartItems: mycartDats));
        List<double> totalSumList = mycartDats.map((e) => e.subtotal).toList();
        double totalSum = 0;
        for (var i in totalSumList) {
          totalSum += i;
        }
        emit(ProductTotal(cartItems: state.cartItems, total: totalSum));
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
      List<double> totalSumList =
          state.cartItems.map((e) => e.subtotal).toList();
      double totalSum = 0;
      for (var i in totalSumList) {
        totalSum += i;
      }
      emit(ProductTotal(cartItems: state.cartItems, total: totalSum));

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
        List<double> totalSumList =
            updatedCartItems.map((e) => e.subtotal).toList();
        double totalSum = 0;
        for (var i in totalSumList) {
          totalSum += i;
        }
        emit(ProductTotal(cartItems: state.cartItems, total: totalSum));

        final userId = await UserStatus().getUserId();

        await firestore
            .collection('cartCollection')
            .doc(userId)
            .set({'cart': updatedCartItems.map((e) => e.toMap()).toList()});
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
        List<double> totalSumList =
            state.cartItems.map((e) => e.subtotal).toList();
        double totalSum = 0;
        for (var i in totalSumList) {
          totalSum += i;
        }
        emit(ProductTotal(cartItems: state.cartItems, total: totalSum));

        final userId = await UserStatus().getUserId();

        await firestore
            .collection('cartCollection')
            .doc(userId)
            .set({'cart': updatedCartItems.map((e) => e.toMap()).toList()});
      } catch (e) {
        log(e.toString());
      }
    });
    on<RemoveFromCart>((event, emit) async {
      final userId = await UserStatus().getUserId();
      final existingIndex =
          state.cartItems.indexWhere((item) => item.id == event.productId);
      List<MyCartModel> updatedCartItems = [];
      if (existingIndex != -1) {
        updatedCartItems = List<MyCartModel>.from(state.cartItems);
        updatedCartItems.removeAt(existingIndex);
        emit(state.copyWith(cartItems: updatedCartItems));
        List<double> totalSumList =
            state.cartItems.map((e) => e.subtotal).toList();
        double totalSum = 0;
        for (var i in totalSumList) {
          totalSum += i;
        }
        emit(ProductTotal(cartItems: state.cartItems, total: totalSum));

        await firestore.collection('cartCollection').doc(userId).set(
            {'cart': updatedCartItems.map((item) => item.toMap()).toList()});
      }
    });
  }
}
