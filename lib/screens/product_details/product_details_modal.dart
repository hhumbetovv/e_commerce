import 'package:e_commerce/enums/cache_items.dart';
import 'package:e_commerce/screens/product_details/product_details_view.dart';
import 'package:flutter/material.dart';

abstract class ProductDetailsModal extends State<ProductDetailsView> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    getIsFavorite();
  }

  void toggleFavorite() {
    setState(() {
      List<String> favoriteIds = CacheItems.favorites.getStringList;
      isFavorite ? favoriteIds.remove(widget.product.id) : favoriteIds.add(widget.product.id);
      CacheItems.favorites.setStringList(favoriteIds);
      getIsFavorite();
    });
  }

  void getIsFavorite() {
    isFavorite = CacheItems.favorites.getStringList.contains(widget.product.id);
  }
}
