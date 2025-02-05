import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/features/wishlist/presentation/model/wish_model.dart';

part 'wish_event.dart';
part 'wish_state.dart';

class WishBloc extends Bloc<WishEvent, WishState> {
  WishBloc() : super(const WishState(wishItems: [])) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    on<LoadwishList>((event, emit) async {
      log('loadwish calling');

      try {
        // Step 1: Get user ID
        final userId = await UserStatus().getUserId();
        if (userId.isEmpty) {
          log('User is not logged in!');
          emit(const WishLoaded(wishItems: []));
          return;
        }

        log('message 2');

        // Step 2: Fetch wishlist data
        final snapshotFavorite =
            await firestore.collection('favoriteCollection').doc(userId).get();

        if (!snapshotFavorite.exists) {
          log('No wishlist found for this user');
          emit(const WishLoaded(wishItems: []));
          return;
        }

        log('message 3');

        // Step 3: Extract favorites list
        List<dynamic> favorites = snapshotFavorite.data()?['favorites'] ?? [];
        List<String> datas = favorites.map((e) => e.toString()).toList();

        if (datas.isEmpty) {
          log('No wishlist items found');
          emit(const WishLoaded(wishItems: []));
          return;
        }

        log('message 4');

        // Step 4: Fetch cycle details from Firestore
        QuerySnapshot querySnapshot = await firestore
            .collection('cycles')
            .where(FieldPath.documentId, whereIn: datas)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          var wishtData = querySnapshot.docs.map((doc) {
            return WishModel.fromMap(
                {...doc.data() as Map<String, dynamic>, 'documentId': doc.id});
          }).toList();

          log('Fetched ${wishtData.length} wishlist items');

          emit(WishLoaded(wishItems: wishtData));
        } else {
          log('No matching wishlist items found');
          emit(const WishLoaded(wishItems: []));
        }
      } catch (e) {
        log('Error loading wishlist: $e');
        emit(const WishLoaded(wishItems: []));
      }
    });

    on<RemoveFromWish>((event, emit) async {
      final userId = await UserStatus().getUserId();
      final ref = firestore.collection('favoriteCollection').doc(userId);

      final existingIndex =
          state.wishItems.indexWhere((item) => item.id == event.productId);
      List<WishModel> updatedWishItems = [];
      if (existingIndex != -1) {
        updatedWishItems = List<WishModel>.from(state.wishItems);
        updatedWishItems.removeAt(existingIndex);
        emit(state.copyWith(wishItems: updatedWishItems));
        final snapshotFavorite = await ref.get();
        if (snapshotFavorite.exists) {
          List<dynamic> favorites = snapshotFavorite.data()?['favorites'] ?? [];
          List<String> datas = favorites.map((e) => e.toString()).toList();
          // Log the fetched data for debugging
          log('Existing favorites: $datas');
          log('Product to remove: ${event.productId}');
          // Check if the product ID exists in the list
          int index = datas.indexOf(event.productId);
          if (index != -1) {
            log('Index found: $index');
            datas.removeAt(index);
            ref.set({'favorites': datas});
            await ref.set({'favorites': datas});
            log('Product removed successfully and favorites updated');
          } else {
            log('Product not found in favorites');
          }
        }
      }
    });
    on<AddWishToCart>((event, emit) async {
      try {
        final userId = await UserStatus().getUserId();
        final ref = firestore.collection('cartCollection').doc(userId);
        log('proccessing ');

        final snapshot = await ref.get();
        log('message 2');
        List<Map<String, dynamic>> cartData = [];
        if (snapshot.exists &&
            snapshot.data() != null &&
            snapshot.data()!['cart'] != null) {
          log('existes ');
          cartData = List<Map<String, dynamic>>.from(snapshot.data()!['cart']);
        }
        int index =
            cartData.indexWhere((item) => item['productId'] == event.productId);
        if (index == -1) {
          final addWishModel = event.wishModel;
          WishModel wishModel = WishModel(
              id: event.productId,
              name: addWishModel.name,
              price: addWishModel.price,
              imageUrl: addWishModel.imageUrl,
              brand: addWishModel.brand,
              productCount: addWishModel.productCount);
          cartData.add(wishModel.toMap());
          log('product id added to cart from wish');
          await ref.set({'cart': cartData});
          emit(WishDataAddSuccessful(
              wishItems: state.wishItems, message: 'Product added to cart'));
        }
      } catch (e) {
        log('error forom Wish data adding to the cart list $e');
      }
    });
  }
}
