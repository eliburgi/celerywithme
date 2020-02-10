import 'package:flutter/material.dart';

class CeleryWithMeTheme {
  const CeleryWithMeTheme._();

  static const primaryColor = Color(0xFF47DB83);
  static const primaryColorDark = Color(0xFF42CC7A);
  static const primaryColorLight = Color(0xFFA3EDC1);

  static const primaryTextColor = Color(0xFFFFFFFF);
  static const secondaryTextColor = Color(0xCCFFFFFF);

  static const primaryIconColor = Color(0xFFFFFFFF);
  static const secondaryIconColor = Color(0xCCFFFFFF);

  static const errorColor = Color(0xFFFF7453);

  static const appLogoTextStyle = TextStyle(
    fontFamily: 'Pacifico',
    fontSize: 20.0,
    color: primaryTextColor,
  );

  static const headingTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    fontSize: 32.0,
    color: primaryTextColor,
  );

  static const titleTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
    color: primaryTextColor,
  );

  static const bodyTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    fontSize: 14.0,
    color: secondaryTextColor,
  );

  static const captionTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    fontSize: 12.0,
    color: primaryColorLight,
  );
}
