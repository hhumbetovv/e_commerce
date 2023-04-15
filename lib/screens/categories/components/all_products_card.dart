import 'package:flutter/material.dart';

import '../../../constants/app_fonts.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/string_constants.dart';
import '../../../enums/images.dart';
import '../../../widgets/app_inkwell.dart';
import '../../products/all_products_view.dart';

class AllProductsCard extends StatelessWidget {
  const AllProductsCard({
    Key? key,
  }) : super(key: key);

  void cardOnTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return const AllProductsView();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: AppInkWell(
        type: InkType.sparkle,
        onTap: () => cardOnTap(context),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorConstants.grey[100],
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cardTitle,
              cardImage,
            ],
          ),
        ),
      ),
    );
  }

  Expanded get cardTitle {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          StringConstants.allProductsText,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: AppFonts.headingSmall,
        ),
      ),
    );
  }

  AspectRatio get cardImage {
    return AspectRatio(
      aspectRatio: 1,
      child: Image.asset(
        AppImages.allProductsCover.jpg,
        fit: BoxFit.cover,
      ),
    );
  }
}
