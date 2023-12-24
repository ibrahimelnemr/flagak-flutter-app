import "dart:convert";
import 'package:http/http.dart' as http;
// import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static Future<Map<String, dynamic>> registerUser({
      required String name,
      required String email,
      required String password,
      required bool isAdmin}) async {
    //dotenv.load();
    // final apiEndpoint = dotenv.env['API_ENDPOINT'];
    // final apiEndpoint = Environment.apiEndpoint;

    // if (apiEndpoint == null) {
    //   throw Exception('API_ENDPOINT not defined in .env file');
    // }

    final apiEndpoint = 'http://localhost:3000/users/register';

    Map<String, dynamic> requestBody = {
      'name': name,
      'email': email,
      'password': password,
      'isAdmin': isAdmin
    };

    String jsonBody = jsonEncode(requestBody);

    final response = await http.post(
      Uri.parse(apiEndpoint),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      print("User registered successfully");
      return jsonDecode(response.body);
    } else {
      print("Failed to register user. Response body: ${response.body}");
      throw Exception("Failed to register user; status code: ${response.statusCode}");
    }
  }
}

