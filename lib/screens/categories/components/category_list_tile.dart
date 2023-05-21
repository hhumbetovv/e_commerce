import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../components/dialogs/category_selections_dialog.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/string_constants.dart';
import '../../../enums/category_selections.dart';
import '../../../enums/ink_type.dart';
import '../../../extensions/text_style_extension.dart';
import '../../../models/category.dart';
import '../../../services/firebase_firestore.dart';
import '../../../services/firebase_storage.dart';
import '../../../widgets/app_inkwell.dart';
import '../../products/products_view.dart';
import '../categories_view.dart';

class CategoryListTile extends StatelessWidget {
  const CategoryListTile({
    Key? key,
    required this.category,
    required this.parentCategory,
    this.onRefresh,
    this.isClosed = false,
    this.parentIsCatalog = false,
  }) : super(key: key);

  final CategoryModel category;
  final CategoryModel parentCategory;
  final Function()? onRefresh;
  final bool isClosed;
  final bool parentIsCatalog;

  Future<void> deleteCategory(BuildContext context) async {
    try {
      await FirestoreService().deleteCategory(category.id);
      await FirebaseStorageService().deleteImageByUrl(category.imageUrl);
      final CategoryModel updatedCategory = parentCategory.copyWith(
        subCategories: parentCategory.subCategories.where((id) => !(id == category.id)).toList(),
      );
      if (parentIsCatalog) {
        await FirestoreService().setCatalog(updatedCategory.toJson());
      } else {
        FirestoreService().setCategory(updatedCategory.toJson());
      }
      if (onRefresh != null) onRefresh!();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  void tileOnTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          if (!isClosed && category.subCategories.isNotEmpty) {
            return CategoriesView(
              id: category.id,
              isCatalog: category.parentId.isEmpty,
            );
          }
          return ProductsView(
            id: category.id,
            isCatalog: category.parentId.isEmpty,
          );
        },
      ),
    );
  }

  Future<void> tileOnLongPress(BuildContext context) async {
    final CategorySelections? response = await categorySelectionsDialog(context, category.title);
    switch (response) {
      case CategorySelections.delete:
        if (context.mounted) deleteCategory(context);
        break;
      case CategorySelections.update:
        // if (context.mounted) editCatalog(context);
        break;
      case CategorySelections.addCategory:
        // if (context.mounted) addCategory(context);
        break;
      case CategorySelections.addProduct:
        // TODO: Handle this case.
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      type: InkType.sparkle,
      onTap: () => tileOnTap(context),
      onLongPress: () => isClosed ? null : tileOnLongPress(context),
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
        category.imageUrl,
      ),
      radius: 24,
    );
  }

  Text get title {
    return Text(
      !isClosed ? category.title : StringConstants.allProductsText,
      overflow: TextOverflow.ellipsis,
      style: AppFonts.bodyLarge.regular,
    );
  }
}
