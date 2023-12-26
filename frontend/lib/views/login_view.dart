import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            ElevatedButton(
              onPressed: () async {
                try {
                  // Call the login function from ApiService
                  final token = await ApiService.loginUser(
                    email: emailController.text,
                    password: passwordController.text,
                  );

                  // success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Login Successful!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  
                  // navigate to main view upon successfull login
                  Navigator.pushReplacementNamed(context, '/main');
                } catch (error) {
                  print("Error logging in: $error");
                  // login error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Login Failed. Check your credentials.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
