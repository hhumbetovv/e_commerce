import 'package:e_commerce/constants/app_fonts.dart';
import 'package:e_commerce/constants/color_constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: ColorConstants.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: AppFonts.headingSmall,
      centerTitle: true,
      iconTheme: const IconThemeData(
        color: ColorConstants.black,
      ),
    ),
  );
}
