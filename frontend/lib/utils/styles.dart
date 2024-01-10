import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static const String defaultFontFamily = 'Montserrat';

  static final TextStyle logoTextStyle = GoogleFonts.montserrat(
    fontSize: 24.0,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle titleTextStyle = GoogleFonts.montserrat(
    fontSize: 20.0,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle subtitleTextStyle = GoogleFonts.montserrat(
    fontSize: 18.0,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle bodyTextStyle = GoogleFonts.montserrat(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle TextFieldTextStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.normal,
  );


  static final ButtonStyle defaultButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF31A062),
    padding: EdgeInsets.all(24),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    minimumSize: Size(150, 0),
  );

  static final Color primaryThemeColor = Color(0xFF31A062);

  static final ButtonStyle defaultTextButtonStyle = TextButton.styleFrom(
    foregroundColor: primaryThemeColor,
  );
}
