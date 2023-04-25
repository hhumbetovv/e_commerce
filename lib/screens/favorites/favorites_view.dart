import 'package:e_commerce/constants/app_fonts.dart';
import 'package:e_commerce/constants/string_constants.dart';
import 'package:e_commerce/cubits/favorite/favorite_cubit.dart';
import 'package:e_commerce/enums/icons.dart';
import 'package:e_commerce/screens/favorites/components/favorite_product_card.dart';
import 'package:e_commerce/screens/favorites/favorites_modal.dart';
import 'package:e_commerce/widgets/search.dart';
import 'package:e_commerce/widgets/small_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FavoriteLoaded) {
            setFavoriteProducts(state.favoriteIds);
            sortProducts();
            return Column(
              children: [
                title,
                if (products.isEmpty)
                  const Expanded(
                    child: Center(child: Text('Is Empty')),
                  )
                else ...[
                  search,
                  sortAndFilterRow,
                  productList,
                ]
              ],
            );
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
    final searchedProducts = products.where((product) {
      return product.title.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
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
    );
  }
}
