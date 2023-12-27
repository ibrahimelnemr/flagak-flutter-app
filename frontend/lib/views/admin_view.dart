import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/product.dart';
import 'package:frontend/views/view_product_view.dart';
import 'create_product_view.dart';
import 'edit_product_view.dart';

class AdminView extends StatefulWidget {
  @override
  _AdminViewState createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ApiService.getAllProducts(isAdmin: true);

    ApiService.onProductUpdate = () {
      _refreshProducts();
    };
  }

  void _refreshProducts() {
    setState(() {
      futureProducts = ApiService.getAllProducts(isAdmin: true);
    });
  }

  void _viewProduct(Product product) async {
    if (await ApiService.isAdmin()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewProductView(product: product),
        ),
      );
    }
  }

  void _editProduct(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductView(product: product),
      ),
    );
  }

  void _createProduct() {
// Navigate to CreateProductView
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateProductView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin View',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                  title: Text(products[index].name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$${products[index].price.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.green),
                      ),
                      Text(products[index].description),
                    ],
                  ),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.orange,
                        ),
                        onPressed: () {
                          _editProduct(products[index]);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          _viewProduct(products[index]);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    _editProduct(products[index]);
                  },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            print("Error: ${snapshot.error}");
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createProduct,
        child: Icon(Icons.add),
      ),
    );
  }
}