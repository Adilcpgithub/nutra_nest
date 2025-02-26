import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutra_nest/page/bottom_navigation/order/data/models/order_model.dart';

class OrderRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
}
