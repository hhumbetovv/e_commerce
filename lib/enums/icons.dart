enum AppIcons {
  add('add'),
  heart('heart'),
  bag('bag');

  const AppIcons(this.value);
  final String value;
  String get svg => 'assets/icons/$value.svg';
}
