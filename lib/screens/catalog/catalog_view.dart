import 'package:e_commerce/cubits/catalog/catalog_cubit.dart';
import 'package:e_commerce/cubits/product/product_cubit.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/screens/catalog/components/catalog_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_fonts.dart';
import '../../constants/string_constants.dart';
import '../../models/category.dart';
import '../../widgets/search.dart';
import 'catalog_modal.dart';

class CatalogView extends StatefulWidget {
  const CatalogView({
    Key? key,
  }) : super(key: key);

  @override
  State<CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends CatalogModal {
  late final List<CategoryModel> catalogs;
  late final List<ProductModel?> products;

  @override
  void initState() {
    super.initState();
    catalogs = context.read<CatalogCubit>().state.props as List<CategoryModel>;
    products = context.read<ProductCubit>().state.props as List<ProductModel>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          title,
          search,
          catalogList,
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

  Expanded get catalogList {
    final filteredCatalogs = catalogs.where((catalog) {
      return catalog.title.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            if (searchText.isEmpty && products.isNotEmpty)
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: CatalogListTile(),
              ),
            ListView.separated(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: filteredCatalogs.length,
              itemBuilder: (context, index) {
                return CatalogListTile(
                  catalog: filteredCatalogs[index],
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
  }
}
