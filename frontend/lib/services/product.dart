// product class
class Product {
  final String productId;
  final String name;
  final double price;
  final String description;
  final String adminId;

  Product({required this.productId, required this.name, required this.price, required this.description, required this.adminId});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['_id'],
      name: json['name'],
      price: json['price'].toDouble(),
      description: json['description'],
      adminId: json['admin_id'],
    );
  }
}
