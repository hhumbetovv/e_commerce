import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../components/dialogs/catalog_selections_dialog.dart';
import '../../../components/modals/edit_catalog_modal_sheet.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/string_constants.dart';
import '../../../enums/catalog_selections.dart';
import '../../../enums/images.dart';
import '../../../enums/ink_type.dart';
import '../../../models/category.dart';
import '../../../services/firebase_firestore.dart';
import '../../../services/firebase_storage.dart';
import '../../../widgets/app_inkwell.dart';
import '../../../widgets/circular_loader.dart';
import '../../categories/categories_view.dart';
import '../../products/products_view.dart';

class CatalogListTile extends StatelessWidget {
  const CatalogListTile({
    Key? key,
    this.catalog,
    this.onRefresh,
  }) : super(key: key);

  final CategoryModel? catalog;
  final Function()? onRefresh;

  Future<void> deleteCatalog(BuildContext context) async {
    try {
      await FirestoreService().deleteCatalog(catalog!.id);
      await FirebaseStorageService().deleteImageByUrl(catalog!.imageUrl);
      if (onRefresh != null) onRefresh!();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future<void> editCatalog(BuildContext context) async {
    final response = await editCatalogModalSheet(context, catalog: catalog);
    if ((response ?? false) && onRefresh != null) {
      onRefresh!();
    }
  }

  void cardOnTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          if (catalog != null && catalog!.subCategories.isNotEmpty) {
            return CategoriesView(
              id: catalog!.id,
              isCatalog: true,
            );
          }
          return ProductsView(
            id: catalog?.id,
            isCatalog: true,
          );
        },
      ),
    );
  }

  Future<void> cardOnLongPress(BuildContext context) async {
    if (catalog != null) {
      final CatalogSelections? response = await catalogSelectionsDialog(context, catalog!);
      switch (response) {
        case CatalogSelections.delete:
          if (context.mounted) deleteCatalog(context);
          break;
        case CatalogSelections.update:
          if (context.mounted) editCatalog(context);
          break;
        default:
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      type: InkType.sparkle,
      onTap: () => cardOnTap(context),
      onLongPress: () => cardOnLongPress(context),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorConstants.secondary,
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            cardTitle,
            cardImage,
          ],
        ),
      ),
    );
  }

  Expanded get cardTitle {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          catalog?.title ?? StringConstants.allProductsText,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: AppFonts.headingSmall,
        ),
      ),
    );
  }

  AspectRatio get cardImage {
    return AspectRatio(
      aspectRatio: 1,
      child: catalog != null
          ? CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: catalog!.imageUrl,
              placeholder: (context, url) => CircularLoader.center(
                color: ColorConstants.primary[400],
              ),
              errorWidget: (context, url, error) => const Center(
                child: Icon(
                  Icons.error,
                  color: ColorConstants.red,
                  size: 32,
                ),
              ),
            )
          : Image.asset(
              AppImages.allProductsCover.jpg,
              fit: BoxFit.cover,
            ),
    );
  }
}
