import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/product.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ApiService.getAllProducts();
  }

  void _logout() async {
    try {
      await ApiService.logoutUser();
      // Navigate to login screen after successful logout
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logout successful!'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pushReplacementNamed(context, '/login');
    } catch (error) {
      print("Error logging out: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error logging out: $error'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _navigateToAdminView() {
    Navigator.pushNamed(context, '/admin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main'),
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: _logout,
              ),
              Text('Logout'),
            ],
          ),
        ],
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
                        Text('\$${products[index].price.toStringAsFixed(2)}'),
                        Text(products[index].description),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            print("Error displaying products in main view: ${snapshot.error}");
            return Center(
              child: Text('Error displaying products: ${snapshot.error}'),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToAdminView,
        label: Text('Admin Page'),
        icon: Icon(Icons.admin_panel_settings),
      ),
    );
  }
}
