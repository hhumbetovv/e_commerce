import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../constants/color_constants.dart';

class ProductImageView extends StatefulWidget {
  const ProductImageView({
    Key? key,
    required this.imageUrls,
  }) : super(key: key);

  final List<String> imageUrls;

  @override
  State<ProductImageView> createState() => _ProductImageViewState();
}

class _ProductImageViewState extends State<ProductImageView> {
  int currentIndex = 0;

  void setIndex(int value) {
    setState(() {
      currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        imageSlider,
        indicator,
      ],
    );
  }

  PageView get imageSlider {
    return PageView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.imageUrls.length,
      onPageChanged: setIndex,
      itemBuilder: (BuildContext context, int index) {
        return Hero(
          tag: widget.imageUrls[index],
          child: CachedNetworkImage(
            imageUrl: widget.imageUrls[index],
            fit: BoxFit.fitHeight,
          ),
        );
      },
    );
  }

  Widget get indicator {
    return widget.imageUrls.length != 1
        ? Positioned(
            bottom: 16,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: ColorConstants.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Wrap(
                spacing: 4,
                children: widget.imageUrls.asMap().entries.map((entry) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 5,
                    width: currentIndex == entry.key ? 11 : 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: currentIndex == entry.key ? ColorConstants.black : ColorConstants.grey[300],
                    ),
                  );
                }).toList(),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
