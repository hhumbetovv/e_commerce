import 'package:e_commerce/enums/icons.dart';
import 'package:e_commerce/screens/catalog/catalog_view.dart';
import 'package:e_commerce/screens/favorites/favorites_view.dart';
import 'package:e_commerce/screens/home/home_view.dart';
import 'package:e_commerce/screens/profile/profile_view.dart';
import 'package:flutter/material.dart';

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
    NavigationItem(
      icon: AppIcons.user.svg,
      widget: const ProfileView(),
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
