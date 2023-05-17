import 'dart:io';

import 'package:e_commerce/extensions/text_style_extension.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../constants/app_fonts.dart';
import '../../constants/color_constants.dart';
import '../../constants/string_constants.dart';
import '../../enums/button_type.dart';
import '../../models/category.dart';
import '../../services/firebase_firestore.dart';
import '../../services/firebase_storage.dart';
import '../../widgets/large_button.dart';

Future<bool?> createCatalogModalSheet(BuildContext context) {
  return showModalBottomSheet<bool?>(
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
      return const CreateCatalogModalBody();
    },
  );
}

class CreateCatalogModalBody extends StatefulWidget {
  const CreateCatalogModalBody({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateCatalogModalBody> createState() => _CreateCatalogModalBodyState();
}

class _CreateCatalogModalBodyState extends State<CreateCatalogModalBody> {
  String? title;
  File? image;
  bool isLoading = false;

  Future<void> getImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  Future<void> uploadCatalog() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (image != null && (title?.isNotEmpty ?? false)) {
        final imageUrl = await FirebaseStorageService().uploadImage(
          image!,
          StringConstants.catalogImagesPath,
        );
        final CategoryModel catalog = CategoryModel(
          id: const Uuid().v1(),
          title: title!,
          imageUrl: imageUrl,
          parentId: '',
          subCategories: [],
          products: [],
        );
        await FirestoreService().addCatalog(catalog.toJson());
        if (mounted) {
          Navigator.of(context).pop(true);
        }
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
            uploadCatalogButton,
          ],
        ),
      ),
    );
  }

  Container get card {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 56, 16, 0),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorConstants.secondary,
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                title ?? StringConstants.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: AppFonts.headingSmall.copyWith(
                  color: title?.isNotEmpty ?? false ? ColorConstants.black : ColorConstants.grey,
                ),
              ),
            ),
          ),
          AspectRatio(
            aspectRatio: 1,
            child: image != null
                ? Image.file(
                    image!,
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: ColorConstants.primary[300],
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
              text: StringConstants.fromGallery,
              onTap: () => getImage(ImageSource.gallery),
              type: ButtonType.primary,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: LargeButton(
              text: StringConstants.fromCamera,
              onTap: () => getImage(ImageSource.camera),
              type: ButtonType.primary,
            ),
          ),
        ],
      ),
    );
  }

  AnimatedSwitcher get uploadCatalogButton {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: isLoading
          ? const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: LargeButton(
                text: StringConstants.upload,
                onTap: uploadCatalog,
                type: ButtonType.primary,
              ),
            ),
    );
  }
}
