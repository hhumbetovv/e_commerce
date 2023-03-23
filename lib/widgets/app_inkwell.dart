import 'package:e_commerce/constants/color_constants.dart';
import 'package:flutter/material.dart';

class AppInkWell extends StatelessWidget {
  const AppInkWell.ripple({
    Key? key,
    required this.child,
    required this.onTap,
    this.splashFactory = InkRipple.splashFactory,
    this.color = ColorConstants.white,
  }) : super(key: key);

  const AppInkWell.sparkle({
    Key? key,
    required this.child,
    required this.onTap,
    this.splashFactory = InkSparkle.splashFactory,
    this.color = ColorConstants.white,
  }) : super(key: key);

  const AppInkWell.splash({
    Key? key,
    required this.child,
    required this.onTap,
    this.splashFactory = InkSplash.splashFactory,
    this.color = ColorConstants.white,
  }) : super(key: key);

  const AppInkWell.noSplash({
    Key? key,
    required this.child,
    required this.onTap,
    this.splashFactory = NoSplash.splashFactory,
    this.color,
  }) : super(key: key);

  final Widget child;
  final InteractiveInkFeatureFactory splashFactory;
  final Color? color;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      children: [
        child,
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: color == null ? Colors.transparent : color?.withOpacity(0.4),
              splashColor: color == null ? Colors.transparent : color?.withOpacity(0.4),
              splashFactory: splashFactory,
              onTap: onTap,
            ),
          ),
        )
      ],
    );
  }
}
