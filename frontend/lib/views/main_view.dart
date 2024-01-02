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
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.all(32),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                  minVerticalPadding: 20,
                  hoverColor: Colors.white,
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                    products[index].name,
                    style: TextStyle(
                      fontSize: 24
                    ),
                  ),
                    ],
                  ),
                  
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/1.png'),
                        ),
                        SizedBox(height: 10),
                      Text(
                        '\$${products[index].price.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(products[index].description,
                      style: TextStyle(fontSize: 16)
                      ),
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
    );
  }
}
