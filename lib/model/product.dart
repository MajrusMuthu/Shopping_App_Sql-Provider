class Product {
  final int id;
  final String name;
  final String category;
  final String image;
  final String description;
  final double price;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.description,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'image': image,
      'description': description,
      'price': price,
      'quantity': quantity,
    };
  }
}
