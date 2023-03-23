import 'package:e_commerce/constants/app_fonts.dart';
import 'package:e_commerce/constants/color_constants.dart';
import 'package:e_commerce/constants/string_constants.dart';
import 'package:e_commerce/screens/catalog/components/category_card.dart';
import 'package:e_commerce/utilities/fake_data.dart';
import 'package:e_commerce/widgets/search.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: ColorConstants.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            title,
            search,
            categoryList,
          ],
        ),
      ),
    );
  }

  Container get title {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Text(
        StringConstants.appName,
        textAlign: TextAlign.center,
        style: AppFonts.headingMedium,
      ),
    );
  }

  Search get search {
    return const Search();
  }

  Padding get categoryList {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
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
