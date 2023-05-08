class CategoryModel {
  final String id;
  final String title;
  final String imageUrl;
  final String parentId;
  final List<String> subCategories;
  final List<String> products;

  CategoryModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.parentId,
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
      parentId: json['parentId'] as String,
      subCategories: subCategories,
      products: products,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'parentId': parentId,
      'products': products,
      'subCategories': subCategories,
    };
  }

  @override
  String toString() {
    return 'CategoryModel{id=$id, title=$title, imageUrl=$imageUrl, parentId=$parentId, subCategories=$subCategories, products=$products}';
  }
}
