import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_fonts.dart';
import '../../constants/string_constants.dart';
import '../../enums/icons.dart';
import '../../models/category.dart';
import '../../widgets/app_inkwell.dart';
import '../../widgets/search.dart';
import 'categories_model.dart';
import 'components/all_products_list_tile.dart';
import 'components/category_list_tile.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({
    Key? key,
    required this.category,
  }) : super(key: key);

  final CategoryModel category;

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends CategoriesModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
        leading: goBackButton(context),
      ),
      body: Column(
        children: [
          search,
          text,
          categoryList,
        ],
      ),
    );
  }

  Padding goBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: AppInkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        type: InkType.noSplash,
        child: SvgPicture.asset(
          AppIcons.arrowLeft.svg,
        ),
      ),
    );
  }

  Search get search {
    return Search(
      hintText: StringConstants.categorySearchHint,
      onChanged: (String text) {
        setState(() => searchText = text);
      },
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

  FutureBuilder get categoryList {
    return FutureBuilder(
      future: getSubCategories(widget.category.subCategories),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        final categories = snapshot.data!;
        final filteredCategories = [];
        for (var category in categories) {
          if (category['title'].toString().toLowerCase().contains(searchText.toLowerCase())) {
            filteredCategories.add(category);
          }
        }
        return Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                if (widget.category.products.isNotEmpty) AllProductsListTile(imageUrl: widget.category.imageUrl),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: filteredCategories.length,
                  itemBuilder: (context, index) {
                    return CategoryListTile(
                      category: CategoryModel.fromJson(
                        filteredCategories[index].data() as Map<String, dynamic>,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
