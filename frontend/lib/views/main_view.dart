import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/product.dart';
import 'package:frontend/views/view_product_view.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late Future<List<Product>> futureProducts;
final GlobalKey<_MainViewState> _mainViewKey = GlobalKey<_MainViewState>();
  late Future<bool> isAdminFuture;

  @override
  void initState() {
    super.initState();
    futureProducts = ApiService.getAllProducts(isAdmin: false);
    isAdminFuture = ApiService.isAdmin();

    ApiService.onProductUpdate = () {
      _refreshProducts();
    };

  }

  void refreshProducts() {
    _refreshProducts();
  }

  void _refreshProducts() {
    setState(() {
      futureProducts = ApiService.getAllProducts(isAdmin: true);
    });
  }

  void _logout() async {
    try {
      await ApiService.logoutUser();
// Navigate to login screen after successful logout
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Logout successful!',
            style: TextStyle(color: Colors.green),
          ),
          duration: Duration(seconds: 2),
        ),
      );
      ApiService.onProductUpdate = null;
      Navigator.pushReplacementNamed(context, '/login');
    } catch (error) {
      print("Error logging out: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error logging out: $error',
            style: TextStyle(color: Colors.red),
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _navigateToAdminView() {
    Navigator.pushNamed(context, '/admin');
    _refreshProducts();

    (_mainViewKey.currentState as _MainViewState).refreshProducts();

  }

  Future<void> _viewProduct(Product product) async {
    if (await isAdminFuture) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewProductView(product: product),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   'Main',
        //   style: TextStyle(
        //     fontWeight: FontWeight.bold,
        //     color: Colors.white
        //   ),
        // ),
        backgroundColor: Colors.white,
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: _logout,
                color: Colors.black,
              ),
              Text(
                'Logout',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: _refreshProducts,
                color: Colors.black,
              ),
              Text(
                'Refresh',
                style: TextStyle(color: Colors.black),
              ),
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
                  title: Text(
                    products[index].name,
                    style: TextStyle(
                      
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$${products[index].price.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(products[index].description),
                    ],
                  ),
                  trailing: FutureBuilder<bool>(
                    future: isAdminFuture,
                    builder: (context, isAdminSnapshot) {
                      if (isAdminSnapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (isAdminSnapshot.hasData && isAdminSnapshot.data!) {
                        return IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            _viewProduct(products[index]);
                          },
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                  onTap: () {
                    // Handle product tap
                  },
                ),
                );
              },
            );
          } else if (snapshot.hasError) {
            print("Error displaying products in main view: ${snapshot.error}");
            return Center(
              child: Text('Error displaying products in main view: ${snapshot.error}'),
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
