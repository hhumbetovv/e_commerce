import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String title;
  final String imageUrl;
  final List<String> subCategories;
  final List<String> products;

  CategoryModel({
    required this.title,
    required this.imageUrl,
    required this.subCategories,
    required this.products,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final List<String> subCategories = List<String>.from(
      json['subCategories'].map((subCategory) {
        return subCategory.toString();
      }),
    );
    final List<String> products = List<String>.from(
      json['products'].map((product) {
        return product.toString();
      }),
    );
    return CategoryModel(
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      subCategories: subCategories,
      products: products,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'products': products,
      'subCategories': subCategories,
    };
  }

  Future<List<String>> getSubCategories() async {
    List<Future<DocumentSnapshot>> futures = [];
    for (String subCategoryId in subCategories) {
      futures.add(FirebaseFirestore.instance.collection('subCategories').doc(subCategoryId).get());
    }

    List<DocumentSnapshot> snapshots = await Future.wait(futures);
    List<String> subCategoryTitles = [];
    for (DocumentSnapshot snapshot in snapshots) {
      subCategoryTitles.add(snapshot.get('title'));
    }
    return subCategoryTitles;
  }

  @override
  String toString() {
    return 'CategoryModel{title=$title, imageUrl=$imageUrl, subCategories=$subCategories, products=$products}';
  }
}
