part of 'product_cart_cubit.dart';

class ProductCartState extends Equatable {
  final int productCount;
  final bool isAddedToCart;
  const ProductCartState(
      {required this.productCount, required this.isAddedToCart});
  factory ProductCartState.initial() {
    return const ProductCartState(productCount: 1, isAddedToCart: false);
  }
  ProductCartState copyWith({int? productCount, bool? isAddedToCart}) {
    return ProductCartState(
        productCount: productCount ?? this.productCount,
        isAddedToCart: isAddedToCart ?? this.isAddedToCart);
  }

  @override
  List<Object> get props => [productCount, isAddedToCart];
}
