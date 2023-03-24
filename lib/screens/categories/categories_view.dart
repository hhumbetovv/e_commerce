import 'package:e_commerce/constants/app_fonts.dart';
import 'package:e_commerce/constants/string_constants.dart';
import 'package:e_commerce/models/category.dart';
import 'package:e_commerce/screens/categories/components/category_list_tile.dart';
import 'package:e_commerce/widgets/search.dart';
import 'package:flutter/material.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({
    Key? key,
    required this.category,
  }) : super(key: key);

  final CategoryModel category;

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            search,
            text,
            categoryList,
          ],
        ),
      ),
    );
  }

  Search get search {
    return const Search(
      hintText: StringConstants.categorySearchHint,
    );
  }

  Container get text {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.centerLeft,
      child: Text(
        StringConstants.categoriesText,
        style: AppFonts.headingSmall,
      ),
    );
  }

  ListView get categoryList {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: widget.category.subCategories.length,
      itemBuilder: (context, index) {
        return CategoryListTile(
          category: widget.category.subCategories[index],
        );
      },
    );
  }
}
