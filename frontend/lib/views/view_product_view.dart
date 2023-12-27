import 'package:flutter/material.dart';
import 'package:frontend/services/product.dart';

class ViewProductView extends StatelessWidget {
  final Product product;

  ViewProductView({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product Name: ${product.name}'),
            Text('Price: \$${product.price.toStringAsFixed(2)}'),
            Text('Description: ${product.description}'),
          ],
        ),
      ),
    );
  }
}
