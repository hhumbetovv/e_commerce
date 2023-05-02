import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/catalog/catalog_cubit.dart';
import '../../cubits/category/category_cubit.dart';
import '../../models/category.dart';
import 'categories_view.dart';

abstract class CategoriesModal extends State<CategoriesView> {
  String searchText = '';
  late CategoryModel category;
  late List<CategoryModel> categories;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    if (widget.isCatalog) {
      category = (context.read<CatalogCubit>().state.props as List<CategoryModel>).singleWhere((element) {
        return element.id == widget.id;
      });
    } else {
      category = (context.read<CategoryCubit>().state.props as List<CategoryModel>).singleWhere((element) {
        return element.id == widget.id;
      });
    }
    categories = (context.read<CategoryCubit>().state.props as List<CategoryModel>).where((element) {
      return category.subCategories.isNotEmpty ? category.subCategories.contains(element.id) : true;
    }).toList();
  }
}
