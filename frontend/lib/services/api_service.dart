// api_service.dart
import "dart:convert";
import 'package:frontend/services/product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  static const String apiEndpoint = 'http://localhost:3000';
  static const String registerPath = '/users/register';
  static const String loginPath = '/users/login';
  static const String viewAllProductsPath = '/products';
  static const String createProductPath = '/products/create';
  static const String editProductPath = '/products/edit';

  static final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static Function()? onProductUpdate;

  // register user

  static Future<bool> isAdmin() async {

    String? isAdmin = await _secureStorage.read(key: 'user_is_admin');
    return isAdmin == 'true';
  }

  static Future<Map<String, dynamic>> registerUser(
      {required String name,
      required String email,
      required String password,
      required bool isAdmin}) async {
    final response = await http.post(
      Uri.parse('$apiEndpoint$registerPath'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'is_admin': isAdmin,
      }),
    );

    if (response.statusCode == 200) {
      print(
          "User registered successfully. Server response body: ${response.body}");
      return jsonDecode(response.body);
    } else {
      print("Failed to register user. Response body: ${response.body}");
      throw Exception(
          "Failed to register user; status code: ${response.statusCode}");
    }
  }

  // login user

  static Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$apiEndpoint$loginPath'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    print("Attempted login. Server response: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      // save token to secure storage
      await _secureStorage.write(
          key: 'auth_token', value: responseData['token']);

      await _secureStorage.write(
        key: 'user_id',
        value: responseData['user']['_id'],
      );

      await _secureStorage.write(
        key: 'user_name',
        value: responseData['user']['name'],
      );

      await _secureStorage.write(
        key: 'user_email',
        value: responseData['user']['email'],
      );


      // store is_admin as string "true" or "false"
      await _secureStorage.write(
        key: 'user_is_admin',
        value: responseData['user']['is_admin'].toString(),
      );


      print('Login successful');
      Map<String, String> allAuthTokens = await _secureStorage.readAll();

      allAuthTokens.forEach((key, value) {
        print('Key: $key, Value: $value');
      });

      return responseData['token'];
    } else {
      print('Failed to login. Response body: ${response.body}');
      throw Exception('Failed to login; status code: ${response.statusCode}');
    }
  }

  // logout user
  static Future<void> logoutUser() async {
    // Clear the token from secure storage
    await _secureStorage.delete(key: 'auth_token');
    print('User logged out');
  }

  // get all products
  static Future<List<Product>> getAllProducts({required bool isAdmin}) async {
    // GET THE AUTH TOKEN
    String? authToken = await _secureStorage.read(key: 'auth_token');
    String? userId = await _secureStorage.read(key: 'user_id');

    print("Auth token: $authToken, userId: $userId");

    if (authToken == null) {
      print("Error retrieving products: authentication token not found");
      throw Exception("Auth token not found");
    }

    final response = await http.get(
        Uri.parse('$apiEndpoint$viewAllProductsPath'),
        headers: {'Authorization': 'Bearer $authToken'});

    if (response.statusCode == 200) {
      // check that product contains name, price and description before returning
      Iterable jsonResponse = jsonDecode(response.body);

      if (isAdmin) {
        print("Fetching admin products only");
           List<Product> products = jsonResponse
            .where((product) =>
                product['name'] != null
                && product['price'] != null
                && product['description'] != null
                && product['user_id'] ==  userId
            )
            .map((product) => Product.fromJson(product))
            .toList();

            return products;
      } else {
        print("Fetching all admin and non-admin products");
        List<Product> products = jsonResponse
            .where((product) =>
                //     product['_id'] != null &&
                product['name'] != null &&
                product['price'] != null &&
                product['description'] != null)
            .map((product) => Product.fromJson(product))
            .toList();

            return products;
      }

    } else {
      print(
          "Failed to fetch products. Response body: ${response.body}. Status code: ${response.statusCode}");
      throw Exception(
          "Failed to fetch products; status code: ${response.statusCode}");
    }
  }

  // create product
  static Future<void> createProduct(
      {required String name,
      required String description,
      required double price,
      required String userId}) async {
    String? authToken = await _secureStorage.read(key: 'auth_token');
    String? userId = await _secureStorage.read(key: 'user_id');

    if (authToken == null) {
      print("Error: authentication token not found");
      throw Exception("Auth token not found");
    }

    final response = await http.post(
      Uri.parse('$apiEndpoint$createProductPath'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode({
        'name': name,
        'description': description,
        'price': price,
        'user_id': userId
      }),
    );

    if (response.statusCode == 200) {
      print(
          "Product created successfully. Server response body: ${response.body}");
      if (onProductUpdate != null) {
      onProductUpdate!();
    }
      return jsonDecode(response.body);
    } else {
      print(
          "Failed to create product. Response body: ${response.body}. Status code: ${response.statusCode}");
      throw Exception(
          "Failed to create product; status code: ${response.statusCode}");
    }
  }

  // edit product

  static Future<void> editProduct({
    required String productId,
    required String name,
    required String description,
    required double price,
  }) async {
    String? authToken = await _secureStorage.read(key: 'auth_token');

    if (authToken == null) {
      print("Error: authentication token not found");
      throw Exception("Auth token not found");
    }

    final response = await http.put(
      Uri.parse('$apiEndpoint$editProductPath'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode({
        '_id': productId,
        'name': name,
        'description': description,
        'price': price
      }),
    );

    if (response.statusCode == 200) {
      print("Product edited successfully");
      if (onProductUpdate != null) {
      onProductUpdate!();
    }
    } else {
      print(
          "Failed to edit product. Response body: ${response.body}. Status code: ${response.statusCode}");
      throw Exception(
          "Failed to edit product; status code: ${response.statusCode}");
    }
  }

  // get authorization headers with stored token

  static Future<String> getUserId() async {
    final String? userId = await _secureStorage.read(key: 'user_id');
    print("User Id found: $userId");
    return '$userId';
  }

  // get authorization headers with stored token
  static Future<Map<String, String>> getAuthHeaders() async {
    final String? authToken = await _secureStorage.read(key: 'auth_token');
    return {'Authorization': 'Bearer $authToken'};
  }
}
