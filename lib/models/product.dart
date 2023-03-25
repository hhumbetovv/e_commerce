class ProductModel {
  final String title;
  final String description;
  final List<String> imageUrls;
  final double price;
  final Map<String, dynamic> information;
  final DateTime createdAt;

  ProductModel({
    required this.title,
    required this.description,
    required this.imageUrls,
    required this.price,
    required this.information,
    required this.createdAt,
  });
}
