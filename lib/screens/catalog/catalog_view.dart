import 'package:flutter/material.dart';

import '../../constants/app_fonts.dart';
import '../../constants/string_constants.dart';
import '../../utilities/refresh.dart';
import '../../widgets/search.dart';
import 'catalog_modal.dart';
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
    final searchedCatalogs = catalogs.where((element) {
      return element.title.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          await onPageRefresh(context, () => setState(() => init()));
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
