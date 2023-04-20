import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/constants/app_fonts.dart';
import 'package:e_commerce/constants/color_constants.dart';
import 'package:e_commerce/enums/icons.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/widgets/app_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoriteProductCard extends StatelessWidget {
  const FavoriteProductCard({
    Key? key,
    required this.product,
    required this.unFavorite,
  }) : super(key: key);

  final ProductModel product;
  final Function(String) unFavorite;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAlias,
              child: Hero(
                tag: product.imageUrls[0],
                child: CachedNetworkImage(
                  imageUrl: product.imageUrls[0],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: AppFonts.headingSmall,
                ),
                const SizedBox(height: 5),
                Text(
                  '${product.price.toString()}\u20BC',
                  style: AppFonts.bodyLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  product.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: AppFonts.bodyMedium.copyWith(color: ColorConstants.grey),
                ),
              ],
            ),
          ),
          AppInkWell(
            onTap: () => unFavorite(product.id),
            type: InkType.noSplash,
            child: SvgPicture.asset(
              AppIcons.clear.svg,
              colorFilter: const ColorFilter.mode(
                ColorConstants.grey,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
