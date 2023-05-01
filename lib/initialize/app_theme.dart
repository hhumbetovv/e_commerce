import 'package:flutter/material.dart';

import '../constants/app_fonts.dart';
import '../constants/color_constants.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: ColorConstants.white,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: ColorConstants.primary,
      onPrimary: ColorConstants.black,
      secondary: ColorConstants.secondary,
      onSecondary: ColorConstants.black,
      error: ColorConstants.red,
      onError: ColorConstants.white,
      background: ColorConstants.white,
      onBackground: ColorConstants.black,
      surface: ColorConstants.secondary,
      onSurface: ColorConstants.black,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: AppFonts.bodyMedium,
      centerTitle: true,
      iconTheme: const IconThemeData(
        color: ColorConstants.black,
      ),
    ),
  );
}
