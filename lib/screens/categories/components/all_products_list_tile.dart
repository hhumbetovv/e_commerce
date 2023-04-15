import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_fonts.dart';
import '../../../constants/string_constants.dart';
import '../../../widgets/app_inkwell.dart';
import '../../products/all_products_view.dart';

class AllProductsListTile extends StatelessWidget {
  const AllProductsListTile({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  void tileOnTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return const AllProductsView();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      type: InkType.noSplash,
      onTap: () => tileOnTap(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            avatar,
            const SizedBox(width: 16),
            title,
          ],
        ),
      ),
    );
  }

  CircleAvatar get avatar {
    return CircleAvatar(
      backgroundImage: CachedNetworkImageProvider(
        imageUrl,
      ),
      radius: 18,
    );
  }

  Text get title {
    return Text(
      StringConstants.allProductsText,
      overflow: TextOverflow.ellipsis,
      // style: AppFonts.bodyLarge,
      style: AppFonts.bodyMedium,
    );
  }
}
