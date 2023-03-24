import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/constants/app_fonts.dart';
import 'package:e_commerce/models/category.dart';
import 'package:e_commerce/screens/categories/categories_view.dart';
import 'package:e_commerce/screens/products/products_view.dart';
import 'package:e_commerce/widgets/app_inkwell.dart';
import 'package:flutter/material.dart';

class CategoryListTile extends StatelessWidget {
  const CategoryListTile({
    Key? key,
    required this.category,
  }) : super(key: key);

  final CategoryModel category;

  void tileOnTap(BuildContext context) {
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
      type: InkType.noSplash,
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
      category.title,
      overflow: TextOverflow.ellipsis,
      // style: AppFonts.bodyLarge,
      style: AppFonts.bodyMedium,
    );
  }
}
