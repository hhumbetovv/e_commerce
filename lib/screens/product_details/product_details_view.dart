import 'package:e_commerce/enums/cache_items.dart';
import 'package:e_commerce/screens/product_details/product_details_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_fonts.dart';
import '../../constants/color_constants.dart';
import '../../enums/icons.dart';
import '../../models/product.dart';
import '../../widgets/app_inkwell.dart';
import 'components/product_image_view.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends ProductDetailsModal {
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(height: 10),
                  parameters
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
        background: ProductImageView(imageUrls: widget.product.imageUrls),
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
        backgroundColor: ColorConstants.grey[100],
        radius: 18,
        child: SvgPicture.asset(AppIcons.arrowLeft.svg),
      ),
    );
  }

  AppInkWell get toggleFavoriteButton {
    bool isFavorite = CacheItems.favorites.getStringList.contains(widget.product.id);
    return AppInkWell(
      onTap: toggleFavorite,
      type: InkType.noSplash,
      child: CircleAvatar(
        backgroundColor: ColorConstants.grey[100],
        radius: 18,
        child: SvgPicture.asset(
          isFavorite ? AppIcons.heartFilled.svg : AppIcons.heart.svg,
        ),
      ),
    );
  }

  Text get title {
    return Text(
      widget.product.title,
      overflow: TextOverflow.ellipsis,
      style: AppFonts.headingSmall,
    );
  }

  Text get price {
    return Text(
      '${widget.product.price}\u20BC',
      style: AppFonts.headingSmall,
    );
  }

  Text get description {
    return Text(
      widget.product.description,
      style: AppFonts.bodyMedium.copyWith(color: ColorConstants.grey),
    );
  }

  Column get parameters {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.product.parameters.map((parameter) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                parameter.parameterName,
                overflow: TextOverflow.ellipsis,
                style: AppFonts.bodyLarge,
              ),
              Text(
                parameter.values.isNotEmpty ? parameter.values.join(', ') : '—',
                style: AppFonts.bodyLarge.copyWith(
                  color: ColorConstants.grey,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
