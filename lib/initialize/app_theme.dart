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
    sliderTheme: const SliderThemeData(
      trackHeight: 2,
      rangeThumbShape: RectangularRangeSliderThumbShape(
        elevation: 0,
        pressedElevation: 0,
      ),
    ),
  );
}

class RectangularRangeSliderThumbShape extends RangeSliderThumbShape {
  const RectangularRangeSliderThumbShape({
    this.enabledThumbRadius = 10.0,
    this.disabledThumbRadius,
    this.elevation = 1.0,
    this.pressedElevation = 6.0,
  });

  final double enabledThumbRadius;

  final double? disabledThumbRadius;
  double get _disabledThumbRadius => disabledThumbRadius ?? enabledThumbRadius;

  final double elevation;

  final double pressedElevation;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(isEnabled == true ? enabledThumbRadius : _disabledThumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool? isOnTop,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
    bool? isPressed,
  }) {
    assert(sliderTheme.showValueIndicator != null);
    assert(sliderTheme.overlappingShapeStrokeColor != null);
    final Canvas canvas = context.canvas;
    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );

    final Rect thumbRect = Rect.fromLTWH(center.dx - 16, center.dy - 8, 32, 16);
    final RRect thumbRRect = RRect.fromRectAndRadius(thumbRect, const Radius.circular(4));

    final Color color = colorTween.evaluate(enableAnimation)!;

    canvas.drawRRect(
      thumbRRect,
      Paint()..color = color,
    );
  }
}
