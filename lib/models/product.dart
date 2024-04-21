class Product {
  final String id;
  final String name;
  final String? description;
  final double price;
  final int quantity;
  final String? image;

  Product({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.quantity,
    this.image,
  });
}
