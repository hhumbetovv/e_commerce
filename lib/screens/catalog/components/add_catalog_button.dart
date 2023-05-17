import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/modals/edit_catalog_modal_sheet.dart';
import '../../../constants/color_constants.dart';
import '../../../enums/icons.dart';
import '../../../enums/ink_type.dart';
import '../../../widgets/app_inkwell.dart';

class AddCatalogButton extends StatefulWidget {
  const AddCatalogButton({
    Key? key,
    required this.onRefresh,
  }) : super(key: key);

  final Function() onRefresh;

  @override
  State<AddCatalogButton> createState() => _AddCatalogButtonState();
}

class _AddCatalogButtonState extends State<AddCatalogButton> {
  bool showInputs = false;
  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      onTap: () async {
        final response = await editCatalogModalSheet(context);
        if (response ?? false) {
          widget.onRefresh();
        }
      },
      type: showInputs ? InkType.noSplash : InkType.sparkle,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorConstants.secondary,
        ),
        clipBehavior: Clip.antiAlias,
        child: Center(
          child: SvgPicture.asset(
            AppIcons.add.svg,
            height: 48,
            colorFilter: const ColorFilter.mode(
              ColorConstants.grey,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
