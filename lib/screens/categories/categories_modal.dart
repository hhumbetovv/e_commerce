import 'package:e_commerce/cubits/category/category_cubit.dart';
import 'package:e_commerce/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'categories_view.dart';

abstract class CategoriesModal extends State<CategoriesView> {
  String searchText = '';
  late List<CategoryModel> categories;

  @override
  void initState() {
    super.initState();
    categories = (context.read<CategoryCubit>().state.props as List<CategoryModel>).where((category) {
      return widget.category.subCategories.isNotEmpty ? widget.category.subCategories.contains(category.id) : true;
    }).toList();
  }
}
