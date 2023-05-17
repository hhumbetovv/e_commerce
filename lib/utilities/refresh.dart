import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/catalog/catalog_cubit.dart';
import '../cubits/category/category_cubit.dart';
import '../cubits/favorite/favorite_cubit.dart';
import '../cubits/product/product_cubit.dart';

Future<void> onPageRefresh(BuildContext context, Function() init) async {
  final CatalogCubit catalogCubit = context.read<CatalogCubit>();
  final CategoryCubit categoryCubit = context.read<CategoryCubit>();
  final ProductCubit productCubit = context.read<ProductCubit>();
  final FavoriteCubit favoriteCubit = context.read<FavoriteCubit>();

  bool catalogLoaded = catalogCubit.state is CatalogLoaded;
  bool categoryLoaded = categoryCubit.state is CategoryLoaded;
  bool productLoaded = productCubit.state is ProductLoaded;
  bool favoriteLoaded = favoriteCubit.state is FavoriteLoaded;

  try {
    await Future.wait([
      catalogCubit.getCatalogs(),
      categoryCubit.getCategories(),
      productCubit.getProducts(),
      favoriteCubit.getFavoriteProducts(),
    ]);
    if (context.mounted && catalogCubit.state is CatalogError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(catalogCubit.state.toString())),
      );
    } else if (categoryCubit.state is CategoryError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(categoryCubit.state.toString())),
      );
    } else if (productCubit.state is ProductError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(productCubit.state.toString())),
      );
    }
    if (catalogLoaded && categoryLoaded && productLoaded && favoriteLoaded) {
      init();
    }
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
  }
}
