import 'package:e_commerce/constants/color_constants.dart';
import 'package:e_commerce/enums/icons.dart';
import 'package:e_commerce/screens/catalog/catalog_view.dart';
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
  final List<Widget> widgetOptions = <Widget>[
    const CatalogView(),
    const Center(child: Text('Favorites')),
    const Center(child: Text('Profile')),
  ];
  List<String> tabBarIcons = [
    AppIcons.bag.svg,
    AppIcons.heart.svg,
    AppIcons.user.svg,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      body: Navigator(
        key: navigatorKeys[selectedIndex],
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: (_) => widgetOptions.elementAt(selectedIndex));
        },
      ),
      bottomNavigationBar: BottomTabBar(
        pageIndex: selectedIndex,
        onChange: setIndex,
        icons: tabBarIcons,
      ),
    );
  }
}
