import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/filter_modal_sheet.dart';
import '../../components/sort_modal_sheet.dart';
import '../../cubits/catalog/catalog_cubit.dart';
import '../../cubits/category/category_cubit.dart';
import '../../cubits/product/product_cubit.dart';
import '../../enums/product_colors.dart';
import '../../enums/product_sizes.dart';
import '../../enums/sort_parameters.dart';
import '../../models/category.dart';
import '../../models/filter.dart';
import '../../models/product.dart';
import 'products_view.dart';

abstract class ProductsModal extends State<ProductsView> {
  String searchText = '';
  bool isLoading = false;
  CategoryModel? category;
  late final List<ProductModel> products;
  List<ProductModel> filteredProducts = [];

  SortParameters selectedSortParameter = SortParameters.news;
  FilterModel filter = FilterModel(
    minPrice: 0,
    maxPrice: 50,
    colors: ProductColors.values,
    sizes: ProductSizes.values,
  );

  @override
  void initState() {
    super.initState();
    init();
  }

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  void init() {
    setLoading(true);
    setState(() {
      if (widget.id != null) {
        if (widget.isCatalog) {
          category = (context.read<CatalogCubit>().state.props as List<CategoryModel>).singleWhere((element) {
            return element.id == widget.id;
          });
        } else {
          category = (context.read<CategoryCubit>().state.props as List<CategoryModel>).singleWhere((element) {
            return element.id == widget.id;
          });
        }
      } else {
        category = null;
      }
      products = (context.read<ProductCubit>().state.props as List<ProductModel>).where((element) {
        return category != null ? category!.products.contains(element.id) : true;
      }).toList();
      filteredProducts = products;
      sortProducts();
      filterProducts();
    });
    setLoading(false);
  }

  void showSortingSelections() async {
    final SortParameters? response = await sortModalSheet(context, selectedSortParameter);
    setLoading(true);
    if (response != null) {
      setState(() {
        selectedSortParameter = response;
        sortProducts();
      });
    }
    setLoading(false);
  }

  void sortProducts() {
    filteredProducts.sort((a, b) {
      switch (selectedSortParameter) {
        case SortParameters.priceHighToLow:
          return b.price.compareTo(a.price);
        case SortParameters.priceLowToHigh:
          return a.price.compareTo(b.price);
        case SortParameters.news:
          return b.createdAt.compareTo(a.createdAt);
        case SortParameters.olds:
          return a.createdAt.compareTo(b.createdAt);
      }
    });
  }

  void showFilterSelections() async {
    final FilterModel? response = await filterModalSheet(context, filter);
    setLoading(true);
    if (response != null) {
      setState(() {
        filter = response;
        filterProducts();
        sortProducts();
      });
    }
    setLoading(false);
  }

  void filterProducts() {
    filteredProducts = products.where((element) {
      final bool colorCondition = element.parameters
          .singleWhere((parameter) {
            return parameter.parameterName == 'Rəngləri';
          })
          .values
          .any((color) {
            return filter.colors.map((filterColor) {
              return filterColor.value;
            }).contains(color);
          });

      final bool sizeCondition = element.parameters
          .singleWhere((parameter) {
            return parameter.parameterName == 'Mövcud ölçüləri';
          })
          .values
          .any((size) {
            return filter.sizes.map((filterSize) {
              return filterSize.value;
            }).contains(size);
          });

      final bool priceCondition = element.price > filter.minPrice && element.price < filter.maxPrice;

      return colorCondition && sizeCondition && priceCondition;
    }).toList();
  }
}
