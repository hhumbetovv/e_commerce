import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_fonts.dart';
import '../constants/color_constants.dart';
import '../constants/string_constants.dart';
import '../enums/button_type.dart';
import '../enums/icons.dart';
import '../enums/ink_type.dart';
import '../enums/sort_parameters.dart';
import '../widgets/app_inkwell.dart';
import '../widgets/large_button.dart';

Future<SortParameters?> sortModalSheet(BuildContext context, SortParameters selectedParameter) {
  return showModalBottomSheet<SortParameters>(
    backgroundColor: ColorConstants.white,
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 56),
            Text(
              StringConstants.sortHintText,
              style: AppFonts.headingMedium,
            ),
            const SizedBox(height: 16),
            ...SortParameters.values.map((parameter) {
              return AppInkWell(
                onTap: () {
                  Navigator.of(context).pop(parameter);
                },
                type: InkType.sparkle,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        parameter.getValue,
                        style: AppFonts.bodyLarge,
                      ),
                      CircleAvatar(
                        radius: 12,
                        backgroundColor:
                            selectedParameter == parameter ? ColorConstants.primary : ColorConstants.secondary,
                        child: selectedParameter == parameter
                            ? SvgPicture.asset(
                                AppIcons.checkmark.svg,
                                height: 16,
                                width: 16,
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: LargeButton(
                text: StringConstants.cancelText,
                type: ButtonType.secondary,
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      );
    },
  );
}
