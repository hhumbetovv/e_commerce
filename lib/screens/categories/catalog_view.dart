import 'package:flutter/material.dart';

import '../../constants/app_fonts.dart';
import '../../constants/string_constants.dart';
import '../../utilities/fake_data.dart';
import '../../widgets/search.dart';
import 'components/category_card.dart';

class CatalogView extends StatefulWidget {
  const CatalogView({
    Key? key,
  }) : super(key: key);

  @override
  State<CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends State<CatalogView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          title,
          search,
          categoryList,
        ],
      ),
    );
  }

  Container get title {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Hero(
        tag: 'app-name',
        child: Material(
          color: Colors.transparent,
          child: Text(
            StringConstants.appName,
            textAlign: TextAlign.center,
            style: AppFonts.headingMedium,
          ),
        ),
      ),
    );
  }

  Search get search {
    return const Search(
      hintText: StringConstants.catalogSearchHint,
    );
  }

  Expanded get categoryList {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: Faker.mainCategories.length,
        itemBuilder: (context, index) {
          return CategoryCard(
            category: Faker.mainCategories[index],
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
      ),
    );
  }
}
