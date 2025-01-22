import 'package:equatable/equatable.dart';

class WishModel extends Equatable {
  final String id;
  final String name;
  final String price;
  final String imageUrl;
  final String brand;
  final int productCount;

  const WishModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.imageUrl,
      required this.brand,
      required this.productCount});
  Map<String, dynamic> toMap() {
    return {
      'productId': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'brand': brand,
      'productCount': productCount,
    };
  }

  factory WishModel.fromMap(Map<String, dynamic> map) {
    return WishModel(
        id: map['productId'] ?? '',
        name: map['name'] ?? '',
        price: map['price'] ?? '',
        imageUrl: map['imageUrl'] ?? '',
        brand: map['brand'] ?? '',
        productCount: map['productCount'] ?? 1);
  }
  WishModel copyWith({
    String? id,
    String? name,
    String? price,
    String? imageUrl,
    String? brand,
    int? productCount,
  }) {
    return WishModel(
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
