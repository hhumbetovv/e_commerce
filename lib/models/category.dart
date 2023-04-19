class CategoryModel {
  final String id;
  final String title;
  final String imageUrl;
  final List<String> subCategories;
  final List<String> products;

  CategoryModel({
    required this.id,
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
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      subCategories: subCategories,
      products: products,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'products': products,
      'subCategories': subCategories,
    };
  }

  @override
  String toString() {
    return 'CategoryModel{title=$title, imageUrl=$imageUrl, subCategories=$subCategories, products=$products}';
  }
}
