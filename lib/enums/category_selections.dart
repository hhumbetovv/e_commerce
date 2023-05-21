import '../constants/string_constants.dart';

enum CategorySelections {
  delete(title: StringConstants.delete),
  update(title: StringConstants.update),
  addCategory(title: StringConstants.addCategory),
  addProduct(title: StringConstants.addProduct);

  const CategorySelections({required this.title});

  final String title;
}
