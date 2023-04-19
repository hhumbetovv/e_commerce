import 'package:e_commerce/constants/app_fonts.dart';
import 'package:e_commerce/constants/color_constants.dart';
import 'package:e_commerce/constants/string_constants.dart';
import 'package:e_commerce/cubits/catalog/catalog_cubit.dart';
import 'package:e_commerce/cubits/category/category_cubit.dart';
import 'package:e_commerce/cubits/product/product_cubit.dart';
import 'package:e_commerce/screens/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final bool _showProgressIndicator = true;
  late final CatalogCubit _catalogCubit;
  late final CategoryCubit _categoryCubit;
  late final ProductCubit _productCubit;

  @override
  void initState() {
    super.initState();
    _catalogCubit = context.read<CatalogCubit>();
    _categoryCubit = context.read<CategoryCubit>();
    _productCubit = context.read<ProductCubit>();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      await Future.wait([
        _catalogCubit.getCatalogs(),
        _categoryCubit.getCategories(),
        _productCubit.getProducts(),
      ]);
      if (mounted) {}
      if (_catalogCubit.state is CatalogError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_catalogCubit.state.toString())),
        );
      } else if (_categoryCubit.state is CategoryError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_categoryCubit.state.toString())),
        );
      } else if (_productCubit.state is ProductError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_productCubit.state.toString())),
        );
      } else {
        _navigateToHome();
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomeView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primary[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            appName,
            animatedProgressIndicator,
          ],
        ),
      ),
    );
  }

  Widget get appName {
    return Hero(
      tag: 'app-name',
      child: Material(
        color: Colors.transparent,
        child: Text(
          StringConstants.appName,
          style: AppFonts.headingMedium,
        ),
      ),
    );
  }

  Widget get animatedProgressIndicator {
    return AnimatedOpacity(
      opacity: _showProgressIndicator ? 1 : 0,
      duration: const Duration(milliseconds: 1500),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: CircularProgressIndicator(
          color: ColorConstants.primary[100],
        ),
      ),
    );
  }
}
