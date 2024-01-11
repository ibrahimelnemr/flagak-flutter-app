import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/product.dart';
import 'package:frontend/widgets/custom_button.dart';
import 'package:frontend/widgets/custom_text_button.dart';
import 'package:frontend/widgets/custom_text_field.dart';

class EditProductView extends StatefulWidget {
  final Product product;

  EditProductView({required this.product});

  @override
  _EditProductViewState createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.product.name);
    descriptionController =
        TextEditingController(text: widget.product.description);
    priceController =
        TextEditingController(text: widget.product.price.toString());
  }

  void _updateProduct() async {
    try {
      var productId = widget.product.productId;
      var name = nameController.text;
      var description = descriptionController.text;
      var price = priceController.text;

      print(
          "Attempting to edit product with id: $productId, name: $name, description: $description, price $price");

      await ApiService.editProduct(
        productId: widget.product.productId,
        name: nameController.text,
        description: descriptionController.text,
        price: double.tryParse(priceController.text) ?? 0.0,
      );

      if (ApiService.onProductUpdate != null) {
        ApiService.onProductUpdate!();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Product updated successfully!',
            style: TextStyle(color: Colors.green),
          ),
          duration: Duration(seconds: 2),
        ),
      );

      Navigator.of(context).pop(true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to update product. Check your input.',
            style: TextStyle(color: Colors.red),
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Product',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(50),
                  child: Image(
                    image: AssetImage('assets/1.png'),
                  ),
                ),
                CustomTextField(
                    controller: nameController, labelText: "Product Name"),
                SizedBox(height: 16),
                CustomTextField(
                    controller: descriptionController,
                    labelText: "Product Description"),
                SizedBox(height: 16),
                CustomTextField(
                  controller: priceController,
                  labelText: "Product Price",
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                SizedBox(height: 16),
                CustomButton(buttonText: "Confirm", onPressed: _updateProduct),
                SizedBox(height: 16),
                CustomTextButton(
                  buttonText: 'Back to Admin Page',
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/admin');
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
