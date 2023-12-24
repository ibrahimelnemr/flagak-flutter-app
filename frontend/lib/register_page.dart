import 'dart:convert';
import 'package:frontend/env.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_dotenv/flutter_dotenv.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email Address'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('Account Type:'),
                SizedBox(width: 8),
                Row(
                  children: [
                    Text('User'),
                    Radio(
                      value: false,
                      groupValue: isAdmin,
                      onChanged: (value) {
                        setState(() {
                          isAdmin = value as bool;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Admin'),
                    Radio(
                      value: true,
                      groupValue: isAdmin,
                      onChanged: (value) {
                        setState(() {
                          isAdmin = value as bool;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(

              // take the data from the form and make an http request

              onPressed: () async {
                print('Full Name: ${fullNameController.text}');
                print('Email Address: ${emailController.text}');
                print('Password: ${passwordController.text}');
                print('Is Admin: $isAdmin');

//                dotenv.load();

                // final apiEndpoint = dotenv.env['API_ENDPOINT'];
                // final apiEndpoint = Environment.apiEndpoint;


                // if (apiEndpoint == null) {
                //   print('API_ENDPOINT not defined in .env file');
                //   return;
                // }

                Map<String, dynamic> requestBody = {
                  'name': fullNameController.text,
                  'email': emailController.text,
                  'password': passwordController.text,
                  'is_admin': isAdmin
                };

                String jsonBody = jsonEncode(requestBody);

                final response = await http.post(
                  Uri.parse('http://127.0.0.1:3000/users/register'),
                  headers: {
                    'Content-Type': 'application/json',
                  },
                  body: jsonBody,
                );

                print(jsonBody);

                if (response.statusCode == 200) {
                  print("User registered successfully");
                }

                else {
                  print("Failed to register user; status code: ${response.statusCode}");
                  print("Response body: ${response.body}");
                }


              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
