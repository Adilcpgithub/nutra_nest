class Cycle {
  final String id;
  final String name;
  final int price;
  final List<String> imageUrl;
  final String brand;
  final String category;
  final String description;
  final String sellerId;
  final String weight;
  final String stock;
  final String shippingAmount;
  bool isFavorite;
  Cycle(
      {required this.id,
      required this.name,
      required this.price,
      required this.imageUrl,
      required this.brand,
      required this.category,
      required this.description,
      required this.sellerId,
      required this.weight,
      required this.stock,
      required this.shippingAmount,
      this.isFavorite = false});
  Cycle copytWith(
    String? id,
    String? name,
    int? price,
    List<String>? imageUrl,
    String? brand,
    String? category,
    String? description,
    String? sellerId,
    String? weight,
    String? stock,
    String? shippingAmount,
    bool? isFavorite,
  ) {
    return Cycle(
      id: id ?? '',
      name: name ?? '',
      price: price ?? 0,
      imageUrl: imageUrl ?? [],
      brand: brand ?? '',
      category: category ?? '',
      description: description ?? '',
      sellerId: sellerId ?? '',
      weight: weight ?? '',
      stock: stock ?? '',
      shippingAmount: shippingAmount ?? '',
      isFavorite: isFavorite ?? false,
    );
  }

  factory Cycle.fromMap(Map<String, dynamic> map) {
    return Cycle(
        id: map['documentId'] ?? '',
        name: map['name'] ?? '',
        price: map['price'] ?? '',
        sellerId: map['seller_id'] ?? '',
        imageUrl:
            map['image_url'] is List ? List<String>.from(map['image_url']) : [],
        brand: map['brand'] ?? '',
        category: map['category'] ?? '',
        description: map['description'] ?? '',
        weight: map['weight'] ?? '',
        shippingAmount: map['shippingAmount'] ?? '',
        stock: map['stock'] ?? '');
  }

  @override
  String toString() {
    return 'Cycle(/// name: $name,// id: $id,// price: $price,//imageUrl: $imageUrl,//,brand: $brand,//,category: $category,  //,description: $description,//)';
  }
}
