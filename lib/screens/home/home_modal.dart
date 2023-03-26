import 'package:flutter/material.dart';

import '../../enums/icons.dart';
import '../categories/catalog_view.dart';
import '../favorites/favorites_view.dart';
import 'home_view.dart';

abstract class HomeModal extends State<HomeView> {
  final List<NavigationItem> navigationItems = [
    NavigationItem(
      icon: AppIcons.bag.svg,
      widget: const CatalogView(),
      key: GlobalKey<NavigatorState>(),
    ),
    NavigationItem(
      icon: AppIcons.heart.svg,
      widget: const FavoritesView(),
      key: GlobalKey<NavigatorState>(),
    ),
  ];

  int selectedIndex = 0;

  void setIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

class NavigationItem {
  final String icon;
  final Widget widget;
  final GlobalKey<NavigatorState> key;

  NavigationItem({
    required this.icon,
    required this.widget,
    required this.key,
  });
}
