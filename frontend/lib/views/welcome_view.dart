import 'package:flutter/material.dart';
import 'package:frontend/utils/styles.dart';
import 'package:frontend/views/main_view.dart';
import 'package:frontend/widgets/custom_button.dart';

class WelcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome',
              style: AppStyles.titleTextStyle,
            ),
            SizedBox(height: 16),
            CustomButton(
              buttonText: 'Get Started',
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
