import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/string_constants.dart';
import '../../enums/icons.dart';
import '../../models/category.dart';
import '../../widgets/app_inkwell.dart';
import '../../widgets/search.dart';
import '../../widgets/small_button.dart';
import 'components/product_card.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({
    Key? key,
    required this.category,
  }) : super(key: key);

  final CategoryModel category;

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
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
          sortAndFilterRow,
          productList,
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
      hintText: StringConstants.productSearchHint,
    );
  }

  Padding get sortAndFilterRow {
    Expanded sortButton() {
      return Expanded(
        child: SmallButton(
          text: StringConstants.sortHintText,
          onTap: () {},
          type: ButtonType.secondary,
          isFullWidth: true,
          icon: AppIcons.directionVertical.svg,
        ),
      );
    }

    Expanded filterButton() {
      return Expanded(
        child: SmallButton(
          text: StringConstants.filterHintText,
          onTap: () {},
          type: ButtonType.secondary,
          isFullWidth: true,
          icon: AppIcons.filter.svg,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          sortButton(),
          const SizedBox(width: 15),
          filterButton(),
        ],
      ),
    );
  }

  Expanded get productList {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.category.products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 24,
          mainAxisExtent: 268,
        ),
        itemBuilder: (context, index) {
          return ProductCard(product: widget.category.products[index]);
        },
      ),
    );
  }
}
