import 'package:flutter/material.dart';
import 'package:frontend/utils/styles.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  CustomTextButton({
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: AppStyles.defaultTextButtonStyle,
      child: Text(
        buttonText,
      ),
    );
  }
}
