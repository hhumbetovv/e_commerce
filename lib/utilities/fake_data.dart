import 'package:e_commerce/models/category.dart';
import 'package:e_commerce/utilities/random_photo_url.dart';

class Faker {
  static List<CategoryModel> mainCategories = [
    CategoryModel(
      title: 'Bütün Məhsullar',
      imageUrl: randomPhotoUrl(),
      subCategories: [],
      products: [],
    ),
    CategoryModel(
      title: 'Yeni Məhsullar',
      imageUrl: randomPhotoUrl(),
      subCategories: [],
      products: [],
    ),
    CategoryModel(
      title: 'Uşaq geyimləri',
      imageUrl: randomPhotoUrl(),
      subCategories: [],
      products: [],
    ),
    CategoryModel(
      title: 'Qadın geyimləri',
      imageUrl: randomPhotoUrl(),
      subCategories: [],
      products: [],
    ),
    CategoryModel(
      title: 'Kişi geyimləri',
      imageUrl: randomPhotoUrl(),
      subCategories: [],
      products: [],
    ),
    CategoryModel(
      title: 'Sezonluq Geyimlər',
      imageUrl: randomPhotoUrl(),
      subCategories: [],
      products: [],
    ),
  ];
}
