enum AppIcons {
  search('search'),
  add('add'),
  heart('heart'),
  heartFilled('heart-filled'),
  user('user'),
  cart('cart'),
  directionVertical('direction-vertical'),
  filter('filter'),
  arrowLeft('arrow-left'),
  checkmark('checkmark'),
  clear('clear'),
  bag('bag');

  const AppIcons(this.value);
  final String value;
  String get svg => 'assets/icons/$value.svg';
}
