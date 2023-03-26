import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_fonts.dart';
import '../../../constants/color_constants.dart';
import '../../../models/category.dart';
import '../../../widgets/app_inkwell.dart';
import '../../products/products_view.dart';
import '../categories_view.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  final CategoryModel category;

  void cardOnTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          if (category.subCategories.isEmpty) {
            return ProductsView(category: category);
          }
          return CategoriesView(category: category);
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
    );
  }

  Expanded get cardTitle {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          category.title,
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
      child: CachedNetworkImage(
        imageUrl: category.imageUrl,
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
      ),
    );
  }
}
