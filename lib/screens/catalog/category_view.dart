import 'package:e_commerce/models/category.dart';
import 'package:flutter/material.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({
    Key? key,
    required this.category,
  }) : super(key: key);

  final CategoryModel category;

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
      ),
      body: const Center(
        child: Text('Category'),
      ),
    );
  }
}
