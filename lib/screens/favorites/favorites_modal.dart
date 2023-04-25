import 'package:e_commerce/cubits/favorite/favorite_cubit.dart';
import 'package:e_commerce/cubits/product/product_cubit.dart';
import 'package:e_commerce/enums/sort_parameters.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/screens/favorites/favorites_view.dart';
import 'package:e_commerce/screens/products/components/sort_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class FavoritesModal extends State<FavoritesView> {
  String searchText = '';
  bool isLoading = false;
  late List<ProductModel> products;
  SortParameters selectedSortParameter = SortParameters.news;

  @override
  void initState() {
    super.initState();
    setLoading(true);
    products = context.read<ProductCubit>().state.props as List<ProductModel>;
    setFavoriteProducts(context.read<FavoriteCubit>().state.props as List<String>);
    sortProducts();
    setLoading(false);
  }

  void setLoading(bool value) {
    setState(() => isLoading = value);
  }

  void setFavoriteProducts(List<String> favoriteIds) {
    products = context.read<ProductCubit>().state.props as List<ProductModel>;
    products = products.where((product) {
      return favoriteIds.contains(product.id);
    }).toList();
  }

  void showSortingSelections() async {
    final SortParameters? response = await sortModalSheet(context, selectedSortParameter);
    setLoading(true);
    if (response != null) {
      setState(() {
        selectedSortParameter = response;
      });
    }
    setLoading(false);
  }

  void sortProducts() {
    products.sort((a, b) {
      switch (selectedSortParameter) {
        case SortParameters.priceHighToLow:
          return b.price.compareTo(a.price);
        case SortParameters.priceLowToHigh:
          return a.price.compareTo(b.price);
        case SortParameters.news:
          return b.createdAt.compareTo(a.createdAt);
        case SortParameters.olds:
          return a.createdAt.compareTo(b.createdAt);
      }
    });
  }

  void showFilterSelections() {}

  void unFavorite(String id) {
    setState(() {
      context.read<FavoriteCubit>().removeProduct(id);
      products.removeWhere((product) => product.id == id);
    });
  }
}
