import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_fonts.dart';
import '../constants/color_constants.dart';
import 'app_inkwell.dart';

class SmallButton extends StatelessWidget {
  const SmallButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.type,
    this.isFullWidth = false,
    this.icon,
  }) : super(key: key);

  final String text;
  final Function() onTap;
  final bool isFullWidth;
  final ButtonType type;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor;
    final bool isBordered;
    final InkType inkType;

    switch (type) {
      case ButtonType.primary:
        backgroundColor = ColorConstants.primary;
        isBordered = false;
        inkType = InkType.splash;
        break;
      case ButtonType.secondary:
        backgroundColor = ColorConstants.grey[100]!;
        isBordered = false;
        inkType = InkType.sparkle;
        break;
      case ButtonType.outlined:
        backgroundColor = Colors.transparent;
        isBordered = true;
        inkType = InkType.ripple;
        break;
      case ButtonType.ghost:
        backgroundColor = Colors.transparent;
        isBordered = false;
        inkType = InkType.noSplash;
        break;
    }

    return SizedBox(
      child: AppInkWell(
        onTap: onTap,
        type: inkType,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7.5),
          width: isFullWidth ? double.maxFinite : null,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(4),
            border: isBordered ? Border.all(color: ColorConstants.black) : null,
          ),
          child: content,
        ),
      ),
    );
  }

  Widget get content {
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$text ',
            textAlign: TextAlign.center,
            style: AppFonts.bodySmall,
          ),
          SvgPicture.asset(
            icon!,
            width: 18,
            height: 18,
          )
        ],
      );
    }
    return Text(
      text,
      textAlign: TextAlign.center,
      style: AppFonts.bodySmall,
    );
  }
}

enum ButtonType {
  primary,
  secondary,
  outlined,
  ghost,
}
