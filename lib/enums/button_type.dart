import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import 'ink_type.dart';

enum ButtonType {
  primary(
    color: ColorConstants.primary,
    deactiveColor: ColorConstants.grey,
    isBordered: false,
    inkType: InkType.ripple,
  ),
  secondary(
    color: ColorConstants.secondary,
    deactiveColor: ColorConstants.grey,
    isBordered: false,
    inkType: InkType.sparkle,
  ),
  outlined(
    color: Colors.transparent,
    deactiveColor: ColorConstants.grey,
    isBordered: true,
    inkType: InkType.splash,
  ),
  ghost(
    color: Colors.transparent,
    deactiveColor: ColorConstants.grey,
    isBordered: false,
    inkType: InkType.noSplash,
  );

  const ButtonType({
    required this.color,
    required this.deactiveColor,
    required this.isBordered,
    required this.inkType,
  });
  final Color color;
  final Color deactiveColor;
  final bool isBordered;
  final InkType inkType;
}
