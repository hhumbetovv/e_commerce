import 'package:e_commerce/constants/app_fonts.dart';
import 'package:e_commerce/constants/color_constants.dart';
import 'package:e_commerce/constants/string_constants.dart';
import 'package:e_commerce/enums/icons.dart';
import 'package:e_commerce/enums/sort_parameters.dart';
import 'package:e_commerce/widgets/app_inkwell.dart';
import 'package:e_commerce/widgets/large_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                      if (selectedParameter == parameter)
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: ColorConstants.primary,
                          child: SvgPicture.asset(
                            AppIcons.checkmark.svg,
                            height: 16,
                            width: 16,
                          ),
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
