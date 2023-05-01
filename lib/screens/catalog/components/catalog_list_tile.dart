import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_fonts.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/string_constants.dart';
import '../../../enums/images.dart';
import '../../../enums/ink_type.dart';
import '../../../models/category.dart';
import '../../../widgets/app_inkwell.dart';
import '../../categories/categories_view.dart';
import '../../products/products_view.dart';

class CatalogListTile extends StatelessWidget {
  const CatalogListTile({
    Key? key,
    this.catalog,
  }) : super(key: key);

  final CategoryModel? catalog;

  void cardOnTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          if (catalog != null && catalog!.subCategories.isNotEmpty) {
            return CategoriesView(
              category: catalog!,
            );
          }
          return ProductsView(
            category: catalog,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      type: InkType.sparkle,
      onTap: () => cardOnTap(context),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorConstants.secondary,
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
    );
  }

  Expanded get cardTitle {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          catalog?.title ?? StringConstants.allProductsText,
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
      child: catalog != null
          ? CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: catalog!.imageUrl,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  color: ColorConstants.primary[400],
                ),
              ),
              errorWidget: (context, url, error) => const Center(
                child: Icon(
                  Icons.error,
                  color: ColorConstants.red,
                  size: 32,
                ),
              ),
            )
          : Image.asset(
              AppImages.allProductsCover.jpg,
              fit: BoxFit.cover,
            ),
    );
  }
}
