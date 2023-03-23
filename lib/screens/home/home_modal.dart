import 'package:e_commerce/screens/home/home_view.dart';
import 'package:flutter/material.dart';

abstract class HomeModal extends State<HomeView> {
  int selectedIndex = 0;
  Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
    2: GlobalKey<NavigatorState>(),
  };

  void setIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
