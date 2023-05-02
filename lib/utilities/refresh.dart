import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/catalog/catalog_cubit.dart';
import '../cubits/category/category_cubit.dart';
import '../cubits/favorite/favorite_cubit.dart';
import '../cubits/product/product_cubit.dart';

Future<void> onPageRefresh(BuildContext context, Function() init) async {
  await Future.wait([
    context.read<CatalogCubit>().getCatalogs(),
    context.read<CategoryCubit>().getCategories(),
    context.read<ProductCubit>().getProducts(),
    context.read<FavoriteCubit>().getFavoriteProducts(),
  ]);
  init();
}
