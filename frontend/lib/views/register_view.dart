import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/widgets/custom_button.dart';
import 'package:frontend/widgets/custom_text_field.dart';

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
        title: Title(
          color: Colors.black,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Register",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
                controller: fullNameController, labelText: 'Full Name'),
            SizedBox(height: 16),
            CustomTextField(
              controller: emailController,
              labelText: 'Email Address',
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            CustomTextField(
              controller: passwordController,
              labelText: 'Password',
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
                        setState(
                          () {
                            isAdmin = value as bool;
                          },
                        );
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
            CustomButton(
              buttonText: "Register",
              onPressed: () async {
                try {
                  final response = await ApiService.registerUser(
                    name: fullNameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                    isAdmin: isAdmin,
                  );
                  print("Registration successful: $response");

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Registration Successful!',
                        style: TextStyle(color: Colors.green),
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Navigator.pushNamed(context, '/login');
                } catch (error) {
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
            ),
          ],
        ),
      ),
    );
  }
}
