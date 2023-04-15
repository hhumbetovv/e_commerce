enum AppImages {
  sad('sad'),
  smiley('smiley'),
  friendly('friendly'),
  dissatisfied('dissatisfied'),
  disappointed('disappointed'),
  allProductsCover('all-products-cover');

  const AppImages(this.value);
  final String value;
  String get svg => 'assets/images/$value.svg';
  String get png => 'assets/images/$value.png';
  String get jpg => 'assets/images/$value.jpg';
}
