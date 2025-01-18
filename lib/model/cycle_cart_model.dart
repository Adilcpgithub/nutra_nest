class CycleCartModel {
  final String id;
  final String name;
  final String price;
  final String imageUrl;
  final String category;
  final String shippingAmount;
  final String productCount;
  CycleCartModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.imageUrl,
      required this.category,
      required this.shippingAmount,
      required this.productCount});
  CycleCartModel copytWith(
    String? id,
    String? name,
    String? price,
    String? imageUrl,
    String? category,
    String? shippingAmount,
    String? productCount,
  ) {
    return CycleCartModel(
        id: id ?? '',
        name: name ?? '',
        price: price ?? '',
        imageUrl: imageUrl ?? '',
        category: category ?? '',
        shippingAmount: shippingAmount ?? '',
        productCount: productCount ?? '');
  }

  factory CycleCartModel.fromMap(Map<String, dynamic> map) {
    return CycleCartModel(
        id: map['documentId'] ?? '',
        name: map['name'] ?? '',
        price: map['price'] ?? '',
        imageUrl: map['imageUrl'] ?? '',
        category: map['category'] ?? '',
        shippingAmount: map['shippingAmount'] ?? '',
        productCount: map['productCount'] ?? '');
  }
}
