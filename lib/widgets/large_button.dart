import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_fonts.dart';
import '../constants/color_constants.dart';
import '../enums/button_type.dart';
import 'app_inkwell.dart';

class LargeButton extends StatelessWidget {
  const LargeButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.type,
    this.icon,
    this.style,
    this.isDeactivated = false,
  }) : super(key: key);

  final String text;
  final Function()? onTap;
  final ButtonType type;
  final String? icon;
  final TextStyle? style;
  final bool isDeactivated;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AppInkWell(
        onTap: isDeactivated ? null : onTap,
        type: type.inkType,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: isDeactivated ? type.deactiveColor : type.color,
            borderRadius: BorderRadius.circular(8),
            border: type.isBordered ? Border.all(color: ColorConstants.black) : null,
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
            style: style ?? AppFonts.bodyMedium,
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
      style: style ?? AppFonts.bodyMedium,
    );
  }
}
