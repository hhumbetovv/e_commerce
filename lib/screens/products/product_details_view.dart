import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_fonts.dart';
import '../../constants/color_constants.dart';
import '../../enums/icons.dart';
import '../../models/product.dart';
import '../../widgets/app_inkwell.dart';
import 'components/product_image_view.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          sliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      title,
                      price,
                    ],
                  ),
                  const SizedBox(height: 4),
                  description,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar sliverAppBar(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          goBackButton(context),
          toggleFavoriteButton,
        ],
      ),
      pinned: true,
      backgroundColor: Colors.transparent,
      expandedHeight: 458,
      flexibleSpace: FlexibleSpaceBar(
        background: ProductImageView(imageUrls: product.imageUrls),
      ),
    );
  }

  AppInkWell goBackButton(BuildContext context) {
    return AppInkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      type: InkType.noSplash,
      child: CircleAvatar(
        backgroundColor: ColorConstants.white.withOpacity(0.7),
        radius: 18,
        child: SvgPicture.asset(AppIcons.arrowLeft.svg),
      ),
    );
  }

  AppInkWell get toggleFavoriteButton {
    return AppInkWell(
      onTap: () {},
      type: InkType.noSplash,
      child: CircleAvatar(
        backgroundColor: ColorConstants.white.withOpacity(0.7),
        radius: 18,
        child: SvgPicture.asset(AppIcons.heart.svg),
      ),
    );
  }

  Text get title {
    return Text(
      product.title,
      overflow: TextOverflow.ellipsis,
      style: AppFonts.headingSmall,
    );
  }

  Text get price {
    return Text(
      '${product.price}\u20BC',
      style: AppFonts.headingSmall,
    );
  }

  Text get description {
    return Text(
      product.description,
      style: AppFonts.bodyMedium.copyWith(color: ColorConstants.grey),
    );
  }
}
