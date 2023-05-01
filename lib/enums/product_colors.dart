enum ProductColors {
  blue('Mavi'),
  black('Qara'),
  white('Ağ'),
  green('Yaşıl'),
  yellow('Sarı'),
  red('Qırmızı');

  const ProductColors(this._value);
  final String _value;

  String get value => _value;
}
