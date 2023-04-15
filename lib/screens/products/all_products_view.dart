import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/string_constants.dart';
import '../../enums/icons.dart';
import '../../widgets/app_inkwell.dart';
import '../../widgets/search.dart';
import '../../widgets/small_button.dart';

class AllProductsView extends StatefulWidget {
  const AllProductsView({
    Key? key,
  }) : super(key: key);

  @override
  State<AllProductsView> createState() => _AllProductsViewState();
}

class _AllProductsViewState extends State<AllProductsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConstants.allProductsText),
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
    return Search(
      hintText: StringConstants.productSearchHint,
      onChanged: (String text) {},
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
        itemCount: 0,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 24,
          mainAxisExtent: 268,
        ),
        itemBuilder: (context, index) {
          // return ProductCard(product: widget.category.products[index]);
          return const SizedBox();
        },
      ),
    );
  }
}
