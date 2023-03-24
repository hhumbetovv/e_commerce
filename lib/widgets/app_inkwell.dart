import 'package:e_commerce/constants/color_constants.dart';
import 'package:flutter/material.dart';

class AppInkWell extends StatelessWidget {
  const AppInkWell({
    Key? key,
    required this.child,
    required this.onTap,
    required this.type,
  }) : super(key: key);

  final Widget child;
  final InkType type;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final InteractiveInkFeatureFactory? splashFactory;

    switch (type) {
      case InkType.ripple:
        splashFactory = InkRipple.splashFactory;
        break;
      case InkType.sparkle:
        splashFactory = InkSparkle.splashFactory;
        break;
      case InkType.splash:
        splashFactory = InkSplash.splashFactory;
        break;
      case InkType.noSplash:
        splashFactory = null;
        break;
    }

    return Stack(
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      fit: StackFit.passthrough,
      children: [
        child,
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: splashFactory == null ? Colors.transparent : ColorConstants.white.withOpacity(0.4),
              splashColor: splashFactory == null ? Colors.transparent : ColorConstants.white.withOpacity(0.4),
              splashFactory: splashFactory,
              onTap: onTap,
            ),
          ),
        )
      ],
    );
  }
}

enum InkType {
  ripple,
  sparkle,
  splash,
  noSplash,
}
