class Cycle {
  final String id;
  final String name;
  final String price;
  final List<String> imageUrl;
  final String brand;
  final String category;
  final String description;
  final String sellerId;
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
      this.isFavorite = false});
  factory Cycle.fromMap(Map<String, dynamic> map) {
    return Cycle(
        id: map['documentId'],
        name: map['name'],
        price: map['price'],
        sellerId: map['seller_id'],
        imageUrl: List<String>.from(map['image_url'] ?? []),
        brand: map['brand'],
        category: map['category'],
        description: map['description']);
  }

  @override
  String toString() {
    return 'Cycle(/// name: $name,// id: $id,// price: $price,//imageUrl: $imageUrl,//,brand: $brand,//,category: $category,  //,description: $description,//)';
  }
}
