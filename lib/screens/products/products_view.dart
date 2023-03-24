import 'package:e_commerce/constants/string_constants.dart';
import 'package:e_commerce/enums/icons.dart';
import 'package:e_commerce/models/category.dart';
import 'package:e_commerce/screens/categories/components/category_list_tile.dart';
import 'package:e_commerce/widgets/search.dart';
import 'package:e_commerce/widgets/small_button.dart';
import 'package:flutter/material.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({
    Key? key,
    required this.category,
  }) : super(key: key);

  final CategoryModel category;

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
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
            // sortAndFilterRow,
            categoryList,
          ],
        ),
      ),
    );
  }

  Search get search {
    return const Search(
      hintText: StringConstants.productSearchHint,
    );
  }

  Padding get sortAndFilterRow {
    Expanded sortButton() {
      return Expanded(
        child: SmallButton(
          text: StringConstants.sortHintText,
          onTap: () {},
          type: ButtonType.secondary,
          isFullWidth: true,
          icon: AppIcons.directionVertical.svg,
        ),
      );
    }

    Expanded filterButton() {
      return Expanded(
        child: SmallButton(
          text: StringConstants.filterHintText,
          onTap: () {},
          type: ButtonType.secondary,
          isFullWidth: true,
          icon: AppIcons.filter.svg,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          sortButton(),
          const SizedBox(width: 15),
          filterButton(),
        ],
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
