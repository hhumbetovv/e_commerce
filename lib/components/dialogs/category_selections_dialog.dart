import 'package:flutter/material.dart';

import '../../constants/app_fonts.dart';
import '../../constants/color_constants.dart';
import '../../enums/button_type.dart';
import '../../enums/category_selections.dart';
import '../../widgets/large_button.dart';

Future<CategorySelections?> categorySelectionsDialog(BuildContext context, String title) {
  return showDialog<CategorySelections?>(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: ColorConstants.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 10,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppFonts.headingMedium,
              ),
              ...CategorySelections.values.map((selection) {
                return LargeButton(
                  text: selection.title,
                  onTap: () {
                    Navigator.of(context).pop(selection);
                  },
                  type: ButtonType.outlined,
                );
              }).toList()
            ],
          ),
        ),
      );
    },
  );
}
