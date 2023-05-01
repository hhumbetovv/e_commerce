import 'package:flutter/material.dart';

enum InkType {
  ripple(value: InkRipple.splashFactory),
  sparkle(value: InkSparkle.splashFactory),
  splash(value: InkSplash.splashFactory),
  noSplash(value: null);

  const InkType({required this.value});
  final InteractiveInkFeatureFactory? value;
}
