import 'package:e_commerce/models/category.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/utilities/random_photo_url.dart';

class Faker {
  static List<ProductModel> products = [
    ProductModel(
      title: 'Jeans',
      description: 'Sint consectetur voluptate occaecat magna veniam anim aliquip dolore cillum.',
      imageUrls: [randomPhotoUrl(), randomPhotoUrl()],
      price: 30.50,
      information: {},
      createdAt: DateTime.now(),
    ),
    ProductModel(
      title: 'Black Shirt',
      description: 'Sint consectetur voluptate occaecat magna veniam anim aliquip dolore cillum.',
      imageUrls: [randomPhotoUrl(), randomPhotoUrl()],
      price: 30.50,
      information: {},
      createdAt: DateTime.now(),
    ),
    ProductModel(
      title: 'Blue Jeans',
      description: 'Sint consectetur voluptate occaecat magna veniam anim aliquip dolore cillum.',
      imageUrls: [randomPhotoUrl(), randomPhotoUrl()],
      price: 30.50,
      information: {},
      createdAt: DateTime.now(),
    ),
    ProductModel(
      title: 'Sweat Shirt',
      description:
          'Veniam reprehenderit fugiat consequat tempor aute dolor sint proident Lorem reprehenderit ipsum cupidatat ex.',
      imageUrls: [randomPhotoUrl(), randomPhotoUrl()],
      price: 43,
      information: {},
      createdAt: DateTime.now(),
    ),
    ProductModel(
      title: 'T-Shirt',
      description: 'Laboris nulla anim irure sunt esse consequat nisi deserunt aliqua deserunt dolore et deserunt sit.',
      imageUrls: [randomPhotoUrl(), randomPhotoUrl()],
      price: 13.99,
      information: {},
      createdAt: DateTime.now(),
    ),
  ];

  static List<CategoryModel> subCategories = [
    CategoryModel(
      title: 'Bütün Məhsullar',
      imageUrl: randomPhotoUrl(),
      subCategories: [],
      products: products,
    ),
    CategoryModel(
      title: 'Yeni Məhsullar',
      imageUrl: randomPhotoUrl(),
      subCategories: [],
      products: products,
    ),
    CategoryModel(
      title: 'Uşaq geyimləri',
      imageUrl: randomPhotoUrl(),
      subCategories: [],
      products: products,
    ),
    CategoryModel(
      title: 'Qadın geyimləri',
      imageUrl: randomPhotoUrl(),
      subCategories: [],
      products: products,
    ),
    CategoryModel(
      title: 'Kişi geyimləri',
      imageUrl: randomPhotoUrl(),
      subCategories: [],
      products: products,
    ),
    CategoryModel(
      title: 'Sezonluq Geyimlər',
      imageUrl: randomPhotoUrl(),
      subCategories: [],
      products: products,
    ),
  ];
  static List<CategoryModel> mainCategories = [
    CategoryModel(
      title: 'Bütün Məhsullar',
      imageUrl: randomPhotoUrl(),
      subCategories: subCategories,
      products: products,
    ),
    CategoryModel(
      title: 'Yeni Məhsullar',
      imageUrl: randomPhotoUrl(),
      subCategories: subCategories,
      products: products,
    ),
    CategoryModel(
      title: 'Uşaq geyimləri',
      imageUrl: randomPhotoUrl(),
      subCategories: subCategories,
      products: products,
    ),
    CategoryModel(
      title: 'Qadın geyimləri',
      imageUrl: randomPhotoUrl(),
      subCategories: subCategories,
      products: products,
    ),
    CategoryModel(
      title: 'Kişi geyimləri',
      imageUrl: randomPhotoUrl(),
      subCategories: subCategories,
      products: products,
    ),
    CategoryModel(
      title: 'Sezonluq Geyimlər',
      imageUrl: randomPhotoUrl(),
      subCategories: subCategories,
      products: products,
    ),
  ];
}
