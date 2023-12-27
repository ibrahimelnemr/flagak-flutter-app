import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/product.dart';

class CreateProductView extends StatefulWidget {
  
  //final Product product;

  CreateProductView(/*{required this.product}*/);

  @override
  _CreateProductViewState createState() => _CreateProductViewState();
}

class _CreateProductViewState extends State<CreateProductView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  
  void _createProduct() async {

    final userId = await ApiService.getUserId();
    
    try {
      
      await ApiService.createProduct(
        name: nameController.text,
        description: descriptionController.text,
        price: double.tryParse(priceController.text) ?? 0.0,
        userId: userId
      );

      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product created successfully!'),
          duration: Duration(seconds: 2),
        ),
      );

      
      Navigator.of(context).pop(true);
    } catch (e) {
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create product. Check your input.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Product Description'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Product Price'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _createProduct,
              child: Text('Confirm'),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Navigate back to the admin page
                Navigator.pop(context);
              },
              child: Text('Back to Admin Page'),
            ),
          ],
        ),
      ),
    );
  }
}
