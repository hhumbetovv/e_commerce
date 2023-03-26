import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/app_fonts.dart';
import '../../../constants/color_constants.dart';
import '../../../enums/icons.dart';
import '../../../models/product.dart';
import '../../../widgets/app_inkwell.dart';
import '../product_details_view.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  void cardOnTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ProductDetailsView(product: product);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      onTap: () => cardOnTap(context),
      type: InkType.sparkle,
      child: Column(
        children: [
          Stack(
            children: [
              cardImage,
              favoriteButton,
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cardTitle,
              price,
            ],
          ),
          const SizedBox(height: 4),
          cardDescription,
        ],
      ),
    );
  }

  Container get cardImage {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: CachedNetworkImage(
        imageUrl: product.imageUrls[0],
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Positioned get favoriteButton {
    return Positioned(
      top: 8,
      right: 8,
      child: SvgPicture.asset(
        AppIcons.heart.svg,
      ),
    );
  }

  Expanded get cardTitle {
    return Expanded(
      child: Text(
        product.title,
        overflow: TextOverflow.ellipsis,
        style: AppFonts.bodyMedium,
      ),
    );
  }

  Text get price {
    return Text(
      '${product.price}\u20BC',
      style: AppFonts.bodyMedium,
    );
  }

  Text get cardDescription {
    return Text(
      product.description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: AppFonts.bodyMinimal.copyWith(
        color: ColorConstants.grey,
      ),
    );
  }
}
