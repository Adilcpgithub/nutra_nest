import 'package:equatable/equatable.dart';

class MyCartModel extends Equatable {
  final String id;
  final String name;
  final String price;
  final String imageUrl;
  final String brand;
  final int productCount;
  const MyCartModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.imageUrl,
      required this.brand,
      required this.productCount});
  factory MyCartModel.fromMap(Map<String, dynamic> map) {
    return MyCartModel(
        id: map['product'] ?? '',
        name: map['name'] ?? '',
        price: map['price'] ?? '',
        imageUrl: map['imageUrl'] ?? '',
        brand: map['brand'] ?? '',
        productCount: map['productCount'] ?? 1);
  }
  MyCartModel copyWith({
    String? id,
    String? name,
    String? price,
    String? imageUrl,
    String? brand,
    int? productCount,
  }) {
    return MyCartModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      brand: brand ?? this.brand,
      productCount: productCount ?? this.productCount,
    );
  }

  @override
  List<Object?> get props => [id, name, price, imageUrl, brand, productCount];
}
