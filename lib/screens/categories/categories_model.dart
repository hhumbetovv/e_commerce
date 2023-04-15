import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'categories_view.dart';

abstract class CategoriesModel extends State<CategoriesView> {
  String searchText = '';

  Future<List<DocumentSnapshot<Object?>>?> getSubcategories() async {
    QuerySnapshot<Object?> querySnapshot = await FirebaseFirestore.instance.collection('subCategories').get();
    return querySnapshot.docs;
  }

  Future<List<DocumentSnapshot>> getSubCategories(List<String> subCategoryIds) async {
    List<DocumentSnapshot> subCategories = [];
    for (String subCategoryId in subCategoryIds) {
      DocumentSnapshot subCategorySnapshot =
          await FirebaseFirestore.instance.collection('subCategories').doc(subCategoryId).get();
      if (subCategorySnapshot.exists) {
        subCategories.add(subCategorySnapshot);
      }
    }
    return subCategories;
  }
}
