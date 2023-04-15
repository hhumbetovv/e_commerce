import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_fonts.dart';
import '../../constants/string_constants.dart';
import '../../enums/icons.dart';
import '../../models/category.dart';
import '../../widgets/app_inkwell.dart';
import '../../widgets/search.dart';
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

class _CategoriesViewState extends State<CategoriesView> {
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

  Expanded get categoryList {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.category.subCategories.length,
        itemBuilder: (context, index) {
          return CategoryListTile(
            category: widget.category.subCategories[index],
          );
        },
      ),
    );
  }
}
