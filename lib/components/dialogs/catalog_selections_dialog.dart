import 'package:flutter/material.dart';

import '../../constants/app_fonts.dart';
import '../../constants/color_constants.dart';
import '../../constants/string_constants.dart';
import '../../enums/button_type.dart';
import '../../enums/catalog_selections.dart';
import '../../models/category.dart';
import '../../widgets/large_button.dart';

Future<CatalogSelections?> catalogSelectionsDialog(BuildContext context, CategoryModel catalog) {
  return showDialog<CatalogSelections?>(
    context: context,
    builder: (context) {
      return SimpleDialog(
        backgroundColor: ColorConstants.white,
        titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          catalog.title,
          textAlign: TextAlign.center,
          style: AppFonts.headingMedium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        children: [
          LargeButton(
            text: StringConstants.edit,
            onTap: () {
              Navigator.of(context).pop(CatalogSelections.update);
            },
            type: ButtonType.outlined,
          ),
          const SizedBox(height: 10),
          LargeButton(
            text: StringConstants.delete,
            onTap: () {
              Navigator.of(context).pop(CatalogSelections.delete);
            },
            type: ButtonType.outlined,
          ),
        ],
      );
    },
  );
}
