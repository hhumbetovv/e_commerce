import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_fonts.dart';
import '../../constants/string_constants.dart';
import '../../enums/icons.dart';
import '../../enums/ink_type.dart';
import '../../utilities/refresh.dart';
import '../../widgets/app_inkwell.dart';
import '../../widgets/search.dart';
import 'categories_modal.dart';
import 'components/category_list_tile.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({
    Key? key,
    required this.id,
    required this.isCatalog,
  }) : super(key: key);

  final String id;
  final bool isCatalog;

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends CategoriesModal {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category.title,
          style: AppFonts.bodyMedium,
        ),
        leading: goBackButton(context),
      ),
      body: Column(
        children: [
          search,
          title,
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

  Container get title {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.centerLeft,
      child: Text(
        StringConstants.categoriesText,
        style: AppFonts.headingSmall,
      ),
    );
  }

  Expanded get categoryList {
    final searchedCategories = categories.where((element) {
      return element.title.toLowerCase().contains(searchText.toLowerCase());
    }).toList();

    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          await onPageRefresh(context, init);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          children: [
            if (searchText.isEmpty && category.products.isNotEmpty)
              CategoryListTile(
                category: category,
                isClosed: true,
              ),
            ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: searchedCategories.length,
              itemBuilder: (context, index) {
                return CategoryListTile(
                  category: searchedCategories[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
