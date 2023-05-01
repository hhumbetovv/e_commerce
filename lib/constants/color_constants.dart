import 'package:flutter/material.dart';

@immutable
class ColorConstants {
  const ColorConstants._();

  static const MaterialColor primary = blue;

  static const Color black = Color(0xFF212121);
  static const Color white = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFFF5F5F5);

  static const MaterialColor grey = MaterialColor(
    0xFF9E9E9E,
    <int, Color>{
      100: Color(0xFFF5F5F5),
      200: Color(0xFFEEEEEE),
      300: Color(0xFFE0E0E0),
      400: Color(0xFFBDBDBD),
      500: Color(0xFF9E9E9E),
    },
  );
  static const MaterialColor yellow = MaterialColor(
    0xFFFFC107,
    <int, Color>{
      100: Color(0xFFFFECB3),
      200: Color(0xFFFFE082),
      300: Color(0xFFFFD54F),
      400: Color(0xFFFFCA28),
      500: Color(0xFFFFC107),
    },
  );
  static const MaterialColor blue = MaterialColor(
    0xFF3F51B5,
    <int, Color>{
      100: Color(0xFFC5CAE9),
      200: Color(0xFF9FA8DA),
      300: Color(0xFF7986CB),
      400: Color(0xFF5C6BC0),
      500: Color(0xFF3F51B5),
    },
  );
  static const MaterialColor red = MaterialColor(
    0xFFF44336,
    <int, Color>{
      100: Color(0xFFFFCDD2),
      200: Color(0xFFEF9A9A),
      300: Color(0xFFE57373),
      400: Color(0xFFEF5350),
      500: Color(0xFFF44336),
    },
  );
  static const MaterialColor green = MaterialColor(
    0xFF4CAF50,
    <int, Color>{
      100: Color(0xFFC8E6C9),
      200: Color(0xFFA5D6A7),
      300: Color(0xFF81C784),
      400: Color(0xFF66BB6A),
      500: Color(0xFF4CAF50),
    },
  );
}
