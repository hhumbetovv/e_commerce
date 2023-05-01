import '../enums/product_colors.dart';
import '../enums/product_sizes.dart';

class FilterModel {
  FilterModel({
    required minPrice,
    required maxPrice,
    required colors,
    required sizes,
  }) {
    _minPrice = minPrice;
    _maxPrice = maxPrice;
    _colors = colors;
    _sizes = sizes;
  }

  late int _minPrice;
  late int _maxPrice;
  late List<ProductColors> _colors;
  late List<ProductSizes> _sizes;

  int get minPrice => _minPrice;
  int get maxPrice => _maxPrice;
  List<ProductColors> get colors => _colors;
  List<ProductSizes> get sizes => _sizes;

  set setMinPrice(int value) => _minPrice = value;
  set setMaxPrice(int value) => _maxPrice = value;
  set setColors(List<ProductColors> values) => _colors = values;
  set setSizes(List<ProductSizes> values) => _sizes = values;

  FilterModel copyWith({
    int? minPrice,
    int? maxPrice,
    List<ProductColors>? colors,
    List<ProductSizes>? sizes,
  }) {
    return FilterModel(
      minPrice: minPrice ?? _minPrice,
      maxPrice: maxPrice ?? _maxPrice,
      colors: colors ?? _colors,
      sizes: sizes ?? _sizes,
    );
  }

  @override
  String toString() {
    return 'FilterModel{_minPrice=$_minPrice, _maxPrice=$_maxPrice, _colors=$_colors, _sizes=$_sizes}';
  }
}
