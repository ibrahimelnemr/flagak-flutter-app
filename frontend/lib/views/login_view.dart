import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/utils/styles.dart';
import 'package:frontend/widgets/custom_button.dart';
import 'package:frontend/widgets/custom_text_field.dart';


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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(controller: emailController, labelText: 'Email Address'),
            SizedBox(height: 16),
            CustomTextField(controller: passwordController, labelText: 'Password', obscureText: true),
            SizedBox(height: 16),
            CustomButton(buttonText: "Login", onPressed: () async {
               try {
                  final token = await ApiService.loginUser(
                    email: emailController.text,
                    password: passwordController.text,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Login Successful!',
                        style: TextStyle(color: Colors.green),
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );

                  Navigator.pushReplacementNamed(context, '/main');
                } catch (error) {
                  print("Error logging in: $error");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Login Failed. Check your credentials.',
                        style: TextStyle(color: Colors.red),
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
            }),

            SizedBox(height: 8),
            TextButton(
              onPressed: () {
                // Navigate to the registration page
                Navigator.pushReplacementNamed(context, '/register');
              },
              child: Text('Create Account'),
              style: AppStyles.defaultTextButtonStyle,
            ),
          ],
        ),
      ),
    );
  }
}
