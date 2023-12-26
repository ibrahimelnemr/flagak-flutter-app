// product class
class Product {
  final String productId;
  final String name;
  final double price;
  final String description;
  final String userId;

  Product({required this.productId, required this.name, required this.price, required this.description, required this.userId});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['_id'],
      name: json['name'],
      price: json['price'].toDouble(),
      description: json['description'],
      userId: json['user_id'],
    );
  }
}
