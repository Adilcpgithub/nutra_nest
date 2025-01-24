import 'package:equatable/equatable.dart';

class WishModel extends Equatable {
  final String id;
  final String name;
  final int price;
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
    List<dynamic> imageUrlList = map["image_url"] ?? [];
    return WishModel(
        id: map['documentId'] ?? '',
        name: map['name'] ?? '',
        price: map['price'] ?? 0,
        imageUrl: imageUrlList.first.toString(),
        brand: map['brand'] ?? '',
        productCount: map['productCount'] ?? 1);
  }
  WishModel copyWith({
    String? id,
    String? name,
    int? price,
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
