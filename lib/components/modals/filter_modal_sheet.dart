import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_fonts.dart';
import '../../constants/color_constants.dart';
import '../../constants/string_constants.dart';
import '../../enums/button_type.dart';
import '../../enums/icons.dart';
import '../../enums/ink_type.dart';
import '../../enums/product_colors.dart';
import '../../enums/product_sizes.dart';
import '../../extensions/text_style_extension.dart';
import '../../models/filter.dart';
import '../../widgets/app_inkwell.dart';
import '../../widgets/large_button.dart';

Future<FilterModel?> filterModalSheet(BuildContext context, FilterModel filter) {
  return showModalBottomSheet<FilterModel?>(
    backgroundColor: ColorConstants.white,
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    builder: (context) {
      return FilterModalBody(filter: filter);
    },
  );
}

class FilterModalBody extends StatefulWidget {
  const FilterModalBody({
    Key? key,
    required this.filter,
  }) : super(key: key);

  final FilterModel filter;

  @override
  State<FilterModalBody> createState() => _FilterModalBodyState();
}

class _FilterModalBodyState extends State<FilterModalBody> {
  late FilterModel currentFilter;
  late double rangeMaxValue;

  @override
  void initState() {
    super.initState();
    currentFilter = widget.filter.copyWith();
    rangeMaxValue = currentFilter.maxPrice.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 56),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              StringConstants.filterHintText,
              style: AppFonts.headingMedium,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${currentFilter.minPrice}\u20BC', style: AppFonts.bodyMedium),
                      Text('${currentFilter.maxPrice}\u20BC', style: AppFonts.bodyMedium),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                RangeSlider(
                  values: RangeValues(currentFilter.minPrice.toDouble(), currentFilter.maxPrice.toDouble()),
                  max: rangeMaxValue,
                  activeColor: ColorConstants.primary[400],
                  inactiveColor: ColorConstants.grey[200],
                  onChanged: (RangeValues values) {
                    setState(() {
                      currentFilter.setMinPrice = values.start.toInt();
                      currentFilter.setMaxPrice = values.end.toInt();
                    });
                  },
                ),
                ExpansionListTile(
                  title: StringConstants.productColorTitle,
                  selectedValues: currentFilter.colors,
                  allValues: ProductColors.values,
                  selectAll: () {
                    setState(() {
                      if (currentFilter.colors.length == ProductColors.values.length) {
                        currentFilter.setColors = [];
                      } else {
                        currentFilter.setColors = ProductColors.values;
                      }
                    });
                  },
                  valueCallBack: (value) {
                    setState(() {
                      final colorsRef = [...currentFilter.colors];
                      if (currentFilter.colors.contains(value)) {
                        colorsRef.remove(value);
                      } else {
                        colorsRef.add(value);
                      }
                      currentFilter.setColors = colorsRef;
                    });
                  },
                ),
                ExpansionListTile(
                  title: StringConstants.productSizeTitle,
                  selectedValues: currentFilter.sizes,
                  allValues: ProductSizes.values,
                  selectAll: () {
                    setState(() {
                      if (currentFilter.sizes.length == ProductSizes.values.length) {
                        currentFilter.setSizes = [];
                      } else {
                        currentFilter.setSizes = ProductSizes.values;
                      }
                    });
                  },
                  valueCallBack: (value) {
                    setState(() {
                      final sizesRef = [...currentFilter.sizes];
                      if (currentFilter.sizes.contains(value)) {
                        sizesRef.remove(value);
                      } else {
                        sizesRef.add(value);
                      }
                      currentFilter.setSizes = sizesRef;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: LargeButton(
                    text: StringConstants.showProducts,
                    type: ButtonType.primary,
                    onTap: () {
                      Navigator.of(context).pop(currentFilter);
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ExpansionListTile extends StatefulWidget {
  const ExpansionListTile({
    Key? key,
    required this.title,
    required this.selectedValues,
    required this.allValues,
    required this.valueCallBack,
    required this.selectAll,
  }) : super(key: key);

  final String title;
  final List selectedValues;
  final List allValues;
  final Function(dynamic) valueCallBack;
  final Function() selectAll;

  @override
  State<ExpansionListTile> createState() => _ExpansionListTileState();
}

class _ExpansionListTileState extends State<ExpansionListTile> with TickerProviderStateMixin {
  bool _isOpen = true;
  double turns = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppInkWell(
          onTap: () {
            setState(() {
              _isOpen = !_isOpen;
              turns += 0.5;
            });
          },
          type: InkType.sparkle,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: AppFonts.bodyLarge,
                ),
                AnimatedRotation(
                  turns: turns,
                  duration: const Duration(milliseconds: 300),
                  child: SvgPicture.asset(AppIcons.chevronDown.svg),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          firstChild: const SizedBox(
            width: double.infinity,
          ),
          secondChild: Column(children: [
            ParameterSelection(
              title: 'Hamısı',
              isSelected: widget.selectedValues.length == widget.allValues.length,
              onTap: widget.selectAll,
            ),
            ...widget.allValues.map((item) {
              return ParameterSelection(
                title: item.value,
                isSelected: widget.selectedValues.contains(item),
                onTap: () => widget.valueCallBack(item),
              );
            }).toList(),
          ]),
          crossFadeState: _isOpen ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
      ],
    );
  }
}

class ParameterSelection extends StatelessWidget {
  const ParameterSelection({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      onTap: onTap,
      type: InkType.noSplash,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppFonts.bodyMedium.regular,
              ),
            ),
            CircleAvatar(
              radius: 12,
              backgroundColor: isSelected ? ColorConstants.primary : ColorConstants.secondary,
              child: isSelected
                  ? SvgPicture.asset(
                      AppIcons.checkmark.svg,
                      height: 16,
                      width: 16,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
