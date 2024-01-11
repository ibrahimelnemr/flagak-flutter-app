import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/product.dart';
import 'package:frontend/utils/styles.dart';
import 'package:frontend/widgets/custom_button.dart';
import 'package:frontend/widgets/custom_text_button.dart';
import 'package:frontend/widgets/custom_text_field.dart';

class CreateProductView extends StatefulWidget {
  //final Product product;

  CreateProductView();

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
        userId: userId,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Product created successfully!',
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
            'Failed to create product. Check your input.',
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
          'Create Product',
          style: AppStyles.titleTextStyle,
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
                controller: nameController, labelText: 'Product Name'),
            SizedBox(height: 16),
            CustomTextField(
                controller: descriptionController,
                labelText: "Product Description"),
            SizedBox(height: 16),

            CustomTextField(
              controller: priceController,
              labelText: 'Product Price',
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),

            // TextField(
            //   controller: priceController,
            //   decoration: InputDecoration(
            //     labelText: 'Product Price',
            //     focusedBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.blue),
            //     ),
            //   ),
            //   keyboardType: TextInputType.numberWithOptions(decimal: true),
            // ),
            SizedBox(height: 16),
            CustomButton(buttonText: 'Confirm', onPressed: _createProduct),
            SizedBox(height: 16),
            CustomTextButton(
              buttonText: 'Back to Admin Page',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
