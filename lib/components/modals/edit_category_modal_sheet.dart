import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../constants/app_fonts.dart';
import '../../constants/color_constants.dart';
import '../../constants/string_constants.dart';
import '../../enums/button_type.dart';
import '../../extensions/text_style_extension.dart';
import '../../models/category.dart';
import '../../services/firebase_firestore.dart';
import '../../services/firebase_storage.dart';
import '../../widgets/large_button.dart';

Future<bool?> editCategoryModalSheet(
  BuildContext context, {
  required bool isCatalog,
  required CategoryModel parentCategory,
  CategoryModel? category,
}) {
  return showModalBottomSheet<bool?>(
    backgroundColor: ColorConstants.white,
    isScrollControlled: true,
    context: context,
    isDismissible: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    builder: (context) {
      return CategoryModalBody(
        category: category,
        parentCategory: parentCategory,
        isCatalog: isCatalog,
      );
    },
  );
}

class CategoryModalBody extends StatefulWidget {
  const CategoryModalBody({
    Key? key,
    this.category,
    required this.parentCategory,
    required this.isCatalog,
  }) : super(key: key);

  final CategoryModel? category;
  final CategoryModel parentCategory;
  final bool isCatalog;

  @override
  State<CategoryModalBody> createState() => _CategoryModalBodyState();
}

class _CategoryModalBodyState extends State<CategoryModalBody> {
  String? title;
  File? image;
  bool isLoading = false;
  final TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    title = widget.category?.title;
    titleController.text = title ?? '';
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  Future<void> getImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  Future<void> uploadCategory() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (image != null && (title?.isNotEmpty ?? false)) {
        final imageUrl = await FirebaseStorageService().uploadImage(
          image!,
          StringConstants.categoryImagesPath,
        );
        final CategoryModel category = CategoryModel(
          id: const Uuid().v1(),
          title: title!,
          imageUrl: imageUrl,
          parentId: widget.parentCategory.id,
          subCategories: [],
          products: [],
        );
        await FirestoreService().setCategory(category.toJson());
        if (widget.isCatalog) {
          await FirestoreService().setCatalog(
            widget.parentCategory.copyWith(
              subCategories: [...widget.parentCategory.subCategories, category.id],
            ).toJson(),
          );
        } else {
          await FirestoreService().setCategory(
            widget.parentCategory.copyWith(
              subCategories: [...widget.parentCategory.subCategories, category.id],
            ).toJson(),
          );
        }
        if (mounted) Navigator.of(context).pop(true);
      }
    } catch (e) {
      Navigator.of(context).pop(false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> updateCategory() async {
    setState(() {
      isLoading = true;
    });
    try {
      String? imageUrl;
      if (image != null) {
        imageUrl = await FirebaseStorageService().uploadImage(
          image!,
          StringConstants.catalogImagesPath,
        );
        await FirebaseStorageService().deleteImageByUrl(widget.category!.imageUrl);
      }
      final CategoryModel updatedCategory = widget.category!.copyWith(
        title: title,
        imageUrl: imageUrl,
      );
      await FirestoreService().setCategory(updatedCategory.toJson());
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      Navigator.of(context).pop(false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: IgnorePointer(
        ignoring: isLoading,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            card,
            titleField,
            getImageButtons,
            uploadButton,
          ],
        ),
      ),
    );
  }

  Padding get card {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: ColorConstants.primary[300],
            backgroundImage: image != null
                ? Image.file(image!, fit: BoxFit.cover).image
                : widget.category != null
                    ? CachedNetworkImageProvider(widget.category!.imageUrl)
                    : null,
            radius: 24,
          ),
          const SizedBox(width: 16),
          Text(
            title ?? StringConstants.title,
            overflow: TextOverflow.ellipsis,
            style: AppFonts.bodyLarge.regular.copyWith(
              color: title?.isNotEmpty ?? false ? ColorConstants.black : ColorConstants.grey,
            ),
          )
        ],
      ),
    );
  }

  Padding get titleField {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: titleController,
        style: AppFonts.bodyMedium.regular,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: ColorConstants.primary,
        onChanged: (String value) {
          setState(() {
            title = value.trim().isEmpty ? null : value.trim();
          });
        },
        decoration: InputDecoration(
          fillColor: ColorConstants.secondary,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: ColorConstants.black,
            ),
          ),
          labelText: StringConstants.title,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: ColorConstants.primary,
            ),
          ),
        ),
      ),
    );
  }

  Padding get getImageButtons {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: LargeButton(
              isDeactivated: isLoading,
              text: StringConstants.fromGallery,
              onTap: () => getImage(ImageSource.gallery),
              type: ButtonType.primary,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: LargeButton(
              isDeactivated: isLoading,
              text: StringConstants.fromCamera,
              onTap: () => getImage(ImageSource.camera),
              type: ButtonType.primary,
            ),
          ),
        ],
      ),
    );
  }

  AnimatedSwitcher get uploadButton {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: LargeButton(
          isDeactivated: isLoading,
          text: widget.category != null ? StringConstants.save : StringConstants.upload,
          onTap: widget.category != null ? updateCategory : uploadCategory,
          type: ButtonType.primary,
        ),
      ),
    );
  }
}
