import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants/app_fonts.dart';
import '../../constants/string_constants.dart';
import '../../models/category.dart';
import '../../widgets/search.dart';
import 'catalog_model.dart';
import 'components/all_products_card.dart';
import 'components/category_card.dart';

class CatalogView extends StatefulWidget {
  const CatalogView({
    Key? key,
  }) : super(key: key);

  @override
  State<CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends CatalogModel {
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
    return Search(
      hintText: StringConstants.catalogSearchHint,
      onChanged: (String data) {
        setState(() => searchText = data);
      },
    );
  }

  FutureBuilder get categoryList {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('categories').get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
        final categories = snapshot.data!.docs;
        final filteredCategories =
            categories.where((category) => category['title'].toLowerCase().contains(searchText.toLowerCase())).toList();
        return Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                if (searchText.isEmpty) allProductsCard,
                ListView.separated(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: filteredCategories.length,
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      category: CategoryModel.fromJson(
                        filteredCategories[index].data() as Map<String, dynamic>,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 16);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  FutureBuilder get allProductsCard {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('products').get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: 116,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return const SizedBox.shrink();
        }
        return const AllProductsCard();
      },
    );
  }
}
