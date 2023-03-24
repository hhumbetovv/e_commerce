import 'package:e_commerce/constants/color_constants.dart';
import 'package:e_commerce/screens/home/components/bottom_tab_bar.dart';
import 'package:e_commerce/screens/home/home_modal.dart';
import 'package:flutter/material.dart';

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
        body: IndexedStack(
          index: selectedIndex,
          children: navigationItems.map((NavigationItem item) {
            return Navigator(
              key: item.key,
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute(builder: (_) => item.widget);
              },
            );
          }).toList(),
        ),
        bottomNavigationBar: AppNavigationbar(
          pageIndex: selectedIndex,
          onChange: setIndex,
          icons: navigationItems.map((NavigationItem item) => item.icon).toList(),
        ),
      ),
    );
  }
}
