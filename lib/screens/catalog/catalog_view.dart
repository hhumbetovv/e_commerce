import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_fonts.dart';
import '../../constants/string_constants.dart';
import '../../enums/images.dart';
import '../../utilities/refresh.dart';
import '../../widgets/circular_loader.dart';
import '../../widgets/search.dart';
import 'catalog_modal.dart';
import 'components/add_catalog_button.dart';
import 'components/catalog_list_tile.dart';

class CatalogView extends StatefulWidget {
  const CatalogView({
    Key? key,
  }) : super(key: key);

  @override
  State<CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends CatalogModal {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          title,
          search,
          isLoading ? CircularLoader.expanded() : catalogList,
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
    final searchedCatalogs = catalogs.where((element) {
      return element.title.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
    return searchedCatalogs.isEmpty
        ? Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppImages.dissatisfied.svg),
                const SizedBox(height: 16),
                Text(
                  catalogs.isEmpty ? StringConstants.nothingYet : StringConstants.catalogNotFound,
                  style: AppFonts.bodyLarge,
                ),
              ],
            ),
          )
        : Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                setLoading(true);
                await onPageRefresh(context, init);
                setLoading(false);
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
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
                    itemCount: searchedCatalogs.length,
                    itemBuilder: (context, index) {
                      return CatalogListTile(
                        catalog: searchedCatalogs[index],
                        onRefresh: () async {
                          setLoading(true);
                          await onPageRefresh(context, init);
                          setLoading(false);
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16);
                    },
                  ),
                  AddCatalogButton(
                    onRefresh: () async {
                      setLoading(true);
                      await onPageRefresh(context, init);
                      setLoading(false);
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
