import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_fonts.dart';
import '../../constants/color_constants.dart';
import '../../constants/string_constants.dart';
import '../../cubits/favorite/favorite_cubit.dart';
import '../../enums/button_type.dart';
import '../../enums/icons.dart';
import '../../enums/images.dart';
import '../../utilities/deep_equality.dart';
import '../../utilities/refresh.dart';
import '../../widgets/circular_loader.dart';
import '../../widgets/search.dart';
import '../../widgets/small_button.dart';
import 'components/favorite_product_card.dart';
import 'favorites_modal.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends FavoritesModal {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return CircularLoader.center();
          }
          if (state is FavoriteLoaded) {
            if (!DeepEquality.listEquals(state.favoriteIds, favoriteIds)) {
              favoriteIds = state.favoriteIds;
              setFavoriteProducts();
            }
            if (products.isEmpty) {
              return Column(
                children: [
                  title,
                  empty,
                ],
              );
            } else {
              return Column(
                children: [
                  title,
                  search,
                  sortAndFilterRow,
                  productList,
                ],
              );
            }
          }
          return const SizedBox();
        },
      ),
    );
  }

  Container get title {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Text(
        StringConstants.favoritesText,
        textAlign: TextAlign.center,
        style: AppFonts.headingMedium,
      ),
    );
  }

  Expanded get empty {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SvgPicture.asset(AppImages.surprised.svg),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                StringConstants.favoritesIsEmptyTitle,
                style: AppFonts.headingSmall,
              ),
            ),
            Text(
              StringConstants.favoritesIsEmptyText,
              style: AppFonts.bodyMedium.copyWith(color: ColorConstants.grey),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  Search get search {
    return Search(
      hintText: StringConstants.productSearchHint,
      onChanged: (String data) {
        setState(() => searchText = data);
      },
    );
  }

  Padding get sortAndFilterRow {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: SmallButton(
              text: StringConstants.sortHintText,
              onTap: showSortingSelections,
              type: ButtonType.secondary,
              isFullWidth: true,
              icon: AppIcons.directionVertical.svg,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: SmallButton(
              text: StringConstants.filterHintText,
              onTap: showFilterSelections,
              type: ButtonType.secondary,
              isFullWidth: true,
              icon: AppIcons.filter.svg,
            ),
          ),
        ],
      ),
    );
  }

  Expanded get productList {
    final searchedProducts = filteredProducts.where((element) {
      return element.title.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
    return searchedProducts.isEmpty
        ? Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppImages.dissatisfied.svg),
                const SizedBox(height: 16),
                Text(
                  StringConstants.productNotFound,
                  style: AppFonts.bodyLarge,
                ),
              ],
            ),
          )
        : Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await onPageRefresh(context, () => setState(() => init()));
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                itemCount: searchedProducts.length,
                itemBuilder: (context, index) {
                  return FavoriteProductCard(
                    product: searchedProducts[index],
                    unFavorite: unFavorite,
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 24);
                },
              ),
            ),
          );
  }
}
