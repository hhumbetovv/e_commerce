import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_fonts.dart';
import '../../constants/color_constants.dart';
import '../../cubits/favorite/favorite_cubit.dart';
import '../../enums/icons.dart';
import '../../models/product.dart';
import '../../widgets/app_inkwell.dart';
import 'components/product_image_view.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({
    required this.product,
    Key? key,
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
        backgroundColor: ColorConstants.grey[100],
        radius: 18,
        child: SvgPicture.asset(AppIcons.arrowLeft.svg),
      ),
    );
  }

  BlocBuilder get toggleFavoriteButton {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteLoaded) {
          bool isFavorite = state.favoriteIds.contains(product.id);
          return AppInkWell(
            onTap: () {
              context.read<FavoriteCubit>().toggleProduct(product.id);
            },
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
        return const SizedBox();
      },
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

  Column get parameters {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: product.parameters.map((parameter) {
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
