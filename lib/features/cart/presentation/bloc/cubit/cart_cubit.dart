// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:equatable/equatable.dart';
// import 'package:nutra_nest/auth/auth_service.dart';
// import 'package:nutra_nest/features/cart/presentation/model/my_cart_model.dart';

// part 'cart_state.dart';

// class CartCubit extends Cubit<CartState> {
//   CartCubit() : super(const CartState([]));
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   void getCartProducts() async {
//     //here fetching all products form cart this prodcuts added form the product detailed page inside of home page
//     try {
//       log('is calling ');
//       final userId = await UserStatus().getUserId();

//       final snapshot =
//           await _firestore.collection('cartCollection').doc(userId).get();
//       if (snapshot.exists) {
//         List<Map<String, dynamic>> cartData =
//             List<Map<String, dynamic>>.from(snapshot.data()?['cart'] ?? []);
//         log('cartData length is ${cartData.length}');
//         List<MyCartModel> mycartDats =
//             cartData.map((data) => MyCartModel.fromMap(data)).toList();
//         log('mycartDats length is ${mycartDats.length}');
//         log(mycartDats.toString());
//         emit(CartState(mycartDats));
//       }
//     } catch (e) {
//       log(e.toString());
//     }
//   }
// }
