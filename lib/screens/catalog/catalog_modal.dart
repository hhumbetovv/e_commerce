import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/catalog/catalog_cubit.dart';
import '../../cubits/product/product_cubit.dart';
import '../../models/category.dart';
import '../../models/product.dart';
import 'catalog_view.dart';

abstract class CatalogModal extends State<CatalogView> {
  String searchText = '';
  bool isLoading = false;
  late List<CategoryModel> catalogs;
  late List<ProductModel> products;

  @override
  void initState() {
    super.initState();
    init();
  }

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  void init() {
    setLoading(true);
    setState(() {
      catalogs = context.read<CatalogCubit>().state.props as List<CategoryModel>;
      products = context.read<ProductCubit>().state.props as List<ProductModel>;
      isLoading = false;
    });
    setLoading(false);
  }
}
