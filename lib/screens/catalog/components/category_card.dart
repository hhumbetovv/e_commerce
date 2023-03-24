import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/constants/app_fonts.dart';
import 'package:e_commerce/constants/color_constants.dart';
import 'package:e_commerce/models/category.dart';
import 'package:e_commerce/screens/catalog/category_view.dart';
import 'package:e_commerce/widgets/app_inkwell.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return AppInkWell.sparkle(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CategoryView(category: category),
          ),
        );
      },
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
