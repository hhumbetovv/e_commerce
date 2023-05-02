import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/screens/splash/splash_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/string_constants.dart';
import 'cubits/catalog/catalog_cubit.dart';
import 'cubits/category/category_cubit.dart';
import 'cubits/favorite/favorite_cubit.dart';
import 'cubits/product/product_cubit.dart';
import 'initialize/app_onset.dart';
import 'initialize/app_theme.dart';

void main() async {
  await AppOnset.init();
  runApp(const ECommerce());
}

class ECommerce extends StatelessWidget {
  const ECommerce({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductCubit>(
          create: (context) => ProductCubit(
            firestore: FirebaseFirestore.instance,
            storage: FirebaseStorage.instance,
          ),
        ),
        BlocProvider<CategoryCubit>(
          create: (context) => CategoryCubit(
            firestore: FirebaseFirestore.instance,
            storage: FirebaseStorage.instance,
          ),
        ),
        BlocProvider<CatalogCubit>(
          create: (context) => CatalogCubit(
            firestore: FirebaseFirestore.instance,
            storage: FirebaseStorage.instance,
          ),
        ),
        BlocProvider<FavoriteCubit>(
          create: (context) => FavoriteCubit(),
        ),
      ],
      child: MaterialApp(
        title: StringConstants.appName,
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
        home: const SplashView(),
      ),
    );
  }
}
