import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_fonts.dart';
import '../constants/color_constants.dart';
import '../enums/icons.dart';
import '../extensions/text_style_extension.dart';

class Search extends StatelessWidget {
  const Search({
    Key? key,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

  final String hintText;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextField(
        style: AppFonts.bodyMedium.regular,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: ColorConstants.primary,
        onChanged: onChanged,
        decoration: InputDecoration(
          fillColor: ColorConstants.secondary,
          filled: true,
          prefixIcon: SvgPicture.asset(
            AppIcons.search.svg,
            fit: BoxFit.scaleDown,
            colorFilter: const ColorFilter.mode(ColorConstants.grey, BlendMode.srcIn),
          ),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: ColorConstants.grey[300]!,
              width: 1,
            ),
          ),
          focusColor: ColorConstants.grey[300],
        ),
      ),
    );
  }
}
