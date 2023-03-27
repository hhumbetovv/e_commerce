class ProductModel {
  final String title;
  final String description;
  final List<String> imageUrls;
  final List<ProductParameter> parameters = [];
  final double price;
  final DateTime createdAt;

  ProductModel({
    required this.title,
    required this.description,
    required this.imageUrls,
    required this.price,
    required this.createdAt,
    required sizes,
    required color,
    required manufacturer,
    required material,
  }) {
    parameters.addAll([
      ProductParameter(parameterName: 'Mövcud ölçüləri:', value: sizes),
      ProductParameter(parameterName: 'Rəngi:', value: color),
      ProductParameter(parameterName: 'İstehsalçı:', value: manufacturer),
      ProductParameter(parameterName: 'Materialı:', value: material),
    ]);
  }
}

class ProductParameter {
  final String parameterName;
  final String? value;

  ProductParameter({
    required this.parameterName,
    required this.value,
  });
}
