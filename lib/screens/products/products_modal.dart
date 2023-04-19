import 'package:e_commerce/cubits/product/product_cubit.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/screens/products/products_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProductsModal extends State<ProductsView> {
  String searchText = '';
  late final List<ProductModel> products;

  @override
  void initState() {
    super.initState();
    products = (context.read<ProductCubit>().state.props as List<ProductModel>).where((product) {
      return widget.category != null ? widget.category!.products.contains(product.id) : true;
    }).toList();
  }
}
