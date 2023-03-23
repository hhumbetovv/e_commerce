import 'package:e_commerce/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class AppFonts {
  const AppFonts._();

  static const Color _defaultColor = ColorConstants.black;
  static final TextStyle _appFont = GoogleFonts.sourceSansPro();

  //! Heading
  static final TextStyle headingLarge = _appFont.copyWith(
    color: _defaultColor,
    fontWeight: FontWeight.w600,
    fontSize: 48,
  );
  static final TextStyle headingMedium = _appFont.copyWith(
    color: _defaultColor,
    fontWeight: FontWeight.w600,
    fontSize: 32,
  );
  static final TextStyle headingSmall = _appFont.copyWith(
    color: _defaultColor,
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );

  //! Body
  static final TextStyle bodyLarge = _appFont.copyWith(
    color: _defaultColor,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
  static final TextStyle bodyMedium = _appFont.copyWith(
    color: _defaultColor,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static final TextStyle bodySmall = _appFont.copyWith(
    color: _defaultColor,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  static final TextStyle bodyMinimal = _appFont.copyWith(
    color: _defaultColor,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
}
