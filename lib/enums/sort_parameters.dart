import '../constants/string_constants.dart';

enum SortParameters {
  priceHighToLow(StringConstants.sortPriceHighToLow),
  priceLowToHigh(StringConstants.sortPriceLowToHigh),
  news(StringConstants.sortNews),
  olds(StringConstants.sortOlds);

  const SortParameters(this.value);
  final String value;
  String get getValue => value;
}
