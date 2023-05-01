import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import 'ink_type.dart';

enum ButtonType {
  primary(
    color: ColorConstants.primary,
    isBordered: false,
    inkType: InkType.ripple,
  ),
  secondary(
    color: ColorConstants.secondary,
    isBordered: false,
    inkType: InkType.sparkle,
  ),
  outlined(
    color: Colors.transparent,
    isBordered: true,
    inkType: InkType.splash,
  ),
  ghost(
    color: Colors.transparent,
    isBordered: false,
    inkType: InkType.noSplash,
  );

  const ButtonType({required this.color, required this.isBordered, required this.inkType});
  final Color color;
  final bool isBordered;
  final InkType inkType;
}
