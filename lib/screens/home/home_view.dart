import 'package:e_commerce/constants/color_constants.dart';
import 'package:e_commerce/enums/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int pageIndex = 0;
  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onIndexChanged(int index) {
    pageController.jumpToPage(index);
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [
          Center(
            child: Text('Feed Screen'),
          ),
          Center(
            child: Text('Favorites Screen'),
          )
        ],
      ),
      bottomNavigationBar: BottomTabBar(
        pageIndex: pageIndex,
        onChange: (index) {
          onIndexChanged(index);
        },
        icons: [
          AppIcons.bag.svg,
          AppIcons.heart.svg,
        ],
      ),
    );
  }
}

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({
    super.key,
    required this.icons,
    required this.pageIndex,
    required this.onChange,
  });

  final List<String> icons;
  final int pageIndex;
  final Function(int index) onChange;

  @override
  State<BottomTabBar> createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: ColorConstants.grey[100]!, width: 1),
        ),
      ),
      child: Row(
        children: widget.icons.asMap().entries.map((entry) {
          final String icon = entry.value;
          final int index = entry.key;
          return Expanded(
            child: InkWell(
              onTap: () {
                widget.onChange(index);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 28),
                child: SvgPicture.asset(
                  icon,
                  height: 32,
                  width: 32,
                  colorFilter: ColorFilter.mode(
                    widget.pageIndex == index ? ColorConstants.black : ColorConstants.grey[400]!,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
