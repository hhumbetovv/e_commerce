import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String title;
  final String description;
  final List<String> imageUrls;
  final List<ProductParameter> parameters;
  final double price;
  final DateTime createdAt;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrls,
    required this.price,
    required this.createdAt,
    required this.parameters,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    var timestamp = json['createdAt'] as Timestamp;
    var createdAt = timestamp.toDate();
    final parameters = List<ProductParameter>.from(
      (json['parameters'] as List).map((parameter) {
        return ProductParameter.fromJson(parameter);
      }),
    );

    return ProductModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrls: List<String>.from(json['imageUrls'] as List),
      price: (json['price'] as num).toDouble(),
      createdAt: createdAt,
      parameters: parameters,
    );
  }
  Map<String, dynamic> toJson() {
    final parameters = List<Map<String, dynamic>>.from(
      this.parameters.map((e) {
        return e.toJson();
      }),
    );
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrls': imageUrls,
      'price': price,
      'createdAt': Timestamp.fromDate(createdAt),
      'parameters': parameters,
    };
  }

  @override
  String toString() {
    return 'ProductModel{id=$id, title=$title, description=$description, imageUrls=$imageUrls, parameters=$parameters, price=$price, createdAt=$createdAt}';
  }
}

class ProductParameter {
  final String parameterName;
  final List<String> values;

  ProductParameter({
    required this.parameterName,
    required this.values,
  });

  Map<String, dynamic> toJson() {
    return {
      'parameterName': parameterName,
      'values': values,
    };
  }

  static ProductParameter fromJson(Map<String, dynamic> json) {
    return ProductParameter(
      parameterName: json['parameterName'],
      values: List<String>.from(json['values']),
    );
  }

  @override
  String toString() {
    return 'ProductParameter{parameterName=$parameterName, values=$values}';
  }
}
