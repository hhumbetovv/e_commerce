import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/product/product_cubit.dart';
import '../../models/product.dart';
import 'product_details_view.dart';

abstract class ProductDetailsModal extends State<ProductDetailsView> {
  late final ProductModel product;

  @override
  void initState() {
    super.initState();
    setState(() {
      product = (context.read<ProductCubit>().state.props as List<ProductModel>).singleWhere((element) {
        return element.id == widget.id;
      });
    });
  }
}
