import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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

                try {
                  final response = await ApiService.registerUser(
                    name: fullNameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                    isAdmin: isAdmin,
                  );
                  print("Registration successful: $response");

                  // success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Register Successful!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
                catch (error) {
                  print("Error registering user: $error");
                  // error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Register was not successful: $error'),
                      duration: Duration(seconds: 2),
                    ),
                  );
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
