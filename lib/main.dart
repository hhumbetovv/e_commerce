import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/cubits/catalog/catalog_cubit.dart';
import 'package:e_commerce/cubits/category/category_cubit.dart';
import 'package:e_commerce/cubits/product/product_cubit.dart';
import 'package:e_commerce/initialize/app_onset.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/string_constants.dart';
import 'initialize/app_theme.dart';
import 'screens/splash/splash_view.dart';

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
