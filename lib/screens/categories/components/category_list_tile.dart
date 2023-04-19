import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/constants/string_constants.dart';
import 'package:e_commerce/screens/categories/categories_view.dart';
import 'package:e_commerce/screens/products/products_view.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_fonts.dart';
import '../../../models/category.dart';
import '../../../widgets/app_inkwell.dart';

class CategoryListTile extends StatelessWidget {
  const CategoryListTile({
    Key? key,
    required this.category,
    this.isClosed = false,
  }) : super(key: key);

  final CategoryModel category;
  final bool isClosed;

  void tileOnTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          if (!isClosed && category.subCategories.isNotEmpty) {
            return CategoriesView(
              category: category,
            );
          }
          return ProductsView(
            category: category,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      type: InkType.sparkle,
      onTap: () => tileOnTap(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            avatar,
            const SizedBox(width: 16),
            title,
          ],
        ),
      ),
    );
  }

  CircleAvatar get avatar {
    return CircleAvatar(
      backgroundImage: CachedNetworkImageProvider(
        category.imageUrl,
      ),
      radius: 18,
    );
  }

  Text get title {
    return Text(
      !isClosed ? category.title : StringConstants.allProductsText,
      overflow: TextOverflow.ellipsis,
      // style: AppFonts.bodyLarge,
      style: AppFonts.bodyMedium,
    );
  }
}
