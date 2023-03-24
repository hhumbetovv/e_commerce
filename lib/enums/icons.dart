enum AppIcons {
  search('search'),
  add('add'),
  heart('heart'),
  user('user'),
  cart('cart'),
  directionVertical('direction-vertical'),
  filter('filter'),
  bag('bag');

  const AppIcons(this.value);
  final String value;
  String get svg => 'assets/icons/$value.svg';
}
