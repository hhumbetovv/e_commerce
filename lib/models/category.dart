import 'package:e_commerce/models/product.dart';

class CategoryModel {
  final String title;
  final String imageUrl;
  final List<CategoryModel> subCategories;
  final List<ProductModel> products;

  CategoryModel({
    required this.title,
    required this.imageUrl,
    required this.subCategories,
    required this.products,
  });
}
