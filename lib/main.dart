import 'package:e_commerce/constants/string_constants.dart';
import 'package:e_commerce/initialize/app_onset.dart';
import 'package:e_commerce/initialize/app_theme.dart';
import 'package:e_commerce/screens/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  AppOnset.init();
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
    return MaterialApp(
      title: StringConstants.appName,
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
    );
  }
}
