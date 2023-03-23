class CategoryModel {
  final String title;
  final String imageUrl;
  final List<CategoryModel> subCategories;
  final List<String> products;

  CategoryModel({
    required this.title,
    required this.imageUrl,
    required this.subCategories,
    required this.products,
  });
}
