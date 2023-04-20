import 'package:e_commerce/cubits/product/product_cubit.dart';
import 'package:e_commerce/enums/sort_parameters.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/screens/products/components/sort_modal_sheet.dart';
import 'package:e_commerce/screens/products/products_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProductsModal extends State<ProductsView> {
  String searchText = '';
  bool isLoading = false;
  late final List<ProductModel> products;
  SortParameters selectedSortParameter = SortParameters.news;

  @override
  void initState() {
    super.initState();
    setLoading(true);
    products = (context.read<ProductCubit>().state.props as List<ProductModel>).where((product) {
      return widget.category != null ? widget.category!.products.contains(product.id) : true;
    }).toList();
    sortProducts();
    setLoading(false);
  }

  void setLoading(bool value) {
    setState(() => isLoading = value);
  }

  void showSortingSelections() async {
    final SortParameters? response = await sortModalSheet(context, selectedSortParameter);
    setLoading(true);
    if (response != null) {
      setState(() {
        selectedSortParameter = response;
        sortProducts();
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
}
