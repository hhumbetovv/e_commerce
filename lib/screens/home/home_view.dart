import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';
import 'components/app_navigation_bar.dart';
import 'home_modal.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends HomeModal {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await navigationItems[selectedIndex].key.currentState?.maybePop() ?? false ? false : true;
      },
      child: Scaffold(
        backgroundColor: ColorConstants.white,
        body: pageViews,
        bottomNavigationBar: bottomNavBar,
      ),
    );
  }

  IndexedStack get pageViews {
    return IndexedStack(
      index: selectedIndex,
      children: navigationItems.map((NavigationItem item) {
        return Navigator(
          key: item.key,
          onGenerateRoute: (RouteSettings settings) {
            return MaterialPageRoute(builder: (_) => item.widget);
          },
        );
      }).toList(),
    );
  }

  AppNavigationbar get bottomNavBar {
    return AppNavigationbar(
      pageIndex: selectedIndex,
      onChange: setIndex,
      icons: navigationItems.map((NavigationItem item) => item.icon).toList(),
    );
  }
}
