import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../enums/ink_type.dart';

class AppInkWell extends StatelessWidget {
  const AppInkWell({
    Key? key,
    required this.child,
    required this.type,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  final Widget child;
  final InkType type;
  final Function()? onTap;
  final Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return onTap == null
        ? child
        : Stack(
            clipBehavior: Clip.antiAlias,
            alignment: Alignment.center,
            fit: StackFit.passthrough,
            children: [
              child,
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    highlightColor: type.value == null ? Colors.transparent : ColorConstants.white.withOpacity(0.4),
                    splashColor: type.value == null ? Colors.transparent : ColorConstants.white.withOpacity(0.4),
                    splashFactory: type.value,
                    onTap: onTap,
                    onLongPress: onLongPress,
                  ),
                ),
              )
            ],
          );
  }
}
