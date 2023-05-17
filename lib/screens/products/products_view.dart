import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_fonts.dart';
import '../../constants/string_constants.dart';
import '../../enums/button_type.dart';
import '../../enums/icons.dart';
import '../../enums/images.dart';
import '../../enums/ink_type.dart';
import '../../utilities/refresh.dart';
import '../../widgets/app_inkwell.dart';
import '../../widgets/circular_loader.dart';
import '../../widgets/search.dart';
import '../../widgets/small_button.dart';
import 'components/product_card.dart';
import 'products_modal.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({
    Key? key,
    required this.id,
    required this.isCatalog,
  }) : super(key: key);

  final String? id;
  final bool isCatalog;

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends ProductsModal {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category?.title ?? StringConstants.allProductsText,
          style: AppFonts.bodyMedium,
        ),
        leading: goBackButton(context),
      ),
      body: Column(
        children: [
          search,
          sortAndFilterRow,
          isLoading ? CircularLoader.expanded() : productList,
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
      hintText: StringConstants.productSearchHint,
      onChanged: (String text) {
        setState(() => searchText = text);
      },
    );
  }

  Padding get sortAndFilterRow {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: SmallButton(
              text: StringConstants.sortHintText,
              onTap: showSortingSelections,
              type: ButtonType.secondary,
              isFullWidth: true,
              icon: AppIcons.directionVertical.svg,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: SmallButton(
              text: StringConstants.filterHintText,
              onTap: showFilterSelections,
              type: ButtonType.secondary,
              isFullWidth: true,
              icon: AppIcons.filter.svg,
            ),
          ),
        ],
      ),
    );
  }

  Expanded get productList {
    final searchedProducts = filteredProducts.where((element) {
      return element.title.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
    return searchedProducts.isEmpty
        ? Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppImages.dissatisfied.svg),
                const SizedBox(height: 16),
                Text(
                  StringConstants.notFound,
                  style: AppFonts.bodyLarge,
                ),
              ],
            ),
          )
        : Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await onPageRefresh(context, init);
              },
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: searchedProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 24,
                  mainAxisExtent: 268,
                ),
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: searchedProducts[index],
                  );
                },
              ),
            ),
          );
  }
}
