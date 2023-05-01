enum ProductSizes {
  xs('XS'),
  s('S'),
  m('M'),
  l('L'),
  xl('XL'),
  xxl('XXL');

  const ProductSizes(this._value);
  final String _value;

  String get value => _value;
}
