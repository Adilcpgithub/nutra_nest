import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/page/bottom_navigation/order/data/models/order_model.dart';

class OrderRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserStatus userStatus = UserStatus();

  // Place Order in Firestore
  Future<void> placeOrder(OrderModel order) async {
    try {
      await _firestore
          .collection('orders')
          .doc(order.orderId)
          .set(order.toMap());
    } catch (e) {
      throw Exception("Failed to place order: $e");
    }
  }

  // Fetch User Orders from Firestore
  Stream<List<OrderModel>> getUserOrders(String userId) {
    return _firestore
        .collection("orders")
        .where("userId", isEqualTo: userId)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => OrderModel.fromMap(doc.data()))
            .toList());
  }

  //! Fetching all User purchased Product
  addPurchasedProductsIds(List<String> productIds) async {
    final userId = await userStatus.getUserId();
    var snapshot = await _firestore.collection('users').doc(userId).get();
    List<String> purchasedProducts = [];
    if (snapshot.exists) {
      // Get the purchasedProducts list
      var data = snapshot.data();
      if (data != null && data['purchasedProducts'] != null) {
        purchasedProducts = List<String>.from(data['purchasedProducts']);
      }

      log('snapshot products $purchasedProducts');
    }
    purchasedProducts.addAll(productIds);
    purchasedProducts = purchasedProducts.toSet().toList(); // Remove duplicates

    log('snapshot products $purchasedProducts');
    await _firestore
        .collection('users')
        .doc(userId)
        .set({'purchasedProducts': purchasedProducts}, SetOptions(merge: true));
    log('completed');
  }
}
