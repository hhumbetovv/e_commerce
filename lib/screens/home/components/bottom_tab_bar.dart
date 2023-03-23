import 'package:e_commerce/constants/color_constants.dart';
import 'package:e_commerce/widgets/app_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        color: ColorConstants.white,
        border: Border(
          top: BorderSide(color: ColorConstants.grey[300]!, width: 1),
        ),
      ),
      child: Row(
        children: widget.icons.asMap().entries.map((entry) {
          return iconButton(icon: entry.value, index: entry.key);
        }).toList(),
      ),
    );
  }

  Expanded iconButton({required String icon, required int index}) {
    return Expanded(
      child: AppInkWell.noSplash(
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
  }
}
