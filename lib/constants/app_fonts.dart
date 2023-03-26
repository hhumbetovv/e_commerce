import 'package:flutter/material.dart';

import 'color_constants.dart';

@immutable
class AppFonts {
  const AppFonts._();

  // static final TextStyle _appFont = GoogleFonts.sourceSansPro();
  static const TextStyle _appFont = TextStyle(
    fontFamily: 'Poppins',
    color: ColorConstants.black,
  );

  //! Heading
  static final TextStyle headingLarge = _appFont.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 48,
  );
  static final TextStyle headingMedium = _appFont.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 32,
  );
  static final TextStyle headingSmall = _appFont.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );

  //! Body
  static final TextStyle bodyLarge = _appFont.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
  static final TextStyle bodyMedium = _appFont.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static final TextStyle bodySmall = _appFont.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  static final TextStyle bodyMinimal = _appFont.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
}
